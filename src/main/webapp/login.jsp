<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống đặt vé máy bay</title>
    <script src="https://cdn.tailwindcss.com"></script>
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

            <form action="#" method="POST">
                <div class="mb-5">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tên đăng nhập hoặc Email</label>
                    <input type="text" placeholder="Nhập email của bạn" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Mật khẩu</label>
                    <input type="password" placeholder="••••••••" 
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
        </div>
    </div>

</body>
</html>