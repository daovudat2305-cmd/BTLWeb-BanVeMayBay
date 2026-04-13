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

@WebServlet("/adminFlights")
public class AdminFlightListServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FlightDAO flightDAO = new FlightDAO();
        
        int recordsPerPage = 10;
        int currentPage = 1;
        
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            currentPage = Integer.parseInt(pageParam);
        }
        
        int offset = (currentPage - 1) * recordsPerPage;
        
        List<Flight> listFlights = flightDAO.getFlightsByPage(offset, recordsPerPage);
        int totalRecords = flightDAO.getTotalFlightsCount();
        
        // tổng trang
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        req.setAttribute("flightList", listFlights);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        
        req.getRequestDispatcher("admin_flight_list.jsp").forward(req, resp);
	}
}
