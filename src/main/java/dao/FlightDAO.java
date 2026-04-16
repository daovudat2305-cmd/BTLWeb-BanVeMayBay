package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Flight;
import util.DBConnection;

public class FlightDAO {
	public boolean insertFlight(String flightId, String airlineName, String departureAirport, 
            String destinationAirport, Timestamp departureTime, Timestamp arrivalTime, double price, int availableSeats) {

		// Cập nhật câu lệnh SQL khớp với tên cột mới trong Database
		String sql = "INSERT INTO Flight (flightId, airlineName, departureAirport, destinationAirport, departureTime, arrivalTime, price, availableSeats) "
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = DBConnection.getConnection();
		PreparedStatement ps = conn.prepareStatement(sql)) {
		
			ps.setString(1, flightId);
			ps.setString(2, airlineName);
			ps.setString(3, departureAirport); 
			ps.setString(4, destinationAirport);  
			ps.setTimestamp(5, departureTime);
			ps.setTimestamp(6, arrivalTime); // Lưu giờ đến đã cộng 2h
	        ps.setDouble(7, price);
	        ps.setInt(8, availableSeats);
			
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		
		} catch (SQLException e) {
			System.out.println("Lỗi khi thêm chuyến bay: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
    
    // lấy danh sách theo trang
    public List<Flight> getFlightsByPage(int offset, int limit) {
        List<Flight> list = new ArrayList<>();

        String sql = "SELECT f.*, "
                   + "dep.airportName AS depName, "
                   + "arr.airportName AS arrName "
                   + "FROM Flight f "
                   + "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode "
                   + "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode "
                   + "ORDER BY f.departureTime DESC LIMIT ? OFFSET ?"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Cập nhật lại lúc tạo đối tượng Flight (Đưa thêm depName và arrName vào)
                    Flight flight = new Flight(
                        rs.getString("flightId"), 
                        rs.getString("airlineName"),
                        rs.getString("departureAirport"), 
                        rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), 
                        rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), 
                        rs.getInt("availableSeats"),
                        rs.getString("depName"), // Lấy tên sân bay đi
                        rs.getString("arrName")  // Lấy tên sân bay đến
                    );
                    list.add(flight);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // tìm các vé rẻ nhất
    public List<Flight> getCheapestFlights(int limit) {
        List<Flight> list = new ArrayList<>();
        
        String sql = "SELECT f.*, "
                   + "dep.airportName AS depName, "
                   + "arr.airportName AS arrName "
                   + "FROM Flight f "
                   + "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode "
                   + "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode "
                   + "ORDER BY f.price ASC LIMIT ?"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Flight(
                        rs.getString("flightId"), 
                        rs.getString("airlineName"),
                        rs.getString("departureAirport"), 
                        rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), 
                        rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), 
                        rs.getInt("availableSeats"),
                        rs.getString("depName"), 
                        rs.getString("arrName")
                    ));
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getCheapestFlights: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // tìm vé theo id
    public Flight getFlightById(String flightId) {
        String sql = "SELECT f.*, "
                   + "dep.airportName AS depName, "
                   + "arr.airportName AS arrName "
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
                        rs.getString("flightId"), 
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
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getFlightById: " + e.getMessage());
            e.printStackTrace();
        }
        return null; 
    }

    // tổng số chuyến bay
    public int getTotalFlightsCount() {
        String sql = "SELECT COUNT(*) FROM Flight";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getTotalFlightsCount: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    // cập nhật thông tin chuyến bay
    public boolean updateFlight(String flightId, String airlineName, 
                                String departureAirport, String destinationAirport, 
                                String departureTime, double price, int availableSeats) {
 
        String query = "UPDATE Flight SET airlineName = ?, departureAirport = ?, "
                     + "destinationAirport = ?, departureTime = ?, price = ?, availableSeats = ? "
                     + "WHERE flightId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, airlineName);
            ps.setString(2, departureAirport);
            ps.setString(3, destinationAirport); 
            ps.setString(4, departureTime); 

            ps.setDouble(5, price);
            ps.setInt(6, availableSeats);
            ps.setString(7, flightId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // xóa 1 chuyến bay
    public boolean  deleteFlight(String id){
        String sql = "delete from Flight where flightId = ?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, id);
            return ps.executeUpdate()>0;
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return false;  
    }
    // tìm chuyến bay 
    public List<Flight> searchFlights(String depCode, String destCode) {
    List<Flight> list = new ArrayList<>();
    
    // Sử dụng TRIM và UPPER để loại bỏ lỗi thừa dấu cách hoặc sai chữ hoa/thường
    String query = "SELECT * FROM Flight WHERE TRIM(UPPER(departureAirport)) = TRIM(UPPER(?)) "
                 + "AND TRIM(UPPER(destinationAirport)) = TRIM(UPPER(?)) "
                 + "AND availableSeats > 0";

    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setString(1, depCode);
        ps.setString(2, destCode);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("flightId"), 
                        rs.getString("airlineName"),
                        rs.getString("departureAirport"), 
                        rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), 
                        rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), 
                        rs.getInt("availableSeats")
                        
                    ));
            }
        }
        System.out.println("Kết quả: Tìm thấy " + list.size() + " chuyến bay.");
        
    } catch (Exception e) {
        System.out.println("LỖI SQL: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}
    public List<Flight> searchWithFilter(String dep, String dest, String[] airlines) {
    List<Flight> list = new ArrayList<>();
    // 1. Khởi tạo câu SQL gốc
    StringBuilder sql = new StringBuilder(
        "SELECT * FROM Flight WHERE departureAirport = ? AND destinationAirport = ? AND availableSeats > 0"
    );
    // 2. Nếu khách có tích chọn ít nhất 1 hãng, ta thêm cụm: AND airlineName IN (?, ?, ...)
    if (airlines != null && airlines.length > 0) {
        sql.append(" AND airlineName IN (");
        for (int i = 0; i < airlines.length; i++) {
            sql.append("?");
            if (i < airlines.length - 1) sql.append(",");
        }
        sql.append(")");
    }
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
        // 3. Truyền tham số cho Điểm đi (1) và Điểm đến (2)
        ps.setString(1, dep);
        ps.setString(2, dest);

        // 4. Truyền tham số cho danh sách hãng (bắt đầu từ vị trí số 3 trở đi)
        if (airlines != null && airlines.length > 0) {
            for (int i = 0; i < airlines.length; i++) {
                ps.setString(i + 3, airlines[i]);
            }
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Flight(
                        rs.getString("flightId"), 
                        rs.getString("airlineName"),
                        rs.getString("departureAirport"), 
                        rs.getString("destinationAirport"),
                        rs.getTimestamp("departureTime"), 
                        rs.getTimestamp("arrivalTime"),
                        rs.getDouble("price"), 
                        rs.getInt("availableSeats")       
                    ));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
    }
}
