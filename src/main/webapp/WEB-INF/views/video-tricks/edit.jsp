<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Trick Video - TrickLib</title>
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
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">Edit Trick Video</h1>
                    <p class="lead mb-4">Update your trick video information to keep your library organized and
                        up-to-date.</p>
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent p-0 mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/video-tricks"
                                   class="text-white text-decoration-none">
                                    <i class="fas fa-video"></i> Video Tricks
                                </a>
                            </li>
                            <li class="breadcrumb-item active text-white-50">
                                <i class="fas fa-edit"></i> Edit #${videoTrick.id}
                            </li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-edit display-1 opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card main-card">
                    <div class="card-header gradient-header">
                        <h4 class="mb-0">
                            <i class="fas fa-edit me-2"></i>
                            Edit Trick Video
                        </h4>
                        <small class="text-white-50">ID: ${videoTrick.id}</small>
                    </div>
                    <div class="card-body p-4">
                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                    ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Success Message -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                    ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/video-tricks" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${videoTrick.id}">

                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading text-primary me-1"></i>
                                        Title <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="title" name="title"
                                           value="${videoTrick.title}" required
                                           placeholder="Enter video title">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="categoryId" class="form-label">
                                        <i class="fas fa-tags text-success me-1"></i>
                                        Category <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}"
                                                ${videoTrick.categoryId == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="difficultyLevel" class="form-label">
                                        <i class="fas fa-layer-group text-warning me-1"></i>
                                        Difficulty Level
                                    </label>
                                    <select class="form-select" id="difficultyLevel" name="difficultyLevel">
                                        <option value="Beginner" ${videoTrick.difficultyLevel == 'Beginner' ? 'selected' : ''}>
                                            🟢 Beginner
                                        </option>
                                        <option value="Intermediate" ${videoTrick.difficultyLevel == 'Intermediate' ? 'selected' : ''}>
                                            🟡 Intermediate
                                        </option>
                                        <option value="Advanced" ${videoTrick.difficultyLevel == 'Advanced' ? 'selected' : ''}>
                                            🔴 Advanced
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8 mb-3">
                                    <label for="url" class="form-label">
                                        <i class="fas fa-link text-info me-1"></i>
                                        Video URL <span class="text-danger">*</span>
                                    </label>
                                    <input type="url" class="form-control" id="url" name="url"
                                           value="${videoTrick.url}" placeholder="https://youtube.com/watch?v=..."
                                           required>
                                    <div class="form-text">
                                        <a href="${videoTrick.url}" target="_blank" class="text-decoration-none">
                                            <i class="fas fa-external-link-alt me-1"></i>
                                            View current video
                                        </a>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="duration" class="form-label">
                                        <i class="fas fa-clock text-secondary me-1"></i>
                                        Duration
                                    </label>
                                    <input type="text" class="form-control" id="duration" name="duration"
                                           value="${videoTrick.duration}" placeholder="5:30">
                                    <div class="form-text">Format: MM:SS</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="thumbnailUrl" class="form-label">
                                    <i class="fas fa-image text-info me-1"></i>
                                    Thumbnail URL
                                </label>
                                <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl"
                                       value="${videoTrick.thumbnailUrl}"
                                       placeholder="https://example.com/thumbnail.jpg">
                                <c:if test="${not empty videoTrick.thumbnailUrl}">
                                    <div class="mt-2">
                                        <small class="text-muted"><i class="fas fa-eye me-1"></i>Current
                                            Thumbnail:</small><br>
                                        <img src="${videoTrick.thumbnailUrl}" alt="Current thumbnail"
                                             class="preview-thumbnail" id="currentThumbnail"
                                             onerror="this.style.display='none'">
                                    </div>
                                </c:if>
                                <div id="thumbnailPreview" class="mt-2" style="display: none;">
                                    <small class="text-muted"><i class="fas fa-search me-1"></i>Preview:</small><br>
                                    <img src="" alt="Thumbnail preview" class="preview-thumbnail" id="previewImg">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left text-secondary me-1"></i>
                                    Description
                                </label>
                                <textarea class="form-control" id="description" name="description"
                                          rows="4"
                                          placeholder="Detailed description about the trick video...">${videoTrick.description}</textarea>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Provide a detailed description to help users understand the video content
                                </div>
                            </div>

                            <div class="d-flex justify-content-between btn-group-custom">
                                <div>
                                    <a href="${pageContext.request.contextPath}/video-tricks"
                                       class="btn btn-outline-secondary me-2">
                                        <i class="fas fa-arrow-left me-2"></i>
                                        Back to List
                                    </a>
                                    <a href="${pageContext.request.contextPath}/video-tricks?action=view&id=${videoTrick.id}"
                                       class="btn btn-outline-info">
                                        <i class="fas fa-eye me-2"></i>
                                        View Details
                                    </a>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-outline-danger me-2"
                                            onclick="confirmDelete()">
                                        <i class="fas fa-trash me-2"></i>
                                        Delete
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>
                                        Update Video
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Current Info Display -->
                <div class="card info-card mt-4">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-info-circle me-2"></i>
                            Current Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <small class="text-muted"><i class="fas fa-hashtag me-1"></i>ID:</small><br>
                                    <strong>${videoTrick.id}</strong>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted"><i class="fas fa-calendar me-1"></i>Created
                                        At:</small><br>
                                    <strong>
                                        <c:choose>
                                            <c:when test="${not empty videoTrick.createdAt}">
                                                ${videoTrick.createdAt}
                                            </c:when>
                                            <c:otherwise>
                                                <em class="text-muted">N/A</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </strong>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <small class="text-muted"><i class="fas fa-tag me-1"></i>Current
                                        Category:</small><br>
                                    <c:forEach var="category" items="${categories}">
                                        <c:if test="${category.id == videoTrick.categoryId}">
                                            <strong>${category.name}</strong>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted"><i class="fas fa-signal me-1"></i>Difficulty:</small><br>
                                    <c:choose>
                                        <c:when test="${videoTrick.difficultyLevel == 'Beginner'}">
                                            <span class="badge bg-success">🟢 Beginner</span>
                                        </c:when>
                                        <c:when test="${videoTrick.difficultyLevel == 'Intermediate'}">
                                            <span class="badge bg-warning text-dark">🟡 Intermediate</span>
                                        </c:when>
                                        <c:when test="${videoTrick.difficultyLevel == 'Advanced'}">
                                            <span class="badge bg-danger">🔴 Advanced</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Not Set</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="card info-card mt-4 border-info">
                    <div class="card-header bg-info text-white">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-lightbulb me-2"></i>
                            Edit Tips
                        </h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Make sure the video URL is valid and accessible
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-image text-info me-2"></i>
                                Use high-quality thumbnails for better presentation
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-tags text-warning me-2"></i>
                                Choose the appropriate category and difficulty level
                            </li>
                            <li class="mb-0">
                                <i class="fas fa-exclamation-triangle text-danger me-2"></i>
                                Changes will be saved immediately after clicking Update
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header gradient-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Delete Confirmation
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-3">
                    <i class="fas fa-trash-alt fa-3x text-danger mb-3"></i>
                </div>
                <p class="text-center">Are you sure you want to delete the trick video
                    "<strong>${videoTrick.title}</strong>"?</p>
                <p class="text-muted small text-center">
                    <i class="fas fa-exclamation-triangle text-warning me-1"></i>
                    This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Cancel
                </button>
                <a href="${pageContext.request.contextPath}/video-tricks?action=delete&id=${videoTrick.id}"
                   class="btn btn-danger">
                    <i class="fas fa-trash me-2"></i>Delete Permanently
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-light py-4">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Thumbnail preview functionality
    document.getElementById('thumbnailUrl').addEventListener('input', function () {
        const url = this.value.trim();
        const previewDiv = document.getElementById('thumbnailPreview');
        const previewImg = document.getElementById('previewImg');

        if (url && isValidUrl(url)) {
            previewImg.src = url;
            previewImg.onload = function () {
                previewDiv.style.display = 'block';
            };
            previewImg.onerror = function () {
                previewDiv.style.display = 'none';
            };
        } else {
            previewDiv.style.display = 'none';
        }
    });

    // URL validation
    function isValidUrl(string) {
        try {
            new URL(string);
            return true;
        } catch (_) {
            return false;
        }
    }

    // Auto-format duration input
    document.getElementById('duration').addEventListener('input', function () {
        let value = this.value.replace(/[^\d:]/g, '');
        this.value = value;
    });

    // Delete confirmation
    function confirmDelete() {
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    // Form validation before submit
    document.querySelector('form').addEventListener('submit', function (e) {
        const title = document.getElementById('title').value.trim();
        const url = document.getElementById('url').value.trim();
        const categoryId = document.getElementById('categoryId').value;

        if (!title || !url || !categoryId) {
            e.preventDefault();

            // Show custom alert
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-warning alert-dismissible fade show';
            alertDiv.innerHTML = `
                <i class="fas fa-exclamation-triangle me-2"></i>
                Please fill in all required fields (Title, Video URL, Category)
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            document.querySelector('.card-body').insertBefore(alertDiv, document.querySelector('form'));

            // Scroll to top
            document.querySelector('.card').scrollIntoView({behavior: 'smooth'});
            return false;
        }

        if (!isValidUrl(url)) {
            e.preventDefault();

            // Show custom alert
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-warning alert-dismissible fade show';
            alertDiv.innerHTML = `
                <i class="fas fa-link me-2"></i>
                Invalid video URL format
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            document.querySelector('.card-body').insertBefore(alertDiv, document.querySelector('form'));

            // Scroll to top and focus on URL field
            document.querySelector('.card').scrollIntoView({behavior: 'smooth'});
            document.getElementById('url').focus();
            return false;
        }
    });

    // Highlight changed fields
    const originalValues = {
        title: '${videoTrick.title}',
        description: '${videoTrick.description}',
        url: '${videoTrick.url}',
        categoryId: '${videoTrick.categoryId}',
        thumbnailUrl: '${videoTrick.thumbnailUrl}',
        duration: '${videoTrick.duration}',
        difficultyLevel: '${videoTrick.difficultyLevel}'
    };

    function highlightChanges() {
        const fields = ['title', 'description', 'url', 'categoryId', 'thumbnailUrl', 'duration', 'difficultyLevel'];

        fields.forEach(field => {
            const element = document.getElementById(field);
            if (element && element.value !== originalValues[field]) {
                element.classList.add('border-warning');
                element.classList.add('border-2');
            } else if (element) {
                element.classList.remove('border-warning');
                element.classList.remove('border-2');
            }
        });
    }

    // Add event listeners for change detection
    ['title', 'description', 'url', 'categoryId', 'thumbnailUrl', 'duration', 'difficultyLevel'].forEach(field => {
        const element = document.getElementById(field);
        if (element) {
            element.addEventListener('input', highlightChanges);
            element.addEventListener('change', highlightChanges);
        }
    });

    // Auto-focus on title field when page loads
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('title').focus();
    });

    // Auto-dismiss alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            if (bootstrap.Alert.getInstance(alert)) {
                bootstrap.Alert.getInstance(alert).close();
            }
        });
    }, 5000);
</script>
</body>
</html>
