package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.UserDAO;

@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//sửa lỗi tiếng việt
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
		
		String fullName = req.getParameter("fullName");
		String email = req.getParameter("email");
		String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        if(UserDAO.checkUsernameExist(username)){
            req.setAttribute("error","Username đã tồn tại");

            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req,resp);

        }
        else if(UserDAO.checkEmailExist(email)){

            req.setAttribute("error","Email đã tồn tại");

            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req,resp);

        }
        else{
            if(UserDAO.registerUser(username,email,password,fullName)) {
            	resp.sendRedirect("login.jsp");
            	return;
            }
            req.setAttribute("error","Có lỗi xảy ra");

            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req,resp);
        }
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//gõ /register trên thanh đk thì về trang đăng nhập
		resp.sendRedirect(req.getContextPath() + "/register.jsp");
	}
}
