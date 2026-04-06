package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Book;

public class BookDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/ThuVienDB";
    private String jdbcUsername = "root";
    private String jdbcPassword = "tiem08052005*";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    // Kiểm tra xem bookcode đã tồn tại chưa
    public boolean checkBookCodeExists(String bookcode) {
        boolean exists = false;
        String sql = "SELECT bookcode FROM Book WHERE bookcode = ?";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, bookcode);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    // Thêm sách mới vào CSDL
    public boolean insertBook(Book book) {
        boolean rowInserted = false;
        String sql = "INSERT INTO Book (bookcode, title, author, category) VALUES (?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, book.getBookcode());
            preparedStatement.setString(2, book.getTitle());
            preparedStatement.setString(3, book.getAuthor());
            preparedStatement.setString(4, book.getCategory());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }
}