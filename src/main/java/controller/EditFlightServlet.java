/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.AirportDAO;
import dao.FlightDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Airport;
import model.Flight;

/**
 *
 * @author phant
 */
@WebServlet(urlPatterns = {"/EditFlightServlet"})
public class EditFlightServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            //lấy mã chuyến bay
            String flightId = request.getParameter("flightId"); 
            
            String departureTimeStr = request.getParameter("departureTime"); 
            double price = Double.parseDouble(request.getParameter("price"));
            int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
            
            // Xử lý chuyển đổi từ thẻ <input type="datetime-local"> sang Timestamp SQL
            LocalDateTime departureDateTime = LocalDateTime.parse(departureTimeStr);
            Timestamp departureTime = Timestamp.valueOf(departureDateTime);
            
            // LOGIC TỰ ĐỘNG CỘNG 2 TIẾNG
            LocalDateTime arrivalDateTime = departureDateTime.plusHours(2); 
            Timestamp arrivalTime = Timestamp.valueOf(arrivalDateTime);

            // Gọi DAO
            FlightDAO dao = new FlightDAO();
            boolean success = dao.updateFlight(flightId, departureTime, arrivalTime, price, totalSeats);

            if (success) {
                response.sendRedirect("adminFlights?msg=update_success");
            } else {
                response.getWriter().println("Cập nhật thất bại. Vui lòng kiểm tra lại ID chuyến bay!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi dữ liệu đầu vào: " + e.getMessage());
        }
    }
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
        try {
            // 1. Lấy flightId từ URL (?id=QH-5003)
            String id = request.getParameter("id");
            
            // 2. Gọi DAO để lấy toàn bộ thông tin chuyến bay từ DB
            FlightDAO dao = new FlightDAO();
            Flight flight = dao.getFlightById(id);
            AirportDAO Dao = new AirportDAO();
            Airport airportDi = Dao.getAirport(flight.getDepartureAirport());
            Airport airportDen = Dao.getAirport(flight.getDestinationAirport());
            // 3. Đặt đối tượng flight vào "yêu cầu" để JSP có thể đọc được
            request.setAttribute("f", flight);
            request.setAttribute("ad", airportDi);
            request.setAttribute("ade", airportDen);

            // 4. MỞ TRANG JSP (Chuyển tiếp yêu cầu và dữ liệu)
            request.getRequestDispatcher("admin_edit_flight.jsp").forward(request, response);
        } catch (SQLException ex) {
            System.getLogger(EditFlightServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }
}
