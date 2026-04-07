package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//session có sẵn thì lấy, không thì không tạo mới
    	HttpSession session = req.getSession(false);
        
    	String targetPage = "index.jsp";
        if (session != null) {
        	User user = (User) session.getAttribute("user");
        	if(user.getRole().equalsIgnoreCase("ADMIN")) {
        		targetPage = "admin_login.jsp";
        	}
            session.invalidate(); //xóa
        }
        
        resp.sendRedirect(targetPage);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	doGet(req, resp);
    }
}
