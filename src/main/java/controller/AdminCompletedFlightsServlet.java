package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FlightDAO;
import model.Flight;
import model.FlightRevenue;

@WebServlet("/adminCompletedFlights")
public class AdminCompletedFlightsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	FlightDAO flightDAO = new FlightDAO();
        
        int recordsPerPage = 10;
        int currentPage = 1;
        if (req.getParameter("page") != null) {
            try { currentPage = Integer.parseInt(req.getParameter("page")); } catch (NumberFormatException e) { }
        }
        
        // Nhận tham số lọc Hãng bay
        String airline = req.getParameter("airline");
        int offset = (currentPage - 1) * recordsPerPage;
        
        // Lấy danh sách chuyến bay ĐÃ HOÀN THÀNH (< NOW()) và tổng doanh thu
        List<FlightRevenue> listFlights = flightDAO.getCompletedFlightsWithStats(offset, recordsPerPage, airline);
        int totalRecords = flightDAO.getCompletedFlightsCount(airline);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        req.setAttribute("flightList", listFlights);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("selectedAirline", airline != null ? airline : "ALL");
        
        req.getRequestDispatcher("admin_completed_flights.jsp").forward(req, resp);
    }
}