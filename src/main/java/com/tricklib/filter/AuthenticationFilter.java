package com.tricklib.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Allow access to login, register, static resources (css, js, etc.), and the logout page
        if (path.startsWith("/login") || path.startsWith("/register") || path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/") || path.equals("/logout")) {
            chain.doFilter(request, response);
            return;
        }

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (loggedIn) {
            // User is logged in, allow access
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}