package com.tricklib.servlet;

import com.tricklib.dao.UserDAO;
import com.tricklib.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateUserRole(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.findUserById(userId);
        request.setAttribute("userToEdit", user);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-edit.jsp").forward(request, response);
    }

    private void updateUserRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userIdToEdit = Integer.parseInt(request.getParameter("userId"));
        String newRole = request.getParameter("role");

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Admin không thể tự thay đổi vai trò của mình qua form này
        if (loggedInUser != null && loggedInUser.getId() == userIdToEdit) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=self_edit");
            return;
        }

        // Lấy thông tin người dùng sắp được chỉnh sửa
        User userToEdit = userDAO.findUserById(userIdToEdit);

        // Ngăn admin thay đổi vai trò của một admin khác
        if (userToEdit != null && "ADMIN".equals(userToEdit.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=admin_edit");
            return;
        }

        userDAO.updateUserRole(userIdToEdit, newRole);
        response.sendRedirect(request.getContextPath() + "/admin/users?success=update");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userIdToDelete = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Kiểm tra xem người dùng có tồn tại trong session không
        if (loggedInUser == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Ngăn admin tự xóa chính mình (lớp bảo vệ thứ nhất)
        if (userIdToDelete == loggedInUser.getId()) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=self_delete");
            return;
        }

        // Lấy thông tin của người dùng sắp bị xóa
        User userToDelete = userDAO.findUserById(userIdToDelete);

        // Ngăn admin xóa một admin khác (lớp bảo vệ thứ hai)
        if (userToDelete != null && "ADMIN".equals(userToDelete.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=admin_delete");
            return;
        }

        // Nếu tất cả kiểm tra đều qua, tiến hành xóa
        boolean success = userDAO.deleteUser(userIdToDelete);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/users?success=delete");
        } else {
            // Xử lý trường hợp xóa thất bại nếu cần
            response.sendRedirect(request.getContextPath() + "/admin/users?error=unknown");
        }
    }
}