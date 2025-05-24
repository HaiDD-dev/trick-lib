package com.tricklib.servlet;

import com.tricklib.dao.CategoryDAO;
import com.tricklib.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("update".equals(action)) {
            updateCategory(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/categories/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/categories/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryById(id);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Category name cannot be empty");
            request.getRequestDispatcher("/WEB-INF/views/categories/add.jsp").forward(request, response);
            return;
        }

        if (categoryDAO.categoryExists(name)) {
            request.setAttribute("error", "Category already exists");
            request.getRequestDispatcher("/WEB-INF/views/categories/add.jsp").forward(request, response);
            return;
        }

        Category category = new Category(name, description);
        boolean success = categoryDAO.addCategory(category);

        if (success) {
            request.setAttribute("message", "Category added successfully");
            response.sendRedirect(request.getContextPath() + "/categories");
        } else {
            request.setAttribute("error", "An error occurred while adding the category");
            request.getRequestDispatcher("/WEB-INF/views/categories/add.jsp").forward(request, response);
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Category name cannot be empty");
            Category category = categoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(request, response);
            return;
        }

        Category category = new Category(id, name, description);
        boolean success = categoryDAO.updateCategory(category);

        if (success) {
            request.setAttribute("message", "Category updated successfully");
            response.sendRedirect(request.getContextPath() + "/categories");
        } else {
            request.setAttribute("error", "An error occurred while updating the category");
            request.setAttribute("category", category);
            request.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(request, response);
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = categoryDAO.deleteCategory(id);

        if (success) {
            request.setAttribute("message", "Category deleted successfully");
        } else {
            request.setAttribute("error", "An error occurred while deleting the category");
        }

        response.sendRedirect(request.getContextPath() + "/categories");
    }
}
