package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;
import model.Booking;
import model.User;

@WebServlet(urlPatterns = {"/history"})
public class BookingHistoryServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getLoggedInUser(req);
        if (user == null) {
            req.setAttribute("error", "Vui lòng đăng nhập để xem lịch sử đặt vé.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        List<Booking> bookings = bookingDAO.getBookingsByUsername(user.getUsername());
        int upcomingCount = 0;
        int completedCount = 0;

        for (Booking booking : bookings) {
            if (booking.isUpcoming()) {
                upcomingCount++;
            } else if (booking.isCompleted()) {
                completedCount++;
            }
        }

        req.setAttribute("bookings", bookings);
        req.setAttribute("upcomingCount", upcomingCount);
        req.setAttribute("completedCount", completedCount);
        req.setAttribute("totalBookings", bookings.size());
        req.getRequestDispatcher("history.jsp").forward(req, resp);
    }

    private User getLoggedInUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("user");
    }
}
