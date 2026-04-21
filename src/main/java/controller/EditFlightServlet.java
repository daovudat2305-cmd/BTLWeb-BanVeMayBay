package controller;

import dao.AirportDAO;
import dao.FlightDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Airport;
import model.Flight;

@WebServlet(urlPatterns = {"/EditFlightServlet"})
public class EditFlightServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        // 1. Lấy flightId từ URL (?id=QH-5003)
        String id = request.getParameter("id");
        // 2. Lấy thông tin chuyến bay hiện tại
        FlightDAO flightDao = new FlightDAO();
        Flight flight = flightDao.getFlightById(id);
        // 3. Lấy TẤT CẢ danh sách sân bay để đổ vào Dropdown
        AirportDAO airportDao = new AirportDAO();
        List<Airport> listA = airportDao.getAllAirports();
        // 4. Đẩy dữ liệu sang JSP
        request.setAttribute("f", flight);
        request.setAttribute("listA", listA); // Dòng này giúp Dropdown có dữ liệu
        // 5. Chuyển tiếp sang trang JSP
        request.getRequestDispatcher("admin_edit_flight.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            // 1. Lấy ID cũ (để tìm dòng cần sửa) và ID mới
            String oldFlightId = request.getParameter("oldFlightId"); 
            String newFlightId = request.getParameter("newFlightId"); 
            
            // 2. Lấy dữ liệu từ các Dropdown mới thêm
            String airlineName = request.getParameter("airlineName");
            String departureAirport = request.getParameter("departureAirport");
            String destinationAirport = request.getParameter("destinationAirport");
            
            // 3. Lấy các dữ liệu còn lại
            String departureTimeStr = request.getParameter("departureTime"); 
            double price = Double.parseDouble(request.getParameter("price"));
            int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
            
            // 4. Xử lý thời gian (Cộng 2 tiếng cho giờ đến)
            LocalDateTime departureDateTime = LocalDateTime.parse(departureTimeStr);
            Timestamp departureTime = Timestamp.valueOf(departureDateTime);
            Timestamp arrivalTime = Timestamp.valueOf(departureDateTime.plusHours(2)); 

            // 5. Đóng gói dữ liệu vào Object Flight
            Flight updatedFlight = new Flight(newFlightId, airlineName, departureAirport, 
                                              destinationAirport, departureTime, arrivalTime, 
                                              price, totalSeats);

            // 6. Gọi DAO thực hiện UPDATE
            FlightDAO dao = new FlightDAO();
            // Lưu ý: Dùng updateFlightFull để sửa được cả mã chuyến bay, hãng, sân bay
            boolean success = dao.updateFlightFull(oldFlightId, updatedFlight);

            if (success) {
                response.sendRedirect("adminFlights?msg=update_success");
            } else {
                response.getWriter().println("Cập nhật thất bại. Có thể mã chuyến bay mới đã bị trùng!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi dữ liệu đầu vào: " + e.getMessage());
        }
    }
}