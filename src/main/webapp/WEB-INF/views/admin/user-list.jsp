<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Giả sử bạn có header.jsp, nếu không có bạn có thể xóa dòng này --%>
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<div class="page-header">
    <div class="container">
        <h1>User Management</h1>
    </div>
</div>

<div class="container body-content mt-4">
    <%-- THÊM MỚI: Khu vực hiển thị thông báo --%>
    <c:if test="${param.error == 'admin_delete'}">
        <div class="alert alert-danger" role="alert">
            Error: You cannot delete another administrator account.
        </div>
    </c:if>
    <c:if test="${param.error == 'self_delete'}">
        <div class="alert alert-danger" role="alert">
            Error: You cannot delete your own account.
        </div>
    </c:if>
    <c:if test="${param.success == 'delete'}">
        <div class="alert alert-success" role="alert">
            User has been deleted successfully.
        </div>
    </c:if>

    <table class="table table-hover">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${userList}">
            <tr class="${sessionScope.user.id == user.id ? 'table-info' : ''}">
                <td>${user.id}</td>
                <td>
                        ${user.username}
                    <c:if test="${sessionScope.user.id == user.id}">
                        <span class="badge bg-info ms-2">You</span>
                    </c:if>
                </td>
                <td>${user.fullName}</td>
                <td><span class="badge bg-${user.role == 'ADMIN' ? 'danger' : 'secondary'}">${user.role}</span></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.id}"
                       class="btn btn-sm btn-outline-primary ${user.role == 'ADMIN' and sessionScope.user.id != user.id ? 'disabled' : ''}">Edit</a>

                        <%-- CẬP NHẬT LOGIC: Vô hiệu hóa nút Delete nếu vai trò của user là ADMIN --%>
                    <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${user.id}"
                       class="btn btn-sm btn-outline-danger ${user.role == 'ADMIN' ? 'disabled' : ''}"
                       onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>