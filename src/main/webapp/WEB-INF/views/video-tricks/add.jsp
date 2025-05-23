<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Trick Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        <i class="fas fa-plus-circle me-2"></i>
                        Add New Trick Video
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
                        <input type="hidden" name="action" value="add">

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="title" class="form-label">
                                    Title <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="${param.title}" required>
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
                                            ${param.categoryId == category.id ? 'selected' : ''}>
                                                ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="difficultyLevel" class="form-label">Difficulty Level</label>
                                <select class="form-select" id="difficultyLevel" name="difficultyLevel">
                                    <option value="Beginner" ${param.difficultyLevel == 'Beginner' ? 'selected' : ''}>
                                        Beginner
                                    </option>
                                    <option value="Intermediate" ${param.difficultyLevel == 'Intermediate' ? 'selected' : ''}>
                                        Intermediate
                                    </option>
                                    <option value="Advanced" ${param.difficultyLevel == 'Advanced' ? 'selected' : ''}>
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
                                       value="${param.url}" placeholder="https://youtube.com/watch?v=..." required>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label for="duration" class="form-label">Duration</label>
                                <input type="text" class="form-control" id="duration" name="duration"
                                       value="${param.duration}" placeholder="5:30">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="thumbnailUrl" class="form-label">Thumbnail URL</label>
                            <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl"
                                   value="${param.thumbnailUrl}" placeholder="https://example.com/thumbnail.jpg">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description"
                                      rows="4"
                                      placeholder="Detailed description about the trick video...">${param.description}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/video-tricks" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>
                                Go Back
                            </a>
                            <button type="submit" class="btn btn-primary">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
        this.value = value;
    });
</script>
</body>
</html>
