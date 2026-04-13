package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

@WebFilter("/*")
public class AdminFilter implements Filter{
	
	//chặn người  dùng vào các trang admin nếu chưa đăng nhập
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		//đường dẫn mà người dùng đang muốn truy cập
		String uri = req.getRequestURI();
		
		if (uri.contains("/admin")) {
			if (uri.contains("/admin_login.jsp")) {
				chain.doFilter(request, response);
				return; 
			}
			
			HttpSession session = req.getSession(false);
			User user = (session != null) ? (User) session.getAttribute("user") : null;
			
			if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
				// trả về trang đăng nhập
				resp.sendRedirect(req.getContextPath() + "/admin_login.jsp");
				return;
			}
		}
		chain.doFilter(request, response);
		
	}
}
