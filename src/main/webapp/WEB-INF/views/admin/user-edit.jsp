<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Edit - TrickLib</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tricklib-style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="page-header">
    <div class="container">
        <h1>Edit User Role</h1>
    </div>
</div>

<div class="container body-content mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card form-card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/users" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="userId" value="${userToEdit.id}">

                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" value="${userToEdit.username}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select id="role" name="role" class="form-select">
                                <option value="USER" ${userToEdit.role == 'USER' ? 'selected' : ''}>USER</option>
                                <option value="ADMIN" ${userToEdit.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>