<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Tricks List - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
    <style>
        /* Video Hover Effects */
        .video-card {
            transition: all 0.3s ease;
            border-radius: 12px;
            overflow: hidden;
        }

        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .video-container {
            position: relative;
            width: 100%;
            height: 200px;
            background: #000;
            border-radius: 8px 8px 0 0;
            overflow: hidden;
        }

        .video-preview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: opacity 0.3s ease;
        }

        .video-iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }

        .video-container:hover .video-preview {
            opacity: 0;
        }

        .video-container:hover .video-iframe {
            opacity: 1;
            pointer-events: auto;
        }

        .play-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.7);
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            transition: all 0.3s ease;
            z-index: 2;
        }

        .video-container:hover .play-overlay {
            opacity: 0;
            transform: translate(-50%, -50%) scale(1.2);
        }

        .duration-badge {
            position: absolute;
            bottom: 8px;
            right: 8px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.75rem;
            z-index: 3;
        }

        .video-title {
            font-size: 1rem;
            font-weight: 600;
            line-height: 1.3;
            margin-bottom: 8px;
            color: #212529;
        }

        .video-description {
            font-size: 0.875rem;
            color: #6c757d;
            line-height: 1.4;
        }

        .category-tag {
            background: #e3f2fd;
            color: #1976d2;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .hover-info {
            position: absolute;
            top: 8px;
            left: 8px;
            background: rgba(255, 255, 255, 0.9);
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            color: #333;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 3;
        }

        .video-container:hover .hover-info {
            opacity: 1;
        }
    </style>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/video-tricks">Video Tricks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/categories">Categories</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-5 fw-bold mb-3">
                    <i class="fas fa-video me-3"></i>Video Tricks Library
                </h1>
                <p class="lead mb-0">
                    <c:choose>
                        <c:when test="${not empty selectedCategory}">
                            Browsing: <strong>${selectedCategory.name}</strong> category
                        </c:when>
                        <c:when test="${not empty keyword}">
                            Search results for: <strong>"${keyword}"</strong>
                        </c:when>
                        <c:otherwise>
                            Discover and manage your collection of magic tricks and tutorials
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="col-lg-4 text-end">
                <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                   class="btn btn-light btn-lg">
                    <i class="fas fa-plus me-2"></i>Add Video Trick
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Messages -->
<c:if test="${not empty error or not empty message}">
    <div class="container mt-4">
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
    </div>
</c:if>

<div class="body-content">
    <!-- Search and Filter Section -->
    <section class="search-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <form action="${pageContext.request.contextPath}/video-tricks" method="get" class="d-flex">
                                <input type="hidden" name="action" value="search">
                                <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-search"></i>
                                </span>
                                    <input type="text" class="form-control form-control-lg" name="keyword"
                                           value="${keyword}"
                                           placeholder="Search video tricks by title or description...">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        Search
                                    </button>
                                    <c:if test="${not empty keyword}">
                                        <a href="${pageContext.request.contextPath}/video-tricks"
                                           class="btn btn-outline-secondary btn-lg">
                                            <i class="fas fa-times"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <form action="${pageContext.request.contextPath}/video-tricks" method="get">
                                <input type="hidden" name="action" value="by-category">
                                <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-filter"></i>
                                </span>
                                    <select class="form-select form-select-lg" name="categoryId"
                                            onchange="this.form.submit()">
                                        <option value="">All categories</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}"
                                                ${selectedCategory != null && selectedCategory.id == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Video Grid -->
    <section class="py-5">
        <div class="container">
            <c:choose>
                <c:when test="${empty videoTricks}">
                    <div class="text-center py-5">
                        <i class="fas fa-video fa-4x text-muted mb-4"></i>
                        <h3 class="text-muted mb-3">No video tricks available</h3>
                        <p class="text-muted mb-4">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    No results found for "<strong>${keyword}</strong>". Try adjusting your search terms.
                                </c:when>
                                <c:when test="${not empty selectedCategory}">
                                    No video tricks found in the "<strong>${selectedCategory.name}</strong>" category yet.
                                </c:when>
                                <c:otherwise>
                                    Start building your video trick library by adding your first video.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div class="d-flex gap-3 justify-content-center">
                            <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                               class="btn btn-primary btn-lg">
                                <i class="fas fa-plus me-2"></i>Add Video Trick
                            </a>
                            <c:if test="${not empty keyword or not empty selectedCategory}">
                                <a href="${pageContext.request.contextPath}/video-tricks"
                                   class="btn btn-outline-primary btn-lg">
                                    <i class="fas fa-list me-2"></i>View All Videos
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="videoTrick" items="${videoTricks}">
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="card video-card h-100">
                                    <div class="video-container">
                                        <!-- Thumbnail/Preview Image -->
                                        <c:choose>
                                            <c:when test="${not empty videoTrick.thumbnailUrl}">
                                                <img src="${videoTrick.thumbnailUrl}" alt="${videoTrick.title}"
                                                     class="video-preview"
                                                     onerror="this.src='https://via.placeholder.com/320x180/6c757d/ffffff?text=No+Image'">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/320x180/6c757d/ffffff?text=Video+Trick"
                                                     alt="${videoTrick.title}" class="video-preview">
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Video Iframe for Hover -->
                                        <iframe class="video-iframe"
                                                src="${fn:replace(videoTrick.url, 'watch?v=', 'embed/')}?autoplay=1&mute=1&controls=0&loop=1"
                                                allow="autoplay; encrypted-media"
                                                allowfullscreen>
                                        </iframe>

                                        <!-- Play Overlay -->
                                        <div class="play-overlay">
                                            <i class="fas fa-play"></i>
                                        </div>

                                        <!-- Hover Info -->
                                        <div class="hover-info">
                                            <i class="fas fa-mouse-pointer me-1"></i>Hover to preview
                                        </div>

                                        <!-- Duration Badge -->
                                        <c:if test="${not empty videoTrick.duration}">
                                            <span class="duration-badge">${videoTrick.duration}</span>
                                        </c:if>
                                    </div>

                                    <div class="card-body d-flex flex-column">
                                        <h6 class="video-title" title="${videoTrick.title}">
                                                ${fn:length(videoTrick.title) > 50 ?
                                                        fn:substring(videoTrick.title, 0, 47).concat('...') :
                                                        videoTrick.title}
                                        </h6>

                                        <c:if test="${not empty videoTrick.description}">
                                            <p class="video-description mb-3">
                                                    ${fn:length(videoTrick.description) > 80 ?
                                                            fn:substring(videoTrick.description, 0, 77).concat('...') :
                                                            videoTrick.description}
                                            </p>
                                        </c:if>

                                        <div class="mt-auto">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <c:if test="${not empty videoTrick.difficultyLevel}">
                                                <span class="badge difficulty-badge
                                                    ${videoTrick.difficultyLevel == 'Beginner' ? 'bg-success' :
                                                      videoTrick.difficultyLevel == 'Intermediate' ? 'bg-warning' : 'bg-danger'}">
                                                        ${videoTrick.difficultyLevel}
                                                </span>
                                                </c:if>
                                                <c:forEach var="category" items="${categories}">
                                                    <c:if test="${category.id == videoTrick.categoryId}">
                                                        <span class="category-tag">
                                                            <i class="fas fa-tag me-1"></i>${category.name}
                                                        </span>
                                                    </c:if>
                                                </c:forEach>
                                            </div>

                                            <div class="d-grid gap-2">
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/video-tricks?action=view&id=${videoTrick.id}"
                                                       class="btn btn-outline-primary btn-sm" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${videoTrick.url}" target="_blank"
                                                       class="btn btn-primary btn-sm" title="Watch Video">
                                                        <i class="fas fa-play"></i> Watch
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/video-tricks?action=edit&id=${videoTrick.id}"
                                                       class="btn btn-outline-warning btn-sm" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                            title="Delete"
                                                            onclick="confirmDelete(${videoTrick.id}, '${videoTrick.title}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Stats Section -->
    <c:if test="${not empty videoTricks}">
        <section class="stats-section">
            <div class="container">
                <div class="text-center">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card feature-card border-0 bg-transparent">
                                <div class="card-body">
                                    <i class="fas fa-video fa-2x text-primary mb-2"></i>
                                    <h5 class="card-title">${fn:length(videoTricks)}</h5>
                                    <p class="card-text text-muted">
                                        Video<c:if test="${fn:length(videoTricks) != 1}">s</c:if> Found
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card feature-card border-0 bg-transparent">
                                <div class="card-body">
                                    <i class="fas fa-tags fa-2x text-success mb-2"></i>
                                    <h5 class="card-title">${fn:length(categories)}</h5>
                                    <p class="card-text text-muted">
                                        Categor<c:if test="${fn:length(categories) != 1}">ies</c:if><c:if
                                            test="${fn:length(categories) == 1}">y</c:if>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card feature-card border-0 bg-transparent">
                                <div class="card-body">
                                    <i class="fas fa-filter fa-2x text-warning mb-2"></i>
                                    <h5 class="card-title">
                                        <c:choose>
                                            <c:when test="${not empty selectedCategory}">Filtered</c:when>
                                            <c:when test="${not empty keyword}">Search</c:when>
                                            <c:otherwise>All</c:otherwise>
                                        </c:choose>
                                    </h5>
                                    <p class="card-text text-muted">Current View</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </c:if>
</div>

<!-- Footer -->
<footer class="bg-dark text-light py-4" style="margin-top: 45px;">
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
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                    Confirm Deletion
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the video trick "<strong><span id="deleteItemName"></span></strong>"?
                </p>
                <p class="text-muted small">
                    <i class="fas fa-info-circle me-1"></i>
                    This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Cancel
                </button>
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

    // Optimize video loading on hover
    document.addEventListener('DOMContentLoaded', function () {
        const videoContainers = document.querySelectorAll('.video-container');

        videoContainers.forEach(container => {
            const iframe = container.querySelector('.video-iframe');
            let hoverTimeout;

            container.addEventListener('mouseenter', function () {
                hoverTimeout = setTimeout(() => {
                    // Load video with slight delay to avoid unnecessary loading
                    if (!iframe.src.includes('autoplay=1')) {
                        const currentSrc = iframe.src;
                        iframe.src = currentSrc;
                    }
                }, 200);
            });

            container.addEventListener('mouseleave', function () {
                clearTimeout(hoverTimeout);
                // Optional: pause video when mouse leaves
                // iframe.src = iframe.src.replace('autoplay=1', 'autoplay=0');
            });
        });
    });
</script>
</body>
</html>