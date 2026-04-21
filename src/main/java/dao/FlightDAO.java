package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Flight;
import model.FlightRevenue;
import util.DBConnection;

public class FlightDAO {

    // ====================================================================================
    // PHẦN 1: CÁC HÀM THÊM, SỬA, XÓA CHUYẾN BAY (CRUD CƠ BẢN)
    // ====================================================================================

    public boolean insertFlight(String flightId, String airlineName, String departureAirport, 
            String destinationAirport, Timestamp departureTime, Timestamp arrivalTime, double price, int availableSeats) {

        String sql = "INSERT INTO Flight (flightId, airlineName, departureAirport, destinationAirport, departureTime, arrivalTime, price, availableSeats) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        
            ps.setString(1, flightId);
            ps.setString(2, airlineName);
            ps.setString(3, departureAirport); 
            ps.setString(4, destinationAirport);  
            ps.setTimestamp(5, departureTime);
            ps.setTimestamp(6, arrivalTime); 
            ps.setDouble(7, price);
            ps.setInt(8, availableSeats);
            
            return ps.executeUpdate() > 0;
        
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm chuyến bay: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateFlight(String flightId, Timestamp departureTime, Timestamp arrivalTime, double price, int availableSeats) {
        String query = "UPDATE Flight SET departureTime = ?, arrivalTime = ?, price = ?, availableSeats = ? WHERE flightId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setTimestamp(1, departureTime);
            ps.setTimestamp(2, arrivalTime);
            ps.setDouble(3, price);
            ps.setInt(4, availableSeats);
            ps.setString(5, flightId);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Lỗi updateFlight: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteFlight(String id){
        String sql = "DELETE FROM Flight WHERE flightId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return false;  
    }

    public Flight getFlightById(String flightId) {
        String sql = "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName "
                   + "FROM Flight f "
                   + "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode "
                   + "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode "
                   + "WHERE f.flightId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, flightId); 
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Flight(
                        rs.getString("flightId"), rs.getString("airlineName"),
                        rs.getString("departureAirport"), rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), rs.getInt("availableSeats"),
                        rs.getString("depName"), rs.getString("arrName")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null; 
    }


    // ====================================================================================
    // PHẦN 2: LẤY DANH SÁCH & LỌC CHUYẾN BAY (DÀNH CHO NGƯỜI DÙNG TÌM VÉ)
    // ====================================================================================

    public List<Flight> searchWithFilter(String depCode, String destCode, String departDate, String departTime, String[] airlines) {
        List<Flight> list = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName " +
            "FROM Flight f " +
            "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode " +
            "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode " +
            "WHERE f.departureAirport = ? AND f.destinationAirport = ? " +
            "AND f.availableSeats > 0 AND f.departureTime >= ? " // Đã sửa NOW() thành ?
        );

        if (departDate != null && !departDate.trim().isEmpty()) sql.append(" AND DATE(f.departureTime) = ? ");
        if (departTime != null && !departTime.trim().isEmpty()) sql.append(" AND TIME(f.departureTime) >= ? ");
        
        if (airlines != null && airlines.length > 0) {
            sql.append(" AND f.airlineName IN (");
            for (int i = 0; i < airlines.length; i++) {
                sql.append("?");
                if (i < airlines.length - 1) sql.append(",");
            }
            sql.append(") ");
        }
        
        sql.append(" ORDER BY f.departureTime ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            ps.setString(paramIndex++, depCode);
            ps.setString(paramIndex++, destCode);
            
            // Truyền giờ hiện tại của Java
            ps.setTimestamp(paramIndex++, new Timestamp(System.currentTimeMillis()));
            
            if (departDate != null && !departDate.trim().isEmpty()) ps.setString(paramIndex++, departDate);
            if (departTime != null && !departTime.trim().isEmpty()) ps.setString(paramIndex++, departTime); 
            
            if (airlines != null && airlines.length > 0) {
                for (String airline : airlines) ps.setString(paramIndex++, airline);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                    rs.getString("flightId"), rs.getString("airlineName"),
                    rs.getString("departureAirport"), rs.getString("destinationAirport"),
                    rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                    rs.getDouble("price"), rs.getInt("availableSeats"),
                    rs.getString("depName"), rs.getString("arrName")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Flight> getCheapestFlights(int limit) {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName "
                   + "FROM Flight f "
                   + "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode "
                   + "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode "
                   + "WHERE f.departureTime >= ? " // Đã sửa
                   + "ORDER BY f.price ASC LIMIT ?"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Truyền giờ hiện tại
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Flight(
                        rs.getString("flightId"), rs.getString("airlineName"),
                        rs.getString("departureAirport"), rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), rs.getInt("availableSeats"),
                        rs.getString("depName"), rs.getString("arrName")
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }


    // ====================================================================================
    // PHẦN 3: QUẢN LÝ CHUYẾN BAY CỦA ADMIN (CHỈ XEM/SỬA CÁC CHUYẾN CHƯA BAY)
    // ====================================================================================

    public int getTotalFlightsCountWithFilter(String airline, String date, String time, String dep, String dest) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Flight f WHERE f.departureTime >= ? ");
        List<Object> params = new ArrayList<>();
        
        // Truyền giờ hiện tại
        params.add(new Timestamp(System.currentTimeMillis()));

        if (airline != null && !airline.trim().isEmpty() && !airline.equals("ALL")) {
            sql.append(" AND f.airlineName = ? ");
            params.add(airline);
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND DATE(f.departureTime) = ? ");
            params.add(date);
        }
        if (time != null && !time.trim().isEmpty()) {
            sql.append(" AND TIME(f.departureTime) >= ? ");
            params.add(time);
        }
        if (dep != null && !dep.trim().isEmpty() && !dep.equals("ALL")) {
            sql.append(" AND f.departureAirport = ? ");
            params.add(dep);
        }
        if (dest != null && !dest.trim().isEmpty() && !dest.equals("ALL")) {
            sql.append(" AND f.destinationAirport = ? ");
            params.add(dest);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<Flight> getFlightsByPageWithFilter(int offset, int limit, String airline, String date, String time, String dep, String dest) {
        List<Flight> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName " +
            "FROM Flight f " +
            "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode " +
            "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode " +
            "WHERE f.departureTime >= ? " // Đã sửa
        );
        List<Object> params = new ArrayList<>();
        
        // Truyền giờ hiện tại
        params.add(new Timestamp(System.currentTimeMillis()));

        if (airline != null && !airline.trim().isEmpty() && !airline.equals("ALL")) {
            sql.append(" AND f.airlineName = ? "); params.add(airline);
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND DATE(f.departureTime) = ? "); params.add(date);
        }
        if (time != null && !time.trim().isEmpty()) {
            sql.append(" AND TIME(f.departureTime) >= ? "); params.add(time);
        }
        if (dep != null && !dep.trim().isEmpty() && !dep.equals("ALL")) {
            sql.append(" AND f.departureAirport = ? "); params.add(dep);
        }
        if (dest != null && !dest.trim().isEmpty() && !dest.equals("ALL")) {
            sql.append(" AND f.destinationAirport = ? "); params.add(dest);
        }

        sql.append(" ORDER BY f.departureTime ASC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Flight(
                        rs.getString("flightId"), rs.getString("airlineName"),
                        rs.getString("departureAirport"), rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), rs.getInt("availableSeats"),
                        rs.getString("depName"), rs.getString("arrName")
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }


    // ====================================================================================
    // PHẦN 4: THỐNG KÊ DOANH THU & CHUYẾN BAY ĐÃ HOÀN THÀNH
    // ====================================================================================

    public int getCompletedFlightsCount(String airline) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Flight f WHERE f.departureTime < ? ");
        List<Object> params = new ArrayList<>();
        
        // Truyền giờ hiện tại
        params.add(new Timestamp(System.currentTimeMillis()));
        
        if (airline != null && !airline.trim().isEmpty() && !airline.equals("ALL")) {
            sql.append(" AND f.airlineName = ?");
            params.add(airline);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for(int i = 0; i < params.size(); i++){
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<FlightRevenue> getCompletedFlightsWithStats(int offset, int limit, String airline) {
        List<FlightRevenue> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName, " +
            "COUNT(CASE WHEN b.status = 'APPROVED' THEN 1 END) AS ticketsSold, " +
            "SUM(CASE WHEN b.status = 'APPROVED' THEN f.price ELSE 0 END) AS totalRevenue " +
            "FROM Flight f " +
            "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode " +
            "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode " +
            "LEFT JOIN Booking b ON f.flightId = b.flightId " +
            "WHERE f.departureTime < ? " // Đã sửa
        );

        if (airline != null && !airline.equals("ALL")) sql.append(" AND f.airlineName = ? ");
        
        sql.append(" GROUP BY f.flightId, dep.airportName, arr.airportName ORDER BY f.departureTime DESC LIMIT ? OFFSET ?");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int idx = 1;
            // Truyền giờ hiện tại
            ps.setTimestamp(idx++, new Timestamp(System.currentTimeMillis()));

            if (airline != null && !airline.equals("ALL")) ps.setString(idx++, airline);
            ps.setInt(idx++, limit);
            ps.setInt(idx++, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Flight f = new Flight(
                    rs.getString("flightId"), rs.getString("airlineName"),
                    rs.getString("departureAirport"), rs.getString("destinationAirport"),
                    rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                    rs.getDouble("price"), rs.getInt("availableSeats"),
                    rs.getString("depName"), rs.getString("arrName")
                );
                list.add(new FlightRevenue(f, rs.getInt("ticketsSold"), rs.getDouble("totalRevenue")));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }


    // ====================================================================================
    // PHẦN 5: CÁC HÀM TIỆN ÍCH KHÁC
    // ====================================================================================

    public int getActiveFlightsCount() {
        String sql = "SELECT COUNT(*) FROM Flight WHERE departureTime > ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            
            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    
    public int getTotalFlightsCount() {
        String sql = "SELECT COUNT(*) FROM Flight WHERE departureTime >= ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            
            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<Flight> getFlightsByPage(int offset, int limit) {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName "
                   + "FROM Flight f "
                   + "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode "
                   + "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode "
                   + "WHERE f.departureTime >= ? " 
                   + "ORDER BY f.departureTime ASC LIMIT ? OFFSET ?"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Flight(
                        rs.getString("flightId"), rs.getString("airlineName"),
                        rs.getString("departureAirport"), rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), rs.getInt("availableSeats"),
                        rs.getString("depName"), rs.getString("arrName")
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean flightIdExists(String flightId) {
        String sql = "SELECT 1 FROM Flight WHERE flightId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, flightId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public String generateUniqueFlightId(String airlineName) {
        String prefix = "FL"; 
        if (airlineName != null) {
            if (airlineName.contains("Vietjet")) prefix = "VJ";
            else if (airlineName.contains("Vietnam Airlines")) prefix = "VN";
            else if (airlineName.contains("Bamboo")) prefix = "QH";
            else if (airlineName.contains("Vietravel")) prefix = "VU";
            else if (airlineName.contains("Pacific")) prefix = "BL";
        }
        
        String flightId;
        while (true) {
            int randomNum = 1000 + (int)(Math.random() * 9000); 
            flightId = prefix + "-" + randomNum;
            if (!flightIdExists(flightId)) break; 
        }
        return flightId;
    }
}