<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý User - Dự án XQTSC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        /* CSS chống nháy giao diện khi Vue chưa load xong */
        [v-cloak] { display: none; }
    </style>
</head>
<body class="bg-light">

<div id="app" class="container mt-5" >
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Danh sách nhân sự hệ thống</h2>
        <a href="login" class="btn btn-sm btn-outline-danger">Đăng xuất</a>
    </div>
    <div>
        <form action="finding" method="post">
            <label>Tên vai trò:  </label>
            <input type="text" name="pRoleName"/>
            <button>tìm kiếm</button>
        </form>
    </div>
    <table class="table table-bordered table-hover bg-white shadow-sm">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Họ và Tên</th>
            <th>Số điện thoại</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="u in users" :key="u.userId">
            <td>{{ u.userId }}</td>
            <td><strong>{{ u.hoVaTen }}</strong></td>
            <td>{{ u.phoneNumber }}</td>
            <td>
                <span class="badge bg-info text-dark">{{ u.roleName }}</span>
            </td>
            <td>
                <span v-if="u.isActive" class="text-success">● Đang hoạt động</span>
                <span v-else class="text-danger">○ Đang khóa</span>
            </td>
        </tr>
        <tr v-if="users.length === 0">
            <td colspan="5" class="text-center text-muted py-4">Chưa có dữ liệu người dùng</td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    // Servlet truyền sang một chuỗi JSON chuẩn. Nếu null thì mặc định là mảng rỗng []
    // Trình duyệt sẽ tự hiểu đây là Object JavaScript, không bị lỗi ngoặc kép nữa
    const serverData = ${empty usersJson ? '[]' : usersJson};

    const { createApp } = Vue;
    createApp({
        data() {
            return {
                users: serverData
            }
        }
    }).mount('#app');
</script>

</body>
</html>