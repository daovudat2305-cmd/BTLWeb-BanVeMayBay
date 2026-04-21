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
        if (req.getParameter("page") != null) {
            try { currentPage = Integer.parseInt(req.getParameter("page")); } catch (NumberFormatException e) { }
        }
        
        // 1. Nhận tham số lọc
        String airline = req.getParameter("airline");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String dep = req.getParameter("dep");
        String dest = req.getParameter("dest");

        int offset = (currentPage - 1) * recordsPerPage;
        
        // 2. Gọi hàm DAO mới có Filter
        List<Flight> listFlights = flightDAO.getFlightsByPageWithFilter(offset, recordsPerPage, airline, date, time, dep, dest);
        int totalRecords = flightDAO.getTotalFlightsCountWithFilter(airline, date, time, dep, dest);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        req.setAttribute("flightList", listFlights);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        
        // 3. Giữ lại giá trị lọc để hiển thị lại trên giao diện
        req.setAttribute("selectedAirline", airline != null ? airline : "ALL");
        req.setAttribute("selectedDate", date != null ? date : "");
        req.setAttribute("selectedTime", time != null ? time : "");
        req.setAttribute("selectedDep", dep != null ? dep : "ALL");
        req.setAttribute("selectedDest", dest != null ? dest : "ALL");
        
        req.getRequestDispatcher("admin_flight_list.jsp").forward(req, resp);
    }
}
