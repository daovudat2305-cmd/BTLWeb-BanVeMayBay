package controller;

import java.io.IOException;
import java.util.ArrayList;
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
    private static final int RECORDS_PER_PAGE = 15;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getLoggedInUser(req);
        if (user == null) {
            req.setAttribute("error", "Vui lòng đăng nhập để xem lịch sử đặt vé.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        // 1. Nhận các tham số lọc từ UI
        String status = req.getParameter("status");
        String date = req.getParameter("date");
        String flightDate = req.getParameter("flightDate"); // Bổ sung biến ngày bay

        // 2. Lấy TOÀN BỘ danh sách theo bộ lọc mới (truyền 4 tham số)
        List<Booking> allBookings = bookingDAO.getBookingsByUsernameWithFilter(user.getUsername(), status, date, flightDate);
        
        int pendingCount = 0, rejectedCount = 0, upcomingCount = 0, completedCount = 0;

        for (Booking booking : allBookings) {
            String bStatus = booking.getStatus();
            if ("PENDING".equalsIgnoreCase(bStatus)) pendingCount++;
            else if ("REJECTED".equalsIgnoreCase(bStatus)) rejectedCount++;
            else if ("APPROVED".equalsIgnoreCase(bStatus)) {
                if (booking.isUpcoming()) upcomingCount++;
                else completedCount++;
            }
        }

        // 3. LOGIC PHÂN TRANG
        int page = 1;
        if (req.getParameter("page") != null) {
            try { page = Integer.parseInt(req.getParameter("page")); } catch (NumberFormatException e) { page = 1; }
        }

        int totalBookings = allBookings.size();
        int totalPages = (int) Math.ceil((double) totalBookings / RECORDS_PER_PAGE);

        int startIndex = (page - 1) * RECORDS_PER_PAGE;
        int endIndex = Math.min(startIndex + RECORDS_PER_PAGE, totalBookings);

        List<Booking> paginatedBookings = new ArrayList<>();
        if (startIndex < totalBookings) {
            paginatedBookings = allBookings.subList(startIndex, endIndex);
        }

        req.setAttribute("bookings", paginatedBookings); 
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalBookings", totalBookings);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("rejectedCount", rejectedCount);
        req.setAttribute("upcomingCount", upcomingCount);
        req.setAttribute("completedCount", completedCount);

        // 4. Giữ lại giá trị lọc để hiển thị trên Form
        req.setAttribute("selectedStatus", status != null ? status : "ALL");
        req.setAttribute("selectedDate", date != null ? date : "");
        req.setAttribute("selectedFlightDate", flightDate != null ? flightDate : "");

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
