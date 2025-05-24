<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-magic"></i> TrickLib
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/video-tricks">Video Tricks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/categories">Categories</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-5 fw-bold mb-3">
                    <i class="fas fa-tags me-3"></i>Category Management
                </h1>
                <p class="lead mb-0">Organize and manage your trick video categories</p>
            </div>
            <div class="col-lg-4 text-end">
                <a href="${pageContext.request.contextPath}/categories?action=add" class="btn btn-light btn-lg">
                    <i class="fas fa-plus"></i> Add New Category
                </a>
            </div>
        </div>
    </div>
</section>

<div class="body-content">
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <!-- Success/Error Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Categories Table -->
                <div class="card feature-card">
                    <div class="card-header bg-light border-0">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">
                                <i class="fas fa-list-alt text-primary me-2"></i>Category List
                            </h5>
                            <span class="badge bg-primary fs-6">${categories.size()} categories</span>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-dark">
                                        <tr>
                                            <th width="10%">
                                                <i class="fas fa-hashtag me-1"></i>ID
                                            </th>
                                            <th width="25%">
                                                <i class="fas fa-tag me-1"></i>Category Name
                                            </th>
                                            <th width="45%">
                                                <i class="fas fa-align-left me-1"></i>Description
                                            </th>
                                            <th width="20%" class="text-center">
                                                <i class="fas fa-cogs me-1"></i>Actions
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="category" items="${categories}" varStatus="status">
                                            <tr>
                                                <td class="fw-bold text-primary align-middle"
                                                    style="padding-left: 1.25rem;">
                                                    #${category.id}
                                                </td>
                                                <td class="align-middle" style="padding-left: 1.25rem;">
                                                    <div class="d-flex align-items-center">
                                                        <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                            <i class="fas fa-folder text-primary"></i>
                                                        </div>
                                                        <a style="text-decoration: auto;" class="fw-semibold"
                                                           href="${pageContext.request.contextPath}/categories?action=view&id=${category.id}">
                                                                ${category.name}
                                                        </a>
                                                    </div>
                                                </td>
                                                <td class="text-muted align-middle" style="text-align: justify;">
                                                    <c:choose>
                                                        <c:when test="${not empty category.description}">
                                                            ${category.description}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <em class="text-secondary">No description available</em>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center align-middle">
                                                    <div class="btn-group" role="group">
                                                        <a href="${pageContext.request.contextPath}/categories?action=edit&id=${category.id}"
                                                           class="btn btn-sm btn-outline-primary" title="Edit Category"
                                                           data-bs-toggle="tooltip">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-sm btn-outline-danger"
                                                                onclick="confirmDelete(${category.id}, '${category.name}')"
                                                                title="Delete Category"
                                                                data-bs-toggle="tooltip">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <div class="mb-4">
                                        <i class="fas fa-folder-open fa-4x text-muted opacity-50"></i>
                                    </div>
                                    <h4 class="text-muted mb-3">No Categories Found</h4>
                                    <p class="text-muted mb-4">Start organizing your videos by creating your first
                                        category</p>
                                    <a href="${pageContext.request.contextPath}/categories?action=add"
                                       class="btn btn-primary btn-lg">
                                        <i class="fas fa-plus me-2"></i>Create First Category
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-5">
                    <div class="col-12">
                        <h4 class="fw-bold mb-4">Quick Actions</h4>
                    </div>
                    <div class="col-md-6 mb-6">
                        <a href="${pageContext.request.contextPath}/video-tricks"
                           class="btn btn-info w-100 py-3 feature-card">
                            <i class="fas fa-video fa-lg d-block mb-2"></i>
                            <small>View Videos</small>
                        </a>
                    </div>
                    <div class="col-md-6 mb-6">
                        <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                           class="btn btn-success w-100 py-3 feature-card">
                            <i class="fas fa-upload fa-lg d-block mb-2"></i>
                            <small>Add Video</small>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-light py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="fas fa-magic"></i> TrickLib</h5>
                <p class="mb-0">A professional trick video library</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="mb-0">&copy; 2025 TrickLib. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header border-0">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>Confirm Deletion
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-3">Are you sure you want to delete the category <strong class="text-primary"
                                                                                     id="categoryName"></strong>?</p>
                <div class="alert alert-warning d-flex align-items-center">
                    <i class="fas fa-info-circle me-2"></i>
                    <small>This action cannot be undone and may affect associated videos.</small>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Cancel
                </button>
                <a id="deleteLink" href="#" class="btn btn-danger">
                    <i class="fas fa-trash me-1"></i>Delete Category
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, name) {
        document.getElementById('categoryName').textContent = name;
        document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/categories?action=delete&id=' + id;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    // Auto-hide alerts after 5 seconds
    setTimeout(function () {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>
</body>
</html>
