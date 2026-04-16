/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.FlightDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Flight;

/**
 *
 * @author phant
 */
@WebServlet(name = "SearchFlightServlet", urlPatterns = {"/SearchFlightServlet"})
public class UserSearchFlightServlet extends HttpServlet{
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Lấy thông tin tìm kiếm (Điểm đi, Điểm đến)
    String depCode = request.getParameter("depCode");
    String destCode = request.getParameter("destCode");
    
    // 2. Lấy danh sách các hãng từ bộ lọc (Checkbox)
    // getParameterValues trả về mảng String nếu khách chọn nhiều hãng
    String[] selectedAirlines = request.getParameterValues("airline");

    // 3. Gọi DAO tìm kiếm theo bản nâng cấp
    FlightDAO dao = new FlightDAO();
    // Chú ý: Sử dụng hàm searchWithFilter có 3 tham số
    List<Flight> list = dao.searchWithFilter(depCode, destCode, selectedAirlines);

    // 4. Gửi dữ liệu sang trang JSP
    request.setAttribute("outboundList", list);
    
    // Giữ lại dữ liệu cũ để hiển thị trên Header và Checkbox
    request.setAttribute("oldDep", depCode);
    request.setAttribute("oldDest", destCode);
    request.setAttribute("selectedAirlines", selectedAirlines); 
    
    // 5. Chuyển hướng đến trang kết quả
    // Bạn đang dùng flight_list.jsp, hãy đảm bảo file này có các thẻ <c:forEach>
    request.getRequestDispatcher("flight_list.jsp").forward(request, response);
}
}
