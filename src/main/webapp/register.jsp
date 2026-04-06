<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdn.tailwindcss.com"></script>
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

            <form action="#" method="POST" class="space-y-4">
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Họ và tên</label>
                    <input type="text" placeholder="Nhập họ tên của bạn" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                    <input type="email" placeholder="Nhập email của bạn" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2">Mật khẩu</label>
                    <input type="password" placeholder="********" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
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
</body>