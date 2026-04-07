<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống đặt vé máy bay</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
    
    <!-- tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- script -->
    <script defer src="./js/toast-message.js"></script>
    <script defer src="./js/login.js"></script>
</head>
<body class="flex h-screen bg-gray-100">

    <div class="hidden md:flex md:w-1/2 bg-cover bg-center" style="background-image: url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=2074&auto=format&fit=crop');">
        <div class="flex items-center justify-center h-full w-full bg-blue-900 bg-opacity-40">
            <div class="text-white px-12 text-center">
                <h1 class="text-4xl font-bold mb-4">Bắt đầu hành trình mới</h1>
                <p class="text-lg">Đặt vé dễ dàng, bay khắp muôn nơi cùng chúng tôi.</p>
            </div>
        </div>
    </div>

    <div class="w-full md:w-1/2 flex items-center justify-center p-8 bg-white">
        <div class="w-full max-w-md">
            <div class="text-center mb-8">
                <h2 class="text-3xl font-extrabold text-gray-900">Đăng nhập</h2>
                <p class="text-gray-500 mt-2">Chào mừng bạn quay trở lại!</p>
            </div>

            <form action="login" method="POST">
            	<input type="hidden" name="loginType" value="user">
            
                <div class="mb-5">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tên đăng nhập hoặc Email</label>
                    <input type="text" id='username' name='username' placeholder="Nhập tên đăng nhập hoặc email của bạn" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Mật khẩu</label>
                    <input type="password" id='password' name='password' placeholder="••••••••" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                </div>

                <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg transition-colors duration-300">
                    Đăng nhập
                </button>
            </form>

            <p class="mt-6 text-center text-sm text-gray-600">
                Chưa có tài khoản? 
                <a href="register.jsp" class="font-semibold text-blue-600 hover:text-blue-800 transition-colors">Đăng ký ngay</a>
            </p>
            
            <p class="mt-6 text-center text-sm text-gray-600">
                Đăng nhập với vai trò quản trị viên
                <a href="admin_login.jsp" class="font-semibold text-blue-600 hover:text-blue-800 transition-colors">Tại đây</a>
            </p>
        </div>
    </div>
	
	<!-- toast message -->
    <div id="toast-container" class="fixed z-50 space-y-3 top-5 right-5"></div>
    
    <script>
        //thông báo lỗi
        const serverError = "${error}";
        if (serverError && serverError.trim() !== "") {
            window.addEventListener('DOMContentLoaded', (event) => {
                showToast(serverError, "error");
            });
        }
    </script>
</body>
</html>