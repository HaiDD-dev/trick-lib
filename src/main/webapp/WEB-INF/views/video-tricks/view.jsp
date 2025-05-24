<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${videoTrick.title} - TrickLib</title>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/video-tricks">Video Tricks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/categories">Categories</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="body-content">
    <!-- Page Header Section -->
    <section class="page-header" style="margin-bottom: 45px;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/video-tricks">
                                    <i class="fas fa-video me-1"></i>Video Tricks
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                ${fn:length(videoTrick.title) > 30 ?
                                        fn:substring(videoTrick.title, 0, 27).concat('...') :
                                        videoTrick.title}
                            </li>
                        </ol>
                    </nav>
                    <h1 class="display-5 fw-bold mb-2">${videoTrick.title}</h1>
                    <p class="lead mb-0">
                        <i class="fas fa-tag me-2"></i>
                        <c:choose>
                            <c:when test="${not empty videoTrick.categoryName}">
                                ${videoTrick.categoryName}
                            </c:when>
                            <c:otherwise>Category ID: ${videoTrick.categoryId}</c:otherwise>
                        </c:choose>
                        <span class="ms-3">
                        <i class="fas fa-signal me-1"></i>
                        ${not empty videoTrick.difficultyLevel ? videoTrick.difficultyLevel : 'Beginner'}
                    </span>
                    </p>
                </div>
                <div class="col-lg-4 text-end">
                    <div class="btn-group" role="group">
                        <a href="${videoTrick.url}" target="_blank"
                           class="btn btn-light btn-lg action-btn">
                            <i class="fas fa-play me-2"></i>Watch Video
                        </a>
                        <a href="${pageContext.request.contextPath}/video-tricks?action=edit&id=${videoTrick.id}"
                           class="btn btn-outline-light">
                            <i class="fas fa-edit"></i>
                        </a>
                        <button type="button" class="btn btn-outline-light"
                                onclick="confirmDelete()">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <div class="row">
            <!-- Main Content -->
            <div class="col-lg-8">
                <div class="video-info p-4 mb-4">
                    <!-- Video Thumbnail -->
                    <div class="text-center mb-4">
                        <c:choose>
                            <c:when test="${not empty videoTrick.thumbnailUrl}">
                                <img src="${videoTrick.thumbnailUrl}" alt="${videoTrick.title}"
                                     class="video-thumbnail"
                                     onerror="this.src='https://via.placeholder.com/640x360/6c757d/ffffff?text=Video+Unavailable'">
                            </c:when>
                            <c:otherwise>
                                <div class="bg-secondary text-white d-flex align-items-center justify-content-center"
                                     style="height: 300px; border-radius: 12px;">
                                    <div class="text-center">
                                        <i class="fas fa-video fa-3x mb-3"></i>
                                        <h5>No Thumbnail Available</h5>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Description -->
                    <c:if test="${not empty videoTrick.description}">
                        <div class="mb-4">
                            <h5 class="mb-3">
                                <i class="fas fa-info-circle me-2 text-primary"></i>Description
                            </h5>
                            <p class="text-muted lh-lg">${videoTrick.description}</p>
                        </div>
                    </c:if>

                    <!-- Video URL -->
                    <div class="mb-3">
                        <h6><i class="fas fa-link me-2 text-primary"></i>Video Link</h6>
                        <div class="input-group">
                            <input type="text" class="form-control" value="${videoTrick.url}" readonly>
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="copyToClipboard('${videoTrick.url}')">
                                <i class="fas fa-copy"></i>
                            </button>
                            <a href="${videoTrick.url}" target="_blank" class="btn btn-primary">
                                <i class="fas fa-external-link-alt"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Video Information -->
                <div class="card info-card feature-card mb-4">
                    <div class="card-header bg-transparent border-0">
                        <h5 class="mb-0">
                            <i class="fas fa-info me-2 text-primary"></i>Video Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <!-- ID -->
                            <div class="col-12">
                                <small class="text-muted">ID</small>
                                <div class="fw-bold">#${videoTrick.id}</div>
                            </div>

                            <!-- Category -->
                            <div class="col-12">
                                <small class="text-muted">Category</small>
                                <div>
                                <span class="badge bg-primary fs-6">
                                    <c:choose>
                                        <c:when test="${not empty videoTrick.categoryName}">
                                            ${videoTrick.categoryName}
                                        </c:when>
                                        <c:otherwise>Category ID: ${videoTrick.categoryId}</c:otherwise>
                                    </c:choose>
                                </span>
                                </div>
                            </div>

                            <!-- Difficulty -->
                            <div class="col-12">
                                <small class="text-muted">Difficulty</small>
                                <div>
                                <span class="badge difficulty-badge
                                    ${videoTrick.difficultyLevel == 'Beginner' ? 'bg-success' :
                                      videoTrick.difficultyLevel == 'Intermediate' ? 'bg-warning text-dark' : 'bg-danger'}">
                                    <i class="fas fa-signal me-1"></i>
                                    ${not empty videoTrick.difficultyLevel ? videoTrick.difficultyLevel : 'Beginner'}
                                </span>
                                </div>
                            </div>

                            <!-- Duration -->
                            <c:if test="${not empty videoTrick.duration}">
                                <div class="col-12">
                                    <small class="text-muted">Duration</small>
                                    <div class="fw-bold">
                                        <i class="fas fa-clock me-1 text-info"></i>
                                            ${videoTrick.duration}
                                    </div>
                                </div>
                            </c:if>

                            <!-- Created Date -->
                            <c:if test="${not empty videoTrick.createdAt}">
                                <div class="col-12">
                                    <small class="text-muted">Created Date</small>
                                    <div class="fw-bold">
                                        <i class="fas fa-calendar me-1 text-success"></i>
                                            ${videoTrick.createdAt}
                                    </div>
                                </div>
                            </c:if>

                            <!-- Updated Date -->
                            <c:if test="${not empty videoTrick.updatedAt}">
                                <div class="col-12">
                                    <small class="text-muted">Last Updated</small>
                                    <div class="fw-bold">
                                        <i class="fas fa-edit me-1 text-warning"></i>
                                            ${videoTrick.updatedAt}
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="card info-card feature-card">
                    <div class="card-header bg-transparent border-0">
                        <h5 class="mb-0">
                            <i class="fas fa-bolt me-2 text-warning"></i>Quick Actions
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/video-tricks?action=edit&id=${videoTrick.id}"
                               class="btn btn-warning">
                                <i class="fas fa-edit me-2"></i>Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                               class="btn btn-success">
                                <i class="fas fa-plus me-2"></i>Add New Video
                            </a>
                            <a href="${pageContext.request.contextPath}/video-tricks" class="btn btn-outline-primary">
                                <i class="fas fa-list me-2"></i>View All
                            </a>
                            <c:if test="${not empty videoTrick.categoryId}">
                                <a href="${pageContext.request.contextPath}/video-tricks?action=by-category&categoryId=${videoTrick.categoryId}"
                                   class="btn btn-outline-info">
                                    <i class="fas fa-filter me-2"></i>Same Category
                                </a>
                            </c:if>
                        </div>
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
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-danger me-2"></i> Confirm Delete
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <i class="fas fa-trash-alt fa-3x text-danger mb-3"></i>
                    <h5>Are you sure you want to delete this video trick?</h5>
                    <p class="text-muted">"<strong>${videoTrick.title}</strong>"</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i> This action cannot be undone!
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Cancel
                </button>
                <a href="${pageContext.request.contextPath}/video-tricks?action=delete&id=${videoTrick.id}"
                   class="btn btn-danger">
                    <i class="fas fa-trash me-2"></i>Delete Now
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Toast for copy notification -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="copyToast" class="toast" role="alert">
        <div class="toast-header">
            <i class="fas fa-check-circle text-success me-2"></i>
            <strong class="me-auto">Success</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">URL copied to clipboard!</div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Delete confirmation
    function confirmDelete() {
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    // Copy to clipboard functionality
    function copyToClipboard(text) {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(function () {
                showCopyToast();
            }).catch(function (err) {
                console.error('Could not copy text: ', err);
                fallbackCopyTextToClipboard(text);
            });
        } else {
            fallbackCopyTextToClipboard(text);
        }
    }

    function fallbackCopyTextToClipboard(text) {
        const textArea = document.createElement("textarea");
        textArea.value = text;
        textArea.style.top = "0";
        textArea.style.left = "0";
        textArea.style.position = "fixed";
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        try {
            const successful = document.execCommand('copy');
            if (successful) {
                showCopyToast();
            }
        } catch (err) {
            console.error('Fallback: Oops, unable to copy', err);
        }
        document.body.removeChild(textArea);
    }

    function showCopyToast() {
        const toast = new bootstrap.Toast(document.getElementById('copyToast'));
        toast.show();
    }

    // Enhanced image error handling
    document.addEventListener('DOMContentLoaded', function () {
        const thumbnail = document.querySelector('.video-thumbnail');
        if (thumbnail) {
            thumbnail.addEventListener('error', function () {
                this.style.display = 'none';
                const parent = this.parentElement;
                parent.innerHTML = `
                    <div class="bg-secondary text-white d-flex align-items-center justify-content-center" style="height: 300px; border-radius: 12px;">
                        <div class="text-center">
                            <i class="fas fa-image fa-3x mb-3"></i>
                            <h5>Thumbnail Unavailable</h5>
                            <p class="mb-0">Unable to load image</p>
                        </div>
                    </div>
                `;
            });
        }
    });
</script>
</body>
</html>
