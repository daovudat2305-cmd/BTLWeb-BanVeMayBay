package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookingDAO;
import model.Booking;

@WebServlet(urlPatterns = {"/adminBookings"})
public class AdminBookingServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();
    //số lượng vé hiển thị trên 1 trang
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            try { page = Integer.parseInt(req.getParameter("page")); } catch (NumberFormatException e) { page = 1; }
        }

        // 1. NHẬN TỪ KHÓA TÌM KIẾM VÀ TRẠNG THÁI TỪ URL
        String search = req.getParameter("search");
        String status = req.getParameter("status");

        int offset = (page - 1) * RECORDS_PER_PAGE;
        
        // 2. TRUYỀN THÊM SEARCH VÀ STATUS VÀO DAO
        int totalBookings = bookingDAO.getTotalBookingsCount(search, status);
        int totalPages = (int) Math.ceil((double) totalBookings / RECORDS_PER_PAGE);

        List<Booking> bookingList = bookingDAO.getBookingsByPage(offset, RECORDS_PER_PAGE, search, status);

        int startItem = totalBookings == 0 ? 0 : offset + 1;
        int endItem = Math.min(offset + RECORDS_PER_PAGE, totalBookings);

        req.setAttribute("bookingList", bookingList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalBookings", totalBookings);
        req.setAttribute("startItem", startItem);
        req.setAttribute("endItem", endItem);
        
        // 3. GIỮ LẠI TỪ KHÓA ĐỂ GIAO DIỆN KHÔNG BỊ MẤT
        req.setAttribute("searchQuery", search != null ? search : "");
        req.setAttribute("statusFilter", status != null ? status : "ALL");
        
        req.getRequestDispatcher("admin_customer_booking.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String bookingId = req.getParameter("bookingId");
        
        // Nhận lại page hiện tại để sau khi duyệt không bị văng về trang 1
        String page = req.getParameter("page");
        if (page == null) page = "1";

        if (bookingId != null && action != null) {
            if ("approve".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "APPROVED");
            } else if ("reject".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "REJECTED");
            }
        }
        
        // Load lại trang danh sách đúng với page hiện tại
        resp.sendRedirect(req.getContextPath() + "/adminBookings?page=" + page);
    }
}
