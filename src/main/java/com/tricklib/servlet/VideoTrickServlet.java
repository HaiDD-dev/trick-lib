package com.tricklib.servlet;

import com.tricklib.dao.CategoryDAO;
import com.tricklib.dao.VideoTrickDAO;
import com.tricklib.model.Category;
import com.tricklib.model.VideoTrick;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/video-tricks")
public class VideoTrickServlet extends HttpServlet {
    private VideoTrickDAO videoTrickDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        videoTrickDAO = new VideoTrickDAO();
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
            case "view":
                viewVideoTrick(request, response);
                break;
            case "delete":
                deleteVideoTrick(request, response);
                break;
            case "search":
                searchVideoTricks(request, response);
                break;
            case "by-category":
                listVideoTricksByCategory(request, response);
                break;
            default:
                listVideoTricks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addVideoTrick(request, response);
        } else if ("update".equals(action)) {
            updateVideoTrick(request, response);
        }
    }

    private void listVideoTricks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<VideoTrick> videoTricks = videoTrickDAO.getAllVideoTricks();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("videoTricks", videoTricks);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/list.jsp").forward(request, response);
    }

    private void listVideoTricksByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIdParam = request.getParameter("categoryId");
        List<VideoTrick> videoTricks;
        Category selectedCategory = null;

        List<Category> categories = categoryDAO.getAllCategories();

        if (categoryIdParam == null || categoryIdParam.isEmpty()) {
            videoTricks = videoTrickDAO.getAllVideoTricks();
        } else {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                videoTricks = videoTrickDAO.getVideoTricksByCategory(categoryId);
                selectedCategory = categoryDAO.getCategoryById(categoryId);
            } catch (NumberFormatException e) {
                videoTricks = videoTrickDAO.getAllVideoTricks();
            }
        }

        request.setAttribute("videoTricks", videoTricks);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", selectedCategory);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        VideoTrick videoTrick = videoTrickDAO.getVideoTrickById(id);
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("videoTrick", videoTrick);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/edit.jsp").forward(request, response);
    }

    private void viewVideoTrick(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        VideoTrick videoTrick = videoTrickDAO.getVideoTrickById(id);

        request.setAttribute("videoTrick", videoTrick);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/view.jsp").forward(request, response);
    }

    private void addVideoTrick(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String url = request.getParameter("url");
        String categoryIdStr = request.getParameter("categoryId");
        String thumbnailUrl = request.getParameter("thumbnailUrl");
        String duration = request.getParameter("duration");
        String difficultyLevel = request.getParameter("difficultyLevel");

        if (title == null || title.trim().isEmpty() || url == null || url.trim().isEmpty() || categoryIdStr == null || categoryIdStr.trim().isEmpty()) {

            request.setAttribute("error", "Please fill out all required information");
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/video-tricks/add.jsp").forward(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            VideoTrick videoTrick = new VideoTrick();
            videoTrick.setTitle(title);
            videoTrick.setDescription(description);
            videoTrick.setUrl(url);
            videoTrick.setCategoryId(categoryId);
            videoTrick.setThumbnailUrl(thumbnailUrl);
            videoTrick.setDuration(duration);
            videoTrick.setDifficultyLevel(difficultyLevel != null ? difficultyLevel : "Beginner");

            boolean success = videoTrickDAO.addVideoTrick(videoTrick);

            if (success) {
                request.setAttribute("message", "Video trick added successfully");
                response.sendRedirect(request.getContextPath() + "/video-tricks");
            } else {
                request.setAttribute("error", "An error occurred while adding the video trick");
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/views/video-tricks/add.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid category");
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/video-tricks/add.jsp").forward(request, response);
        }
    }

    private void updateVideoTrick(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String url = request.getParameter("url");
        String categoryIdStr = request.getParameter("categoryId");
        String thumbnailUrl = request.getParameter("thumbnailUrl");
        String duration = request.getParameter("duration");
        String difficultyLevel = request.getParameter("difficultyLevel");

        if (title == null || title.trim().isEmpty() || url == null || url.trim().isEmpty() || categoryIdStr == null || categoryIdStr.trim().isEmpty()) {

            request.setAttribute("error", "Please fill out all required information");
            VideoTrick videoTrick = videoTrickDAO.getVideoTrickById(id);
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("videoTrick", videoTrick);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/video-tricks/edit.jsp").forward(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            VideoTrick videoTrick = new VideoTrick();
            videoTrick.setId(id);
            videoTrick.setTitle(title);
            videoTrick.setDescription(description);
            videoTrick.setUrl(url);
            videoTrick.setCategoryId(categoryId);
            videoTrick.setThumbnailUrl(thumbnailUrl);
            videoTrick.setDuration(duration);
            videoTrick.setDifficultyLevel(difficultyLevel != null ? difficultyLevel : "Beginner");

            boolean success = videoTrickDAO.updateVideoTrick(videoTrick);

            if (success) {
                request.setAttribute("message", "Video trick updated successfully");
                response.sendRedirect(request.getContextPath() + "/video-tricks");
            } else {
                request.setAttribute("error", "An error occurred while updating the video trick");
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("videoTrick", videoTrick);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/views/video-tricks/edit.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid category");
            VideoTrick videoTrick = videoTrickDAO.getVideoTrickById(id);
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("videoTrick", videoTrick);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/video-tricks/edit.jsp").forward(request, response);
        }
    }

    private void deleteVideoTrick(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = videoTrickDAO.deleteVideoTrick(id);

        if (success) {
            request.setAttribute("message", "Video trick deleted successfully");
        } else {
            request.setAttribute("error", "An error occurred while deleting the video trick");
        }

        response.sendRedirect(request.getContextPath() + "/video-tricks");
    }

    private void searchVideoTricks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<VideoTrick> videoTricks;

        if (keyword != null && !keyword.trim().isEmpty()) {
            videoTricks = videoTrickDAO.searchVideoTricks(keyword);
            request.setAttribute("keyword", keyword);
        } else {
            videoTricks = videoTrickDAO.getAllVideoTricks();
        }

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("videoTricks", videoTricks);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/video-tricks/list.jsp").forward(request, response);
    }
}
