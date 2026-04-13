package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		String loginType = req.getParameter("loginType"); 
		
		String expectedRole = "admin".equals(loginType) ? "ADMIN" : "USER";
		String targetErrorPage = "admin".equals(loginType) ? "admin_login.jsp" : "login.jsp";
		
		User user = UserDAO.verifyLogin(username, password, expectedRole);
        
		if (user == null) {
			req.setAttribute("error", "Sai thông tin đăng nhập hoặc không có quyền truy cập!");
			RequestDispatcher rd = req.getRequestDispatcher(targetErrorPage);
			rd.forward(req, resp);
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			
			String targetSuccessPage = "ADMIN".equals(user.getRole()) ? "/admin_dashboard.jsp" : "/home";
			
			resp.sendRedirect(req.getContextPath() + targetSuccessPage);
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//gõ /login trên thanh đk thì về trang đăng nhập
		resp.sendRedirect(req.getContextPath() + "/login.jsp");
	}
}
