package com.tricklib.filter;

import com.tricklib.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*") // <-- Áp dụng filter cho tất cả các URL bắt đầu bằng /admin/
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isAdmin = false;
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("ADMIN".equals(user.getRole())) {
                isAdmin = true;
            }
        }

        if (isAdmin) {
            // Nếu là admin, cho phép tiếp tục
            chain.doFilter(request, response);
        } else {
            // Nếu không phải admin, chuyển hướng về trang lỗi hoặc trang chủ
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this page.");
        }
    }
}