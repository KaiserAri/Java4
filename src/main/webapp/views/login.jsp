<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống AE Dev QTSC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh; display: flex; align-items: center; justify-content: center; font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            width: 100%; max-width: 420px;
            border: none; border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }
        .login-card:hover { transform: translateY(-5px); }
        .form-control:focus { box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25); border-color: #764ba2; }
        .btn-primary { background-color: #764ba2; border: none; }
        .btn-primary:hover { background-color: #5f3a8a; }

        /* Hiệu ứng Vue Transition */
        .fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease; }
        .fade-enter-from, .fade-leave-to { opacity: 0; }
    </style>
</head>
<body>

<div id="app" class="container p-3">
    <div class="card login-card mx-auto">
        <div class="card-body p-5">
            <div class="text-center mb-5">
                <img src="https://fpt.com.vn/Content/images/logo_fpt.png" alt="Logo" class="mb-3" style="max-height: 40px;">
                <h4 class="text-dark fw-bold">Dự án XQTSC</h4>
                <p class="text-muted small">Vui lòng đăng nhập để tiếp tục</p>
            </div>

            <form action="login" method="post" @submit="handleFormSubmit">
                <div class="form-floating mb-3">
                    <input type="text" name="username" v-model="user.username"
                           class="form-control" id="floatingUsername" placeholder="Username" required>
                    <label for="floatingUsername">Tài khoản</label>
                </div>

                <div class="form-floating mb-4">
                    <input type="password" name="password" v-model="user.password"
                           class="form-control" id="floatingPassword" placeholder="******" required>
                    <label for="floatingPassword">Mật khẩu</label>
                </div>

                <transition name="fade">
                    <div v-if="errorMessage" class="alert alert-danger p-2 small text-center mb-3">
                        {{ errorMessage }}
                    </div>
                </transition>

                <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill shadow" :disabled="isLoading">
                    <span v-if="isLoading" class="spinner-border spinner-border-sm me-2"></span>
                    <span v-else>Đăng nhập</span>
                </button>
            </form>

            <div class="text-center mt-4 small">
                <a href="#" class="text-muted text-decoration-none">Quên mật khẩu?</a>
            </div>
        </div>
    </div>
</div>

<script>
    const { createApp } = Vue;

    createApp({
        data() {
            return {
                user: { username: '', password: '' },
                errorMessage: '',
                isLoading: false
            }
        },
        methods: {
            handleFormSubmit(e) {
                this.isLoading = true;
                this.errorMessage = '';

                // Validate phía client trước khi submit form truyền thống
                if (this.user.username.length < 3) {
                    this.errorMessage = "Yêu cầu tài khoản từ 3 ký tự trở lên!";
                    this.isLoading = false;
                    e.preventDefault(); // Chặn submit
                }
                // Nếu OK, form sẽ tự submit lên action="login" qua method="post"
            }
        }
    }).mount('#app')
</script>

</body>
</html>