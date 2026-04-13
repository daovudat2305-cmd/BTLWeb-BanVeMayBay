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

@WebServlet(urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FlightDAO flightDAO = new FlightDAO();
        
        // lấy 4 vé rẻ nhất
        List<Flight> cheapestFlights = flightDAO.getCheapestFlights(4);
        req.setAttribute("cheapestFlights", cheapestFlights);
        
        // phân trang vé ở dưới
        int recordsPerPage = 12; 
        int currentPage = 1;
        
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            currentPage = Integer.parseInt(pageParam);
        }
        
        int offset = (currentPage - 1) * recordsPerPage;
        
        // Lấy danh sách chuyến bay theo trang
        List<Flight> regularFlights = flightDAO.getFlightsByPage(offset, recordsPerPage);
        int totalRecords = flightDAO.getTotalFlightsCount();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        // Đẩy dữ liệu sang JSP
        req.setAttribute("regularFlights", regularFlights);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        
        req.getRequestDispatcher("index.jsp").forward(req, resp);
	}
}
