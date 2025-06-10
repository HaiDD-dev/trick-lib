<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrickLib - Trick Video Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="body-content">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Welcome to TrickLib</h1>
                    <p class="lead mb-4">A rich video library with thousands of tutorials on magic, tricks, and unique
                        skills.</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/video-tricks" class="btn btn-light btn-lg">
                            <i class="fas fa-play"></i> Watch Videos
                        </a>
                        <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                           class="btn btn-outline-light btn-lg">
                            <i class="fas fa-plus"></i> Add Video
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <i class="fas fa-video display-1 opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="fw-bold">Main Features</h2>
                    <p class="text-muted">Manage and organize trick videos efficiently</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card h-100 text-center p-4">
                        <div class="card-body">
                            <i class="fas fa-video fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Video Management</h5>
                            <p class="card-text">Easily add, edit, delete, and organize your trick videos.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100 text-center p-4">
                        <div class="card-body">
                            <i class="fas fa-tags fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Smart Categorization</h5>
                            <p class="card-text">Create and manage categories to group videos by topic.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100 text-center p-4">
                        <div class="card-body">
                            <i class="fas fa-search fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Quick Search</h5>
                            <p class="card-text">Quickly search videos by keyword or filter by category.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Actions -->
    <section class="bg-light py-5">
        <div class="container">
            <div class="row text-center">
                <div class="col-12 mb-4">
                    <h3 class="fw-bold">Get Started</h3>
                    <p class="text-muted">Choose an action to perform</p>
                </div>
            </div>
            <div class="row g-3 justify-content-center">
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/video-tricks?action=add"
                       class="btn btn-primary w-100 py-3">
                        <i class="fas fa-plus fa-lg"></i><br>
                        <small>Add New Video</small>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/categories?action=add"
                       class="btn btn-success w-100 py-3">
                        <i class="fas fa-folder-plus fa-lg"></i><br>
                        <small>Add Category</small>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/video-tricks" class="btn btn-info w-100 py-3">
                        <i class="fas fa-list fa-lg"></i><br>
                        <small>View All Videos</small>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/categories" class="btn btn-warning w-100 py-3">
                        <i class="fas fa-tags fa-lg"></i><br>
                        <small>Manage Categories</small>
                    </a>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>