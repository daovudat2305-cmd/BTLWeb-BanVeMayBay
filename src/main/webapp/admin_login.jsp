<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Quản trị - Hệ thống đặt vé</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">

	 <!-- tailwind -->
	 <script src="https://cdn.tailwindcss.com"></script>
	 
	 <!-- script -->
	 <script defer src="./js/toast-message.js"></script>
	 <script defer src="./js/login.js"></script>
</head>
<body class="flex h-screen bg-gray-100">

    <div class="w-full md:w-1/2 flex items-center justify-center p-8 bg-white shadow-2xl z-10">
        <div class="w-full max-w-md">
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gray-100 rounded-full mb-4">
                    <i class="fa-solid fa-user-shield text-3xl text-gray-800"></i>
                </div>
                <h2 class="text-3xl font-extrabold text-gray-900">Cổng Quản Trị</h2>
                <p class="text-gray-500 mt-2">Dành riêng cho nhân viên và quản trị viên</p>
            </div>

            <form action="login" method="POST">
            	<input type="hidden" name="loginType" value="admin">
            	
                <div class="mb-5">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tên đăng nhập Admin</label>
                    <div class="relative">
                        <i class="fa-solid fa-user absolute left-4 top-3.5 text-gray-400"></i>
                        <input type="text" name="username" placeholder="Nhập username..." 
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-all">
                    </div>
                </div>

                <div class="mb-6">
                    <div class="flex justify-between mb-2">
                        <label class="block text-gray-700 text-sm font-bold">Mật khẩu</label>
                    </div>
                    <div class="relative">
                        <i class="fa-solid fa-lock absolute left-4 top-3.5 text-gray-400"></i>
                        <input type="password" name="password" placeholder="••••••••" 
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-all">
                    </div>
                </div>

                <button type="submit" class="w-full bg-gray-800 hover:bg-gray-900 text-white font-bold py-3 px-4 rounded-lg transition-colors duration-300 flex justify-center items-center gap-2">
                    <i class="fa-solid fa-right-to-bracket"></i> Đăng nhập hệ thống
                </button>
            </form>

            <p class="mt-8 text-center text-sm text-gray-500">
                <a href="index.jsp" class="font-medium hover:text-gray-800 transition-colors flex justify-center items-center gap-2">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ khách hàng
                </a>
            </p>
        </div>
    </div>

    <div class="hidden md:flex md:w-1/2 bg-cover bg-center relative" style="background-image: url('https://images.unsplash.com/photo-1542296332-2e4473faf563?q=80&w=2070&auto=format&fit=crop');">
        <div class="absolute inset-0 bg-gray-900 bg-opacity-70 flex flex-col items-center justify-center">
            <div class="text-white px-12 text-center max-w-lg">
                <i class="fa-solid fa-server text-5xl mb-6 text-gray-300"></i>
                <h1 class="text-4xl font-bold mb-4">Hệ Thống Quản Lý Trung Tâm</h1>
                <p class="text-gray-300 text-lg leading-relaxed">
                    Kiểm soát chuyến bay, quản lý vé và điều hành toàn bộ hệ thống đặt chỗ an toàn, bảo mật.
                </p>
            </div>

            <div class="absolute bottom-6 text-gray-400 text-sm">
                Admin Panel v1.0.2 &copy; 2026
            </div>
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