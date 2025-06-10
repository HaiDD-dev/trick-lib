<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Trick Video - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="body-content">
    <!-- Page Header -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">
                        <i class="fas fa-plus-circle me-3"></i>Add New Trick Video
                    </h1>
                    <p class="lead mb-0">Share your amazing tricks with the TrickLib community</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-video-plus display-1 opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card form-card">
                    <div class="card-header text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-film me-2"></i>
                            Video Details
                        </h4>
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
                            <input type="hidden" name="action" value="add">

                            <div class="row">
                                <div class="col-md-12 mb-4">
                                    <label for="title" class="form-label fw-bold">
                                        <i class="fas fa-heading me-1"></i>
                                        Title <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control form-control-lg" id="title" name="title"
                                           value="${param.title}"
                                           placeholder="Enter an engaging title for your trick video"
                                           required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label for="categoryId" class="form-label fw-bold">
                                        <i class="fas fa-tags me-1"></i>
                                        Category <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select form-select-lg" id="categoryId" name="categoryId"
                                            required>
                                        <option value="">Choose a category</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}"
                                                ${param.categoryId == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <label for="difficultyLevel" class="form-label fw-bold">
                                        <i class="fas fa-chart-line me-1"></i>
                                        Difficulty Level
                                    </label>
                                    <select class="form-select form-select-lg" id="difficultyLevel"
                                            name="difficultyLevel">
                                        <option value="Beginner" ${param.difficultyLevel == 'Beginner' ? 'selected' : ''}>
                                            <i class="fas fa-seedling"></i> Beginner
                                        </option>
                                        <option value="Intermediate" ${param.difficultyLevel == 'Intermediate' ? 'selected' : ''}>
                                            <i class="fas fa-adjust"></i> Intermediate
                                        </option>
                                        <option value="Advanced" ${param.difficultyLevel == 'Advanced' ? 'selected' : ''}>
                                            <i class="fas fa-fire"></i> Advanced
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-8 mb-4">
                                    <label for="url" class="form-label fw-bold">
                                        <i class="fas fa-link me-1"></i>
                                        Video URL <span class="text-danger">*</span>
                                    </label>
                                    <input type="url" class="form-control form-control-lg" id="url" name="url"
                                           value="${param.url}" placeholder="https://youtube.com/watch?v=..." required>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Supported: YouTube, Vimeo, and other video platforms
                                    </div>
                                </div>

                                <div class="col-md-4 mb-4">
                                    <label for="duration" class="form-label fw-bold">
                                        <i class="fas fa-clock me-1"></i>
                                        Duration
                                    </label>
                                    <input type="text" class="form-control form-control-lg" id="duration"
                                           name="duration"
                                           value="${param.duration}" placeholder="5:30">
                                    <div class="form-text">Format: MM:SS</div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="thumbnailUrl" class="form-label fw-bold">
                                    <i class="fas fa-image me-1"></i>
                                    Thumbnail URL
                                </label>
                                <input type="url" class="form-control form-control-lg" id="thumbnailUrl"
                                       name="thumbnailUrl"
                                       value="${param.thumbnailUrl}" placeholder="https://example.com/thumbnail.jpg">
                                <div class="form-text">
                                    <i class="fas fa-lightbulb me-1"></i>
                                    A good thumbnail increases video engagement
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-bold">
                                    <i class="fas fa-align-left me-1"></i>
                                    Description
                                </label>
                                <textarea class="form-control" id="description" name="description"
                                          rows="5"
                                          placeholder="Provide a detailed description of the trick, including tips, techniques, and what viewers will learn...">${param.description}</textarea>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-5">
                                <a href="${pageContext.request.contextPath}/video-tricks"
                                   class="btn btn-secondary btn-lg">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Back to Videos
                                </a>
                                <button type="submit" class="btn btn-primary btn-lg px-4">
                                    <i class="fas fa-save me-2"></i>
                                    Add Trick Video
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Preview thumbnail when URL is entered
    document.getElementById('thumbnailUrl').addEventListener('blur', function () {
        const url = this.value;
        if (url) {
            // You can add thumbnail preview functionality here
            console.log('Thumbnail URL:', url);
        }
    });

    // Auto-format duration input
    document.getElementById('duration').addEventListener('input', function () {
        let value = this.value.replace(/[^\d:]/g, '');
        // Auto-add colon for MM:SS format
        if (value.length === 2 && !value.includes(':')) {
            value += ':';
        }
        this.value = value;
    });

    // Form validation enhancements
    document.querySelector('form').addEventListener('submit', function (e) {
        const title = document.getElementById('title').value.trim();
        const categoryId = document.getElementById('categoryId').value;
        const url = document.getElementById('url').value.trim();

        if (!title || !categoryId || !url) {
            e.preventDefault();
            alert('Please fill in all required fields (Title, Category, and Video URL)');
            return false;
        }

        // Basic URL validation
        try {
            new URL(url);
        } catch {
            e.preventDefault();
            alert('Please enter a valid URL for the video');
            return false;
        }
    });

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function () {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            if (alert.querySelector('.btn-close')) {
                alert.querySelector('.btn-close').click();
            }
        });
    }, 5000);
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>