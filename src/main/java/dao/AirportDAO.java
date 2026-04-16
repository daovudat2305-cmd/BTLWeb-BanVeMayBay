/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.sun.jdi.connect.spi.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Airport;
import util.DBConnection;

/**
 *
 * @author phant
 */
public class AirportDAO {
    public Airport getAirport(String id) throws SQLException{
        String sql = "select * from Airport where airportCode = ?";
        try (java.sql.Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setString(1, id); 
            
            try (ResultSet rs = ps.executeQuery()){
                 if(rs.next()){
                     return new Airport(
                             rs.getString("airportCode"),
                             rs.getString("airportName")
                     );
                 }
            }
        }
        catch(Exception e){
            System.out.println("Lỗi getAirportCode: " + e.getMessage());
            e.printStackTrace();
        }
        return null;          
    } 
    
}
