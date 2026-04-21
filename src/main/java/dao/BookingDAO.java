package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import model.Booking;
import model.Flight;
import util.DBConnection;

public class BookingDAO {
    private static final String BOOKING_SELECT =
        "SELECT b.bookingId, b.username, b.flightId AS bookedFlightId, b.passengerName, "
            + "b.cccd, b.phone, b.email, b.bookingTime, b.status, "
            + "f.airlineName, f.departureAirport, f.destinationAirport, "
            + "f.departureTime, f.arrivalTime, f.price, f.availableSeats, "
            + "dep.airportName AS depName, arr.airportName AS arrName "
            + "FROM Booking b "
            + "LEFT JOIN Flight f ON b.flightId = f.flightId "
            + "LEFT JOIN Airport dep ON f.departureAirport = dep.airportCode "
            + "LEFT JOIN Airport arr ON f.destinationAirport = arr.airportCode ";

    public String createBooking(String username, String flightId, String passengerName, String cccd, String phone, String email) {
        String updateSeatsSql =
            "UPDATE Flight SET availableSeats = availableSeats - 1 WHERE flightId = ? AND availableSeats > 0";
        String insertBookingSql =
            "INSERT INTO Booking(bookingId, username, flightId, passengerName, cccd, phone, email, bookingTime, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                return null;
            }

            conn.setAutoCommit(false);

            try {
                String bookingId = generateUniqueBookingId(conn);

                try (PreparedStatement updateSeats = conn.prepareStatement(updateSeatsSql)) {
                    updateSeats.setString(1, flightId);

                    if (updateSeats.executeUpdate() == 0) {
                        conn.rollback();
                        return null;
                    }
                }

                try (PreparedStatement insertBooking = conn.prepareStatement(insertBookingSql)) {
                    insertBooking.setString(1, bookingId);
                    insertBooking.setString(2, username);
                    insertBooking.setString(3, flightId);
                    insertBooking.setString(4, passengerName);
                    insertBooking.setString(5, cccd);
                    insertBooking.setString(6, phone);
                    insertBooking.setString(7, email);
                    insertBooking.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
                    insertBooking.setString(9, "PENDING");
                    insertBooking.executeUpdate();
                }

                conn.commit();
                return bookingId;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public Booking getBookingByIdForUser(String bookingId, String username) {
        String sql = BOOKING_SELECT + "WHERE b.bookingId = ? AND b.username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, bookingId);
            ps.setString(2, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Lấy danh sách lịch sử đặt vé của User
    public List<Booking> getBookingsByUsernameWithFilter(String username, String status, String bookingDate, String flightDate) {
        List<Booking> bookings = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BOOKING_SELECT + "WHERE b.username = ? ");
        List<Object> params = new ArrayList<>();
        params.add(username);

        // 1. Lọc theo trạng thái
        if (status != null && !status.trim().isEmpty() && !status.equals("ALL")) {
            sql.append(" AND b.status = ? ");
            params.add(status);
        }
        
        // 2. Lọc theo ngày ĐẶT VÉ 
        if (bookingDate != null && !bookingDate.trim().isEmpty()) {
            sql.append(" AND DATE(b.bookingTime) = ? ");
            params.add(bookingDate);
        }

        // 3. Lọc theo ngày BAY
        if (flightDate != null && !flightDate.trim().isEmpty()) {
            sql.append(" AND DATE(f.departureTime) = ? ");
            params.add(flightDate);
        }

        sql.append(" ORDER BY b.bookingTime DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    private String generateUniqueBookingId(Connection conn) throws SQLException {
        for (int i = 0; i < 10; i++) {
            String bookingId = UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();

            if (!bookingIdExists(conn, bookingId)) {
                return bookingId;
            }
        }

        throw new SQLException("Unable to generate unique booking id");
    }

    private boolean bookingIdExists(Connection conn, String bookingId) throws SQLException {
        String sql = "SELECT 1 FROM Booking WHERE bookingId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getString("bookingId"));
        booking.setUsername(rs.getString("username"));
        booking.setFlightId(rs.getString("bookedFlightId"));
        booking.setPassengerName(rs.getString("passengerName"));
        booking.setCccd(rs.getString("cccd"));
        booking.setPhone(rs.getString("phone"));
        booking.setEmail(rs.getString("email"));
        booking.setBookingTime(rs.getTimestamp("bookingTime"));
        booking.setStatus(rs.getString("status"));

        Flight flight = new Flight(
            rs.getString("bookedFlightId"),
            rs.getString("airlineName"),
            rs.getString("departureAirport"),
            rs.getString("destinationAirport"),
            rs.getTimestamp("departureTime"),
            rs.getTimestamp("arrivalTime"),
            rs.getDouble("price"),
            rs.getInt("availableSeats"),
            rs.getString("depName"),
            rs.getString("arrName")
        );
        booking.setFlight(flight);

        return booking;
    }
    
    
    // admin lấy toàn bộ danh sách đặt vé
    // tổng số lượng vé (CÓ TÌM KIẾM VÀ LỌC)
    public int getTotalBookingsCount(String search, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Booking b WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (b.bookingId LIKE ? OR b.passengerName LIKE ? OR b.cccd LIKE ?) ");
            String likeSearch = "%" + search.trim() + "%";
            params.add(likeSearch); params.add(likeSearch); params.add(likeSearch);
        }
        if (status != null && !status.trim().isEmpty() && !status.equals("ALL")) {
            sql.append(" AND b.status = ? ");
            params.add(status);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // lấy danh sách vé (CÓ PHÂN TRANG, TÌM KIẾM VÀ LỌC)
    public List<Booking> getBookingsByPage(int offset, int limit, String search, String status) {
        List<Booking> bookings = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BOOKING_SELECT + "WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (b.bookingId LIKE ? OR b.passengerName LIKE ? OR b.cccd LIKE ?) ");
            String likeSearch = "%" + search.trim() + "%";
            params.add(likeSearch); params.add(likeSearch); params.add(likeSearch);
        }
        if (status != null && !status.trim().isEmpty() && !status.equals("ALL")) {
            sql.append(" AND b.status = ? ");
            params.add(status);
        }

        sql.append(" ORDER BY b.bookingTime DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
    
    //admin duyệt chuyến bay
    public boolean updateBookingStatus(String bookingId, String newStatus) {
        String getFlightIdSql = "SELECT flightId, status FROM Booking WHERE bookingId = ?";
        String updateStatusSql = "UPDATE Booking SET status = ? WHERE bookingId = ?";
        String restoreSeatSql = "UPDATE Flight SET availableSeats = availableSeats + 1 WHERE flightId = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction
            try {
                String flightId = null;
                String oldStatus = null;

                // lấy thông tin chuyến bay và trạng thái cũ
                try (PreparedStatement ps = conn.prepareStatement(getFlightIdSql)) {
                    ps.setString(1, bookingId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        flightId = rs.getString("flightId");
                        oldStatus = rs.getString("status");
                    }
                }

                // cập nhật trạng thái mới
                try (PreparedStatement ps = conn.prepareStatement(updateStatusSql)) {
                    ps.setString(1, newStatus);
                    ps.setString(2, bookingId);
                    ps.executeUpdate();
                }

                // nếu chuyển từ trạng thái khác sang REJECTED, khôi phục ghế
                if ("REJECTED".equals(newStatus) && !"REJECTED".equals(oldStatus)) {
                    try (PreparedStatement ps = conn.prepareStatement(restoreSeatSql)) {
                        ps.setString(1, flightId);
                        ps.executeUpdate();
                    }
                }

                conn.commit(); // Hoàn tất
                return true;
            } catch (SQLException e) {
                conn.rollback(); // Lỗi thì quay lại
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //thống kê
 // Đếm tổng số vé ĐÃ BÁN (Chỉ tính các vé có trạng thái APPROVED)
    public int getTotalTicketsSold() {
        String sql = "SELECT COUNT(*) FROM Booking WHERE status = 'APPROVED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tính tổng doanh thu (Cộng dồn giá vé của các đơn APPROVED)
    public double getTotalRevenue() {
        String sql = "SELECT SUM(f.price) FROM Booking b INNER JOIN Flight f ON b.flightId = f.flightId WHERE b.status = 'APPROVED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
