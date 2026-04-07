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
    <script defer src="./js/register.js"></script>
</head>
<body class="flex h-screen bg-gray-100">
    <div class="hidden md:flex md:w-1/2 bg-cover bg-center" style="background-image: url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=2074&auto=format&fit=crop')">
        <div class="flex items-center justify-center h-full w-full bg-blue-900 bg-opacity-40">
            <div class="text-white px-12 text-center">
                <h1 class="text-4xl font-bold mb-4">Tham gia cùng chúng tôi</h1>
                <p class="text-lg">Tạo tài khoản để nhận những ưu đãi bay tốt nhất và quản lý hành trình dễ dàng.</p>
            </div>
        </div>
    </div>

    <div class="w-full md:w-1/2 flex items-center justify-center p-8 bg-white">
        <div class="w-full max-w-md">
            <div class="text-center mb-8">
                <h2 class="text-3xl font-extrabold text-gray-900">Đăng ký</h2>
                <p class="text-gray-500 mt-2">Tạo tài khoản mới ngay hôm nay!</p>
            </div>

            <form action="register" method="POST" class="space-y-4">
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Họ và tên</label>
                    <input type="text" id='fullName' name='fullName' placeholder="Nhập họ tên của bạn" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                    <input type="email" id='email' name='email' placeholder="Nhập email của bạn" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tên đăng nhập</label>
                    <input type="text" id='username' name='username' placeholder="Nhập tên đăng nhập của bạn" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Mật khẩu</label>
                    <input type="password" id='password' name='password' placeholder="********" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <button type="submit" class="w-full bg-blue-600 text-white font-bold py-3 rounded-lg hover:bg-blue-700 transition duration-300">
                    Tạo tài khoản
                </button>
            </form>

            <p class="text-center text-sm text-gray-600 mt-6">
                Đã có tài khoản? <a href="login.jsp" class="text-blue-600 font-bold hover:underline">Đăng nhập ngay</a>
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