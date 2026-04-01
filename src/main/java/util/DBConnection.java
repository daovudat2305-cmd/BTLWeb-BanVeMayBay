package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		final String url = "jdbc:mysql://44NuFHUT7nncDeg.root:q4DVdeOWvHzP14rx@gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/test?sslMode=VERIFY_IDENTITY";
		final String user = "44NuFHUT7nncDeg.root";
		final String password = "q4DVdeOWvHzP14rx";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			return DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) {
		if(getConnection()!=null) {
			System.out.println("thanh cong");
		}
		else {
			System.out.println("that bai");
		}
	}
}
