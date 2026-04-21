package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Airport;
import util.DBConnection;

public class AirportDAO {
    
    // Hàm 1: Lấy 1 sân bay theo mã (Dùng để hiển thị chi tiết)
    public Airport getAirport(String id) throws SQLException {
        String sql = "SELECT * FROM Airport WHERE airportCode = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Airport(rs.getString("airportCode"), rs.getString("airportName"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ====================================================================
    // Hàm 2 (MỚI THÊM): Lấy danh sách TẤT CẢ sân bay để đổ vào Dropdown
    // ====================================================================
    public List<Airport> getAllAirports() {
        List<Airport> list = new ArrayList<>();
        // Lấy tất cả và sắp xếp theo tên (A-Z) cho dễ tìm
        String sql = "SELECT * FROM Airport ORDER BY airportName ASC"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new Airport(
                    rs.getString("airportCode"), 
                    rs.getString("airportName")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi lấy danh sách sân bay: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}