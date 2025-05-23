<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-list-alt"></i> Category Management</h2>
                <a href="${pageContext.request.contextPath}/categories?action=add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Category
                </a>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Categories Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-table"></i> Category List
                        <span class="badge bg-secondary ms-2">${categories.size()} categories</span>
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty categories}">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-dark">
                                    <tr>
                                        <th width="10%">ID</th>
                                        <th width="25%">Category Name</th>
                                        <th width="45%">Description</th>
                                        <th width="20%" class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="category" items="${categories}" varStatus="status">
                                        <tr>
                                            <td class="fw-bold text-primary">${category.id}</td>
                                            <td>
                                                <i class="fas fa-tag text-secondary me-2"></i>
                                                    ${category.name}
                                            </td>
                                            <td class="text-muted">
                                                <c:choose>
                                                    <c:when test="${not empty category.description}">
                                                        ${category.description}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <em>No description</em>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/categories?action=edit&id=${category.id}"
                                                       class="btn btn-sm btn-outline-primary" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                            onclick="confirmDelete(${category.id}, '${category.name}')"
                                                            title="Delete">
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
                                <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">No categories available</h5>
                                <p class="text-muted">Add your first category</p>
                                <a href="${pageContext.request.contextPath}/categories?action=add"
                                   class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Category
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/">Home</a>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning"></i> Confirm Deletion
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the category <strong id="categoryName"></strong>?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a id="deleteLink" href="#" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Delete
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
</script>
</body>
</html>
