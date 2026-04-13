package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FlightDAO;

@WebServlet(urlPatterns = {"/addFlight"})
public class AddFlightServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		try {
            // 1. Lấy dữ liệu trực tiếp từ các trường input trong Form
            String airlineName = req.getParameter("airline");
            String flightId = req.getParameter("flightNumber");
            
            // Ở phiên bản mới, ta CHỈ CẦN LẤY MÃ (depCode, destCode), bỏ qua tên dài
            String departureAirport = req.getParameter("depCode");
            String destinationAirport = req.getParameter("destCode");
            
            String departureTimeStr = req.getParameter("departureTime");
            String priceStr = req.getParameter("price");
            String totalSeatsStr = req.getParameter("totalSeats");

            // 2. Chuyển đổi kiểu dữ liệu (String -> Số, String -> Datetime)
            double price = Double.parseDouble(priceStr);
            int availableSeats = Integer.parseInt(totalSeatsStr);
            
            // Xử lý chuyển đổi từ thẻ <input type="datetime-local"> sang Timestamp SQL
            LocalDateTime departureDateTime = LocalDateTime.parse(departureTimeStr);
            Timestamp departureTime = Timestamp.valueOf(departureDateTime);
            
         // LOGIC TỰ ĐỘNG CỘNG 2 TIẾNG
            LocalDateTime arrivalDateTime = departureDateTime.plusHours(2); 
            Timestamp arrivalTime = Timestamp.valueOf(arrivalDateTime);
            
            // 3. Gọi DAO để thực hiện lệnh INSERT
            FlightDAO flightDAO = new FlightDAO();
            boolean isSuccess = flightDAO.insertFlight(flightId, airlineName, departureAirport, destinationAirport, departureTime, arrivalTime, price, availableSeats);
            
            // 4. Kiểm tra kết quả và chuyển trang
            if (isSuccess) {
                // Thêm thành công -> Chuyển về trang danh sách (Có thể thêm tham số msg để hiển thị thông báo)
                resp.sendRedirect("adminFlights?msg=success");
            } else {
                // Thêm thất bại -> Ở lại trang thêm mới
                resp.sendRedirect("adminFlights?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("Lỗi Servlet: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("adminFlights?msg=exception");
        }
	}
}
