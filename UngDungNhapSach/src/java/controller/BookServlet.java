package controller;

import dao.BookDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;

@WebServlet(name = "BookServlet", urlPatterns = {"/BookServlet"})
public class BookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        // Khi người dùng bấm nút Add
        if ("add".equals(action)) {
            String bookcode = request.getParameter("bookcode");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");

            // Validate: Không được để trống
            if (bookcode.trim().isEmpty() || title.trim().isEmpty() || author.trim().isEmpty()) {
                request.setAttribute("error", "Tất cả các ô nhập không được để trống!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            // Validate: Không trùng bookcode
            BookDAO dao = new BookDAO();
            if (dao.checkBookCodeExists(bookcode)) {
                request.setAttribute("error", "Bookcode đã tồn tại trong CSDL!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            // Lưu category vừa chọn vào session 
            HttpSession session = request.getSession();
            session.setAttribute("selectedCategory", category);

            // Tạo đối tượng Book và đẩy sang trang xác nhận 
            Book book = new Book(bookcode, title, author, category);
            session.setAttribute("pendingBook", book); 
            request.getRequestDispatcher("confirm.jsp").forward(request, response);

        } 
        // Khi người dùng bấm nút Confirm
        else if ("confirm".equals(action)) {
            HttpSession session = request.getSession();
            Book book = (Book) session.getAttribute("pendingBook");
            
            if (book != null) {
                BookDAO dao = new BookDAO();
                dao.insertBook(book); // Thêm vào CSDL
                String bookcode = request.getParameter("bookcode");
                request.setAttribute("error", "Nhập thành công");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                session.removeAttribute("pendingBook"); // Xóa rác session
            }
            response.sendRedirect("index.jsp"); // Quay lại form nhập

        } 
        // Khi người dùng bấm nút Back 
        else if ("back".equals(action)) {
            response.sendRedirect("index.jsp");
        }
    }
}