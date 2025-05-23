<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Tricks List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .video-card {
            transition: transform 0.2s;
        }

        .video-card:hover {
            transform: translateY(-2px);
        }

        .thumbnail-container {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
            border-radius: 8px;
        }

        .thumbnail-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .duration-badge {
            position: absolute;
            bottom: 8px;
            right: 8px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.8rem;
        }

        .difficulty-badge {
            font-size: 0.7rem;
        }
    </style>
</head>
<body>
<div class="container-fluid mt-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <h2><i class="fas fa-video me-2"></i>Video Tricks Library</h2>
                <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                   class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add Video Trick
                </a>
            </div>
        </div>
    </div>

    <!-- Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search and Filter -->
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="${pageContext.request.contextPath}/video-tricks" method="get" class="d-flex">
                <input type="hidden" name="action" value="search">
                <input type="text" class="form-control me-2" name="keyword"
                       value="${keyword}" placeholder="Search video tricks...">
                <button type="submit" class="btn btn-outline-primary">
                    <i class="fas fa-search"></i>
                </button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/video-tricks"
                       class="btn btn-outline-secondary ms-2">
                        <i class="fas fa-times"></i>
                    </a>
                </c:if>
            </form>
        </div>
        <div class="col-md-4">
            <form action="${pageContext.request.contextPath}/video-tricks" method="get">
                <input type="hidden" name="action" value="by-category">
                <select class="form-select" name="categoryId" onchange="this.form.submit()">
                    <option value="">All categories</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.id}"
                            ${selectedCategory != null && selectedCategory.id == category.id ? 'selected' : ''}>
                                ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>
    </div>

    <!-- Current Filter Display -->
    <c:if test="${not empty selectedCategory or not empty keyword}">
        <div class="row mb-3">
            <div class="col-12">
                <div class="alert alert-info py-2">
                    <c:if test="${not empty selectedCategory}">
                        <i class="fas fa-filter me-2"></i>
                        Showing: <strong>${selectedCategory.name}</strong>
                    </c:if>
                    <c:if test="${not empty keyword}">
                        <i class="fas fa-search me-2"></i>
                        Search results for: <strong>"${keyword}"</strong>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Video Grid -->
    <div class="row">
        <c:choose>
            <c:when test="${empty videoTricks}">
                <div class="col-12">
                    <div class="text-center py-5">
                        <i class="fas fa-video fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">No video tricks available</h4>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    No results found for "${keyword}"
                                </c:when>
                                <c:when test="${not empty selectedCategory}">
                                    No video tricks in the "${selectedCategory.name}" category
                                </c:when>
                                <c:otherwise>
                                    Add your first video trick
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                           class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Add Video Trick
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="videoTrick" items="${videoTricks}">
                    <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                        <div class="card video-card h-100">
                            <div class="thumbnail-container">
                                <c:choose>
                                    <c:when test="${not empty videoTrick.thumbnailUrl}">
                                        <img src="${videoTrick.thumbnailUrl}" alt="${videoTrick.title}"
                                             class="thumbnail-img"
                                             onerror="this.src='https://via.placeholder.com/320x180/6c757d/ffffff?text=No+Image'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/320x180/6c757d/ffffff?text=Video+Trick"
                                             alt="${videoTrick.title}" class="thumbnail-img">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty videoTrick.duration}">
                                    <span class="duration-badge">${videoTrick.duration}</span>
                                </c:if>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title" title="${videoTrick.title}">
                                        ${fn:length(videoTrick.title) > 50 ?
                                                fn:substring(videoTrick.title, 0, 47).concat('...') :
                                                videoTrick.title}
                                </h6>

                                <c:if test="${not empty videoTrick.description}">
                                    <p class="card-text text-muted small">
                                            ${fn:length(videoTrick.description) > 80 ?
                                                    fn:substring(videoTrick.description, 0, 77).concat('...') :
                                                    videoTrick.description}
                                    </p>
                                </c:if>

                                <div class="mt-auto">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <c:if test="${not empty videoTrick.difficultyLevel}">
                                                <span class="badge difficulty-badge
                                                    ${videoTrick.difficultyLevel == 'Beginner' ? 'bg-success' :
                                                      videoTrick.difficultyLevel == 'Intermediate' ? 'bg-warning' : 'bg-danger'}">
                                                        ${videoTrick.difficultyLevel}
                                                </span>
                                        </c:if>
                                        <small class="text-muted">
                                            <c:forEach var="category" items="${categories}">
                                                <c:if test="${category.id == videoTrick.categoryId}">
                                                    ${category.name}
                                                </c:if>
                                            </c:forEach>
                                        </small>
                                    </div>

                                    <div class="btn-group w-100" role="group">
                                        <a href="${pageContext.request.contextPath}/video-tricks?action=view&id=${videoTrick.id}"
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${videoTrick.url}" target="_blank"
                                           class="btn btn-primary btn-sm">
                                            <i class="fas fa-play"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/video-tricks?action=edit&id=${videoTrick.id}"
                                           class="btn btn-outline-warning btn-sm">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" class="btn btn-outline-danger btn-sm"
                                                onclick="confirmDelete(${videoTrick.id}, '${videoTrick.title}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Stats -->
    <c:if test="${not empty videoTricks}">
        <div class="row mt-4">
            <div class="col-12">
                <div class="text-center text-muted">
                    <small>
                        Showing <strong>${fn:length(videoTricks)}</strong> video tricks
                        <c:if test="${not empty selectedCategory}">
                            in category <strong>${selectedCategory.name}</strong>
                        </c:if>
                    </small>
                </div>
            </div>
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/">Home</a>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the video trick "<span id="deleteItemName"></span>"?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="fas fa-trash me-2"></i>Delete
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, title) {
        document.getElementById('deleteItemName').textContent = title;
        document.getElementById('confirmDeleteBtn').href =
            '${pageContext.request.contextPath}/video-tricks?action=delete&id=' + id;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    // Auto-hide alerts after 5 seconds
    setTimeout(function () {
        const alerts = document.querySelectorAll('.alert-dismissible');
        alerts.forEach(function (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>
