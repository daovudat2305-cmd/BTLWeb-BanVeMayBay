package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;
import model.Booking;
import model.User;

@WebServlet(urlPatterns = {"/booking-success"})
public class BookingSuccessServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getLoggedInUser(req);
        if (user == null) {
            req.setAttribute("error", "Vui lòng đăng nhập để xem thông tin đặt vé.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        String bookingId = req.getParameter("id");
        if (bookingId == null || bookingId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/history");
            return;
        }

        Booking booking = bookingDAO.getBookingByIdForUser(bookingId.trim(), user.getUsername());
        if (booking == null) {
            resp.sendRedirect(req.getContextPath() + "/history");
            return;
        }

        req.setAttribute("booking", booking);
        req.getRequestDispatcher("success.jsp").forward(req, resp);
    }

    private User getLoggedInUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("user");
    }
}
