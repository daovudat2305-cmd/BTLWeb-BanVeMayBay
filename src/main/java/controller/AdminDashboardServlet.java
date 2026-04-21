package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookingDAO;
import dao.FlightDAO;

@WebServlet(urlPatterns = {"/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final FlightDAO flightDAO = new FlightDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Gọi các hàm thống kê từ DAO
        int totalTickets = bookingDAO.getTotalTicketsSold();
        double totalRevenue = bookingDAO.getTotalRevenue();
        int activeFlights = flightDAO.getActiveFlightsCount();

        // Đẩy dữ liệu lên Request
        req.setAttribute("totalTickets", totalTickets);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("activeFlights", activeFlights);

        // Chuyển hướng sang trang giao diện
        req.getRequestDispatcher("admin_dashboard.jsp").forward(req, resp);
    }
}