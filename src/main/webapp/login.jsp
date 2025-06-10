<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/tricklib-style.css">
    <style>
        /* --- CSS được đồng bộ hóa --- */
        body {
            background-color: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .auth-container {
            max-width: 450px;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="card form-card">
        <div class="card-header text-white text-center">
            <h3 class="mb-0">TrickLib Login</h3>
        </div>
        <div class="card-body p-4">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>
            <c:if test="${param.registration == 'success'}">
                <div class="alert alert-success" role="alert">
                    Registration successful! Please log in.
                </div>
            </c:if>
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>

            <div class="text-center mt-4">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>