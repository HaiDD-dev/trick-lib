<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Category - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="body-content">
    <!-- Page Header -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">
                        <i class="fas fa-folder-plus me-3"></i>Add New Category
                    </h1>
                    <p class="lead mb-0">Create a new category to organize your trick videos effectively</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-tags display-1 opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/categories">
                                <i class="fas fa-list-alt me-1"></i> Categories
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                            <i class="fas fa-plus me-1"></i> Add New
                        </li>
                    </ol>
                </nav>

                <!-- Add Category Form -->
                <div class="card form-card">
                    <div class="card-header text-white">
                        <h4 class="card-title mb-0">
                            <i class="fas fa-folder-plus me-2"></i> Category Details
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <!-- Error Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/categories" method="post" novalidate>
                            <input type="hidden" name="action" value="add">

                            <div class="mb-4">
                                <label for="name" class="form-label fw-bold">
                                    <i class="fas fa-tag text-primary me-1"></i>
                                    Category Name <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control form-control-lg"
                                       id="name"
                                       name="name"
                                       value="${param.name}"
                                       placeholder="Enter a unique category name"
                                       required
                                       maxlength="100">
                                <div class="invalid-feedback">
                                    <i class="fas fa-times-circle me-1"></i>
                                    Please enter a category name
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    The category name must be unique and descriptive
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-bold">
                                    <i class="fas fa-align-left text-secondary me-1"></i>
                                    Description
                                </label>
                                <textarea class="form-control"
                                          id="description"
                                          name="description"
                                          rows="5"
                                          placeholder="Provide a detailed description of what types of tricks belong in this category..."
                                          maxlength="500">${param.description}</textarea>
                                <div class="form-text">
                                    <i class="fas fa-lightbulb me-1"></i>
                                    A good description helps users understand what content fits in this category
                                </div>
                            </div>

                            <div class="row mt-5 d-flex justify-content-between">
                                <div class="col-md-4 mb-4 text-center">
                                    <a href="${pageContext.request.contextPath}/categories"
                                       class="btn btn-secondary btn-lg me-2 w-100">
                                        <i class="fas fa-arrow-left me-2"></i> Go back
                                    </a>
                                </div>
                                <div class="col-md-4 mb-4 text-center">
                                    <button type="reset" class="btn btn-outline-warning btn-lg me-2 w-100">
                                        <i class="fas fa-undo me-2"></i> Reset
                                    </button>
                                </div>
                                <div class="col-md-4 mb-4 text-center">
                                    <button type="submit" class="btn btn-primary btn-lg px-4 w-100">
                                        <i class="fas fa-save me-2"></i> Create
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Tips Section -->
                <div class="card tips-card mt-4">
                    <div class="card-header border-0">
                        <h6 class="card-title mb-0 text-white">
                            <i class="fas fa-lightbulb me-2"></i> Pro Tips for Creating Categories
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-check-circle text-white me-2 mt-1"></i>
                                    <div>
                                        <strong class="text-white">Be Specific</strong>
                                        <p class="mb-0 text-white-50 small">Choose clear, descriptive names that
                                            instantly
                                            communicate the category's purpose</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-check-circle text-white me-2 mt-1"></i>
                                    <div>
                                        <strong class="text-white">Add Context</strong>
                                        <p class="mb-0 text-white-50 small">Detailed descriptions help users find and
                                            categorize content correctly</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-check-circle text-white me-2 mt-1"></i>
                                    <div>
                                        <strong class="text-white">Avoid Duplicates</strong>
                                        <p class="mb-0 text-white-50 small">Check existing categories to prevent overlap
                                            and
                                            confusion</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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

        counterElement.innerHTML = `<i class="fas fa-keyboard me-1"></i> ${currentLength}/${maxLength} characters`;

        if (remaining < 50) {
            counterElement.className = 'form-text text-end text-warning';
        } else {
            counterElement.className = 'form-text text-end text-muted';
        }
    });

    // Enhanced form submission with loading state
    document.querySelector('form').addEventListener('submit', function (e) {
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;

        // Show loading state
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Creating...';
        submitBtn.disabled = true;

        // Validate required fields
        const name = document.getElementById('name').value.trim();
        if (!name) {
            e.preventDefault();
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            document.getElementById('name').focus();
            return false;
        }

        // If validation passes, the form will submit normally
        // The loading state will be cleared when the page reloads/redirects
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

    // Prevent double-click submissions
    let isSubmitting = false;
    document.querySelector('form').addEventListener('submit', function (e) {
        if (isSubmitting) {
            e.preventDefault();
            return false;
        }
        isSubmitting = true;

        // Reset flag after 3 seconds (in case of validation errors)
        setTimeout(() => {
            isSubmitting = false;
        }, 3000);
    });
</script>
</body>
</html>
