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
            + "b.cccd, b.phone, b.email, b.bookingTime, b.status, b.returnFlightId, "
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
            "INSERT INTO Booking(bookingId, username, flightId, passengerName, cccd, phone, email, bookingTime, status, returnFlightId) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
                    insertBooking.setString(9, "CONFIRMED");
                    insertBooking.setString(10, null);
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

    public List<Booking> getBookingsByUsername(String username) {
        List<Booking> bookings = new ArrayList<>();
        String sql = BOOKING_SELECT + "WHERE b.username = ? ORDER BY b.bookingTime DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

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
        booking.setReturnFlightId(rs.getString("returnFlightId"));

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
}
