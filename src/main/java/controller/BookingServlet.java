package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FlightDAO;
import model.Flight;

@WebServlet(urlPatterns = {"/booking", "/BookTicketServlet"})
public class BookingServlet extends HttpServlet {
    private final FlightDAO flightDAO = new FlightDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String flightId = req.getParameter("id");

        if (flightId == null || flightId.trim().isEmpty()) {
            req.setAttribute("error", "Không tìm thấy chuyến bay cần xem chi tiết.");
            req.getRequestDispatcher("booking.jsp").forward(req, resp);
            return;
        }

        Flight flight = flightDAO.getFlightById(flightId.trim());

        if (flight == null) {
            req.setAttribute("error", "Chuyến bay không tồn tại hoặc đã bị xóa.");
        } else {
            req.setAttribute("flight", flight);
        }

        req.getRequestDispatcher("booking.jsp").forward(req, resp);
    }
}
