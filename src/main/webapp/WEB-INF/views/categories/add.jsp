<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/categories" class="text-decoration-none">
                            <i class="fas fa-list-alt"></i> Categories
                        </a>
                    </li>
                    <li class="breadcrumb-item active">
                        <i class="fas fa-plus"></i> Add New
                    </li>
                </ol>
            </nav>

            <!-- Add Category Form -->
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="card-title mb-0">
                        <i class="fas fa-plus-circle"></i> Add New Category
                    </h4>
                </div>
                <div class="card-body">
                    <!-- Error Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/categories" method="post" novalidate>
                        <input type="hidden" name="action" value="add">

                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="fas fa-tag text-primary"></i> Category Name <span class="text-danger">*</span>
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="name"
                                   name="name"
                                   value="${param.name}"
                                   placeholder="Enter category name"
                                   required
                                   maxlength="100">
                            <div class="invalid-feedback">
                                Please enter a category name
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i> The category name must be unique and not empty
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label">
                                <i class="fas fa-align-left text-secondary"></i> Description
                            </label>
                            <textarea class="form-control"
                                      id="description"
                                      name="description"
                                      rows="4"
                                      placeholder="Enter description for the category (optional)"
                                      maxlength="500">${param.description}</textarea>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i> Description helps users better understand this
                                category
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/categories"
                               class="btn btn-outline-secondary me-md-2">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                            <button type="reset" class="btn btn-outline-warning me-md-2">
                                <i class="fas fa-undo"></i> Reset
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Add Category
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Help Section -->
            <div class="card mt-4 border-info">
                <div class="card-header bg-info text-white">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-lightbulb"></i> Tips
                    </h6>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled mb-0">
                        <li class="mb-2">
                            <i class="fas fa-check text-success me-2"></i>
                            Choose a short and clear category name
                        </li>
                        <li class="mb-2">
                            <i class="fas fa-check text-success me-2"></i>
                            Detailed descriptions help differentiate categories
                        </li>
                        <li class="mb-0">
                            <i class="fas fa-check text-success me-2"></i>
                            Avoid creating duplicate or similar categories
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            const forms = document.getElementsByTagName('form');
            Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Auto-focus on name field
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('name').focus();
    });

    // Character counter for description
    const descTextarea = document.getElementById('description');
    const maxLength = descTextarea.getAttribute('maxlength');

    descTextarea.addEventListener('input', function () {
        const currentLength = this.value.length;
        const remaining = maxLength - currentLength;

        let counterElement = document.getElementById('desc-counter');
        if (!counterElement) {
            counterElement = document.createElement('div');
            counterElement.id = 'desc-counter';
            counterElement.className = 'form-text text-end';
            this.parentNode.appendChild(counterElement);
        }

        counterElement.innerHTML = `<i class="fas fa-keyboard"></i> ${currentLength}/${maxLength} characters`;

        if (remaining < 50) {
            counterElement.className = 'form-text text-end text-warning';
        } else {
            counterElement.className = 'form-text text-end text-muted';
        }
    });
</script>
</body>
</html>
