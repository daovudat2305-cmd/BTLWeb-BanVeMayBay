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
    public boolean updateFlight(String flightId, 
    		Timestamp departureTime, Timestamp arrivalTime, 
    		double price, int availableSeats) {
    	
        String query = "UPDATE Flight SET departureTime = ?, arrivalTime = ?, price = ?, availableSeats = ? WHERE flightId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            // 2. Truyền tham số đúng kiểu dữ liệu
            ps.setTimestamp(1, departureTime);
            ps.setTimestamp(2, arrivalTime);
            ps.setDouble(3, price);
            ps.setInt(4, availableSeats);
            
            // 3. Truyền Mã chuyến bay cho điều kiện WHERE
            ps.setString(5, flightId);

            // 4. Thực thi và kiểm tra xem có dòng nào được cập nhật không
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Lỗi updateFlight: " + e.getMessage());
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
    
    public List<Flight> searchWithFilter(String depCode, String destCode, String departDate, String departTime, String[] airlines) {
        List<Flight> list = new ArrayList<>();
        
        // 1. Khởi tạo câu SQL gốc (Có JOIN với bảng Airport để lấy Tên sân bay)
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName " +
            "FROM Flight f " +
            "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode " +
            "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode " +
            "WHERE f.departureAirport = ? AND f.destinationAirport = ? AND f.availableSeats > 0 "
        );

        // 2. Lọc theo Ngày đi
        if (departDate != null && !departDate.trim().isEmpty()) {
            sql.append(" AND DATE(f.departureTime) = ? ");
        }

        // 3. Lọc theo Giờ đi (Lấy từ giờ đó trở đi)
        if (departTime != null && !departTime.trim().isEmpty()) {
            sql.append(" AND TIME(f.departureTime) >= ? ");
        }

        // 4. Lọc theo danh sách Hãng hàng không (nếu có check ở giao diện)
        if (airlines != null && airlines.length > 0) {
            sql.append(" AND f.airlineName IN (");
            for (int i = 0; i < airlines.length; i++) {
                sql.append("?");
                if (i < airlines.length - 1) sql.append(",");
            }
            sql.append(") ");
        }
        
        // 5. Sắp xếp giờ bay sớm nhất lên đầu
        sql.append(" ORDER BY f.departureTime ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            ps.setString(paramIndex++, depCode);
            ps.setString(paramIndex++, destCode);
            
            if (departDate != null && !departDate.trim().isEmpty()) {
                ps.setString(paramIndex++, departDate);
            }
            if (departTime != null && !departTime.trim().isEmpty()) {
                ps.setString(paramIndex++, departTime); 
            }
            if (airlines != null && airlines.length > 0) {
                for (String airline : airlines) {
                    ps.setString(paramIndex++, airline);
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
                    rs.getInt("availableSeats"),
                    rs.getString("depName"), // Tên sân bay đi đã JOIN
                    rs.getString("arrName")  // Tên sân bay đến đã JOIN
                ));
            }
        } catch (Exception e) {
            System.out.println("LỖI SEARCH WITH FILTER: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    // Đếm số chuyến bay ĐANG HOẠT ĐỘNG (Chưa cất cánh)
    public int getActiveFlightsCount() {
        // Dùng NOW() để so sánh, chỉ lấy các chuyến bay có giờ khởi hành ở tương lai
        String sql = "SELECT COUNT(*) FROM Flight WHERE departureTime > NOW()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
    // sinh số hiệu chuyến bay
    // Kiểm tra xem mã đã tồn tại trong DB chưa
    public boolean flightIdExists(String flightId) {
        String sql = "SELECT 1 FROM Flight WHERE flightId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, flightId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Sinh mã ngẫu nhiên dựa trên tên hãng
    public String generateUniqueFlightId(String airlineName) {
        String prefix = "FL"; // Mặc định
        
        // Nhận diện tiền tố chuẩn của các hãng hàng không VN
        if (airlineName != null) {
            if (airlineName.contains("Vietjet")) prefix = "VJ";
            else if (airlineName.contains("Vietnam Airlines")) prefix = "VN";
            else if (airlineName.contains("Bamboo")) prefix = "QH";
            else if (airlineName.contains("Vietravel")) prefix = "VU";
            else if (airlineName.contains("Pacific")) prefix = "BL";
        }
        
        String flightId;
        // Lặp vô hạn tạo mã đến khi nào không bị trùng trong DB thì thôi
        while (true) {
            int randomNum = 1000 + (int)(Math.random() * 9000); // Tạo số ngẫu nhiên từ 1000 - 9999
            flightId = prefix + "-" + randomNum;
            
            if (!flightIdExists(flightId)) {
                break; // Thoát vòng lặp nếu mã này chưa ai dùng
            }
        }
        return flightId;
    }
    
    //admin quản lý chuyến bay
    //tổng chuyến bay
    public int getTotalFlightsCountWithFilter(String airline, String date, String time, String dep, String dest) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Flight f WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

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

    //danh sách chuyến bay theo bộ lọc và phân trang
    public List<Flight> getFlightsByPageWithFilter(int offset, int limit, String airline, String date, String time, String dep, String dest) {
        List<Flight> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, dep.airportName AS depName, arr.airportName AS arrName " +
            "FROM Flight f " +
            "INNER JOIN Airport dep ON f.departureAirport = dep.airportCode " +
            "INNER JOIN Airport arr ON f.destinationAirport = arr.airportCode " +
            "WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

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

        sql.append(" ORDER BY f.departureTime DESC LIMIT ? OFFSET ?");
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
}
