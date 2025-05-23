<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Trick Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .preview-thumbnail {
            max-width: 200px;
            max-height: 120px;
            border-radius: 8px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">
                        <i class="fas fa-edit me-2"></i>
                        Edit Trick Video
                    </h4>
                </div>
                <div class="card-body">
                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                        </div>
                    </c:if>

                    <!-- Success Message -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                                ${message}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/video-tricks" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${videoTrick.id}">

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="title" class="form-label">
                                    Title <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="${videoTrick.title}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="categoryId" class="form-label">
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
                                <label for="difficultyLevel" class="form-label">Difficulty Level</label>
                                <select class="form-select" id="difficultyLevel" name="difficultyLevel">
                                    <option value="Beginner" ${videoTrick.difficultyLevel == 'Beginner' ? 'selected' : ''}>
                                        Beginner
                                    </option>
                                    <option value="Intermediate" ${videoTrick.difficultyLevel == 'Intermediate' ? 'selected' : ''}>
                                        Intermediate
                                    </option>
                                    <option value="Advanced" ${videoTrick.difficultyLevel == 'Advanced' ? 'selected' : ''}>
                                        Advanced
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label for="url" class="form-label">
                                    Video URL <span class="text-danger">*</span>
                                </label>
                                <input type="url" class="form-control" id="url" name="url"
                                       value="${videoTrick.url}" placeholder="https://youtube.com/watch?v=..." required>
                                <div class="form-text">
                                    <a href="${videoTrick.url}" target="_blank" class="text-decoration-none">
                                        <i class="fas fa-external-link-alt me-1"></i>
                                        View current video
                                    </a>
                                </div>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label for="duration" class="form-label">Duration</label>
                                <input type="text" class="form-control" id="duration" name="duration"
                                       value="${videoTrick.duration}" placeholder="5:30">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="thumbnailUrl" class="form-label">Thumbnail URL</label>
                            <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl"
                                   value="${videoTrick.thumbnailUrl}" placeholder="https://example.com/thumbnail.jpg">
                            <c:if test="${not empty videoTrick.thumbnailUrl}">
                                <div class="mt-2">
                                    <small class="text-muted">Current Thumbnail:</small><br>
                                    <img src="${videoTrick.thumbnailUrl}" alt="Current thumbnail"
                                         class="preview-thumbnail" id="currentThumbnail"
                                         onerror="this.style.display='none'">
                                </div>
                            </c:if>
                            <div id="thumbnailPreview" class="mt-2" style="display: none;">
                                <small class="text-muted">Preview:</small><br>
                                <img src="" alt="Thumbnail preview" class="preview-thumbnail" id="previewImg">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description"
                                      rows="4"
                                      placeholder="Detailed description about the trick video...">${videoTrick.description}</textarea>
                        </div>

                        <!-- Current Info Display -->
                        <div class="mb-3">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <h6 class="card-title">Current Information</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <small class="text-muted">ID:</small> <strong>${videoTrick.id}</strong><br>
                                            <small class="text-muted">Created At:</small>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${not empty videoTrick.createdAt}">
                                                        ${videoTrick.createdAt}
                                                    </c:when>
                                                    <c:otherwise>N/A</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </div>
                                        <div class="col-md-6">
                                            <small class="text-muted">Current Category:</small><br>
                                            <c:forEach var="category" items="${categories}">
                                                <c:if test="${category.id == videoTrick.categoryId}">
                                                    <span class="badge bg-primary">${category.name}</span>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <div>
                                <a href="${pageContext.request.contextPath}/video-tricks" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Back to List
                                </a>
                                <a href="${pageContext.request.contextPath}/video-tricks?action=view&id=${videoTrick.id}"
                                   class="btn btn-info text-white">
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
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-save me-2"></i>
                                    Update
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Confirmation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the trick video "<strong>${videoTrick.title}</strong>"?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="${pageContext.request.contextPath}/video-tricks?action=delete&id=${videoTrick.id}"
                   class="btn btn-danger">
                    <i class="fas fa-trash me-2"></i>Delete
                </a>
            </div>
        </div>
    </div>
</div>

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
            alert('Please fill in all required fields (Title, Video URL, Category)');
            return false;
        }

        if (!isValidUrl(url)) {
            e.preventDefault();
            alert('Invalid video URL');
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
            } else if (element) {
                element.classList.remove('border-warning');
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
</script>
</body>
</html>
