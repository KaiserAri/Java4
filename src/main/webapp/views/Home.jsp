<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Tìm kiếm người dùng theo Username</h2>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-outline-danger">Đăng xuất</a>
    </div>

    <form action="${pageContext.request.contextPath}/finding" method="post" class="mb-4">
        <div class="input-group">
            <input type="text" name="username" class="form-control"
                   placeholder="Nhập Username cần tìm"
                   value="${param.username}">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
    </form>

    <c:if test="${not empty message}">
        <div class="alert alert-warning text-center">${message}</div>
    </c:if>

    <c:if test="${not empty users}">
        <table class="table table-bordered table-hover bg-white shadow-sm">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Họ và Tên</th>
                <th>Số điện thoại</th>
                <th>Vai trò</th>
                <th>Trạng thái</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.userId}</td>
                    <td>${u.username}</td>
                    <td><strong>${u.hoVaTen}</strong></td>
                    <td>${u.phoneNumber}</td>
                    <td><span class="badge bg-info text-dark">${u.roleName}</span></td>
                    <td>
                        <c:choose>
                            <c:when test="${u.isActive}">
                                <span class="text-success">&#9679; Đang hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger">&#9675; Đang khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>
