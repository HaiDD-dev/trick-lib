<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="body-content">
    <!-- Page Header Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">Edit Category</h1>
                    <p class="lead mb-4">Modify category information to better organize your trick videos.</p>
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent p-0 mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/categories"
                                   class="text-white text-decoration-none">
                                    <i class="fas fa-list-alt"></i> Categories
                                </a>
                            </li>
                            <li class="breadcrumb-item active text-white-50">
                                <i class="fas fa-edit"></i> Edit #${category.id}
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
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <!-- Edit Category Form -->
                <div class="card main-card">
                    <div class="card-header"
                         style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                        <h4 class="card-title mb-0">
                            <i class="fas fa-edit"></i> Edit Category
                        </h4>
                        <small class="text-white-50">ID: ${category.id}</small>
                    </div>
                    <div class="card-body p-4">
                        <!-- Error Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Success Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/categories" method="post" novalidate>
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${category.id}">

                            <!-- Category ID Display -->
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-hashtag text-secondary"></i> Category ID
                                </label>
                                <input type="text" class="form-control" value="${category.id}" readonly>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> ID cannot be changed
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="name" class="form-label">
                                    <i class="fas fa-tag text-primary"></i> Category Name <span
                                        class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="name"
                                       name="name"
                                       value="${not empty param.name ? param.name : category.name}"
                                       placeholder="Enter category name"
                                       required
                                       maxlength="100">
                                <div class="invalid-feedback">
                                    Please enter the category name
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> Category name must be unique and not empty
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
                                          placeholder="Enter category description (optional)"
                                          maxlength="500">${not empty param.description ? param.description : category.description}</textarea>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> Description helps users understand this category
                                    better
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/categories"
                                   class="btn btn-outline-secondary me-md-2">
                                    <i class="fas fa-arrow-left"></i> Back
                                </a>
                                <button type="button"
                                        class="btn btn-outline-info me-md-2"
                                        onclick="resetForm()">
                                    <i class="fas fa-undo"></i> Restore
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Current Values Display -->
                <div class="card info-card mt-4 border-secondary">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-eye"></i> Current Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-hashtag text-muted"></i> ID:</strong>
                            </div>
                            <div class="col-sm-8">
                            <span class="badge"
                                  style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">${category.id}</span>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-tag text-muted"></i> Name:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${category.name}
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-align-left text-muted"></i> Description:</strong>
                            </div>
                            <div class="col-sm-8">
                                <c:choose>
                                    <c:when test="${not empty category.description}">
                                        ${category.description}
                                    </c:when>
                                    <c:otherwise>
                                        <em class="text-muted">No description</em>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="card info-card mt-4 border-info">
                    <div class="card-header bg-info text-white">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-lightbulb"></i> Edit Tips
                        </h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2">
                                <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                Changing the category name may affect related items
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-info-circle text-info me-2"></i>
                                Use the "Restore" button to revert to the original values
                            </li>
                            <li class="mb-0">
                                <i class="fas fa-check text-success me-2"></i>
                                Ensure the category name is not duplicated
                            </li>
                        </ul>
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

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const originalValues = {
        name: '${category.name}',
        description: '${category.description}'
    };

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

    function resetForm() {
        document.getElementById('name').value = originalValues.name;
        document.getElementById('description').value = originalValues.description;

        const form = document.querySelector('form');
        form.classList.remove('was-validated');

        const alert = document.createElement('div');
        alert.className = 'alert alert-info alert-dismissible fade show mt-3';
        alert.innerHTML = `
            <i class="fas fa-info-circle"></i> Restored to original values
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.querySelector('.card-body').insertBefore(alert, document.querySelector('form'));

        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 3000);
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('name').focus();
        document.getElementById('name').select();
    });

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

        counterElement.className = remaining < 50
            ? 'form-text text-end text-warning'
            : 'form-text text-end text-muted';
    });

    function highlightChanges() {
        const nameField = document.getElementById('name');
        const descField = document.getElementById('description');

        nameField.classList.toggle('border-warning', nameField.value !== originalValues.name);
        descField.classList.toggle('border-warning', descField.value !== originalValues.description);
    }

    document.getElementById('name').addEventListener('input', highlightChanges);
    document.getElementById('description').addEventListener('input', highlightChanges);
</script>
</body>
</html>
