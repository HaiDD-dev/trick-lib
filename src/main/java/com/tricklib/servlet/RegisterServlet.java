package com.tricklib.servlet;

import com.tricklib.dao.UserDAO;
import com.tricklib.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just show the registration page
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Server-side validation
        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty() || fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (userDAO.findByUsername(username) != null) {
            request.setAttribute("error", "Username is already taken. Please choose another one.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // All checks passed, create the new user
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setFullName(fullName);
        // We pass the plain password to the model, and the DAO will hash it.
        newUser.setPasswordHash(password);

        try {
            boolean success = userDAO.createUser(newUser);
            if (success) {
                // On success, redirect to the login page with a success parameter
                response.sendRedirect(request.getContextPath() + "/login?registration=success");
            } else {
                request.setAttribute("error", "An unexpected error occurred. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            request.setAttribute("error", "Database error. Could not complete registration.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}