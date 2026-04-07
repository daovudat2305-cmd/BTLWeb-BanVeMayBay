package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;
import util.DBConnection;
import util.PasswordUtil;

public class UserDAO {
	
	public static boolean checkUsernameExist(String username) {
		String sql = "SELECT 1 FROM User WHERE username = ?";
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			
			ps.setString(1, username);
			
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean checkEmailExist(String email) {
		String sql = "SELECT 1 FROM User WHERE email = ?";
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			
			ps.setString(1, email);
			
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean registerUser(String username, String email, String password, String fullName) {
		String sql = "INSERT INTO User(username, email, password, fullName, role) VALUES (?, ?, ?, ?, 'USER')";
		
		String hashedPassword = PasswordUtil.hashPassword(password);
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			
			ps.setString(1, username);
			ps.setString(2, email);
			ps.setString(3, hashedPassword);
			ps.setString(4, fullName);
			
			return ps.executeUpdate() > 0;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static User verifyLogin(String username, String password, String role) {
		String sql = "SELECT * FROM User WHERE (username = ? OR email = ?) AND password = ? AND role=?";
		String hashedPassword = PasswordUtil.hashPassword(password);
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			
			ps.setString(1, username);
			ps.setString(2, username); 
			ps.setString(3, hashedPassword);
			ps.setString(4, role);
			
			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
					User user = new User();
					user.setUsername(rs.getString("username"));
					user.setEmail(rs.getString("email"));
					user.setFullName(rs.getString("fullName"));
					user.setPassword(rs.getString("password"));
					user.setRole(rs.getString("role"));
					return user;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
