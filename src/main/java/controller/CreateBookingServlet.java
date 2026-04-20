package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;
import dao.FlightDAO;
import model.Flight;
import model.User;

@WebServlet(urlPatterns = {"/book-ticket"})
public class CreateBookingServlet extends HttpServlet {
    private final FlightDAO flightDAO = new FlightDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = getLoggedInUser(req);
        if (user == null) {
            req.setAttribute("error", "Vui long dang nhap de dat ve.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        String flightId = trim(req.getParameter("flightId"));
        String passengerName = trim(req.getParameter("passengerName"));
        String cccd = trim(req.getParameter("cccd"));
        String phone = trim(req.getParameter("phone"));
        String email = trim(req.getParameter("email"));

        Flight flight = flightDAO.getFlightById(flightId);
        if (flight == null) {
            req.setAttribute("error", "Chuyen bay khong ton tai hoac da bi xoa.");
            req.getRequestDispatcher("booking.jsp").forward(req, resp);
            return;
        }

        if (passengerName == null || passengerName.isEmpty()) {
            forwardBackToBooking(req, resp, flight, "Vui long nhap ho va ten hanh khach.", passengerName, cccd, phone, email);
            return;
        }

        if (cccd == null || !cccd.matches("\\d{12}")) {
            forwardBackToBooking(req, resp, flight, "CCCD phai gom dung 12 chu so.", passengerName, cccd, phone, email);
            return;
        }

        if (phone == null || !phone.matches("\\d{9,11}")) {
            forwardBackToBooking(req, resp, flight, "So dien thoai phai gom tu 9 den 11 chu so.", passengerName, cccd, phone, email);
            return;
        }

        if (email == null || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            forwardBackToBooking(req, resp, flight, "Vui long nhap email hop le.", passengerName, cccd, phone, email);
            return;
        }

        String bookingId = bookingDAO.createBooking(user.getUsername(), flightId, passengerName, cccd, phone, email);
        if (bookingId == null) {
            forwardBackToBooking(req, resp, flight, "Dat ve that bai. Chuyen bay co the da het ghe.", passengerName, cccd, phone, email);
            return;
        }

        resp.sendRedirect(
            req.getContextPath() + "/booking-success?id="
                + URLEncoder.encode(bookingId, StandardCharsets.UTF_8)
        );
    }

    private void forwardBackToBooking(
        HttpServletRequest req,
        HttpServletResponse resp,
        Flight flight,
        String error,
        String passengerName,
        String cccd,
        String phone,
        String email
    ) throws ServletException, IOException {
        req.setAttribute("flight", flight);
        req.setAttribute("error", error);
        req.setAttribute("formPassengerName", passengerName);
        req.setAttribute("formCccd", cccd);
        req.setAttribute("formPhone", phone);
        req.setAttribute("formEmail", email);
        req.getRequestDispatcher("booking.jsp").forward(req, resp);
    }

    private User getLoggedInUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("user");
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
