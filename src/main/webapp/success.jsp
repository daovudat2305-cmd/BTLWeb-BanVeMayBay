<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé thành công</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans flex flex-col min-h-screen">

    <nav class="bg-white px-8 py-4 flex justify-between items-center shadow-sm sticky top-0 z-50">
        <div class="flex items-center space-x-8">
            <div class="text-2xl font-black text-blue-800 flex items-center gap-2">
                <i class="fa-solid fa-plane-departure"></i> Vé Máy Bay
            </div>
            <div class="hidden md:flex space-x-6 font-medium items-center">
                <a href="index.jsp" class="text-gray-600 hover:text-blue-600">Trang Chủ</a>
                <a href="#" class="text-gray-600 hover:text-blue-600">Săn Vé Rẻ</a>
                <a href="history.jsp" class="text-gray-600 hover:text-blue-600 flex items-center gap-1">
                    <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đặt vé
                </a>
            </div>
        </div>
        <div class="flex items-center space-x-4">
            <div class="text-gray-600 font-medium flex items-center gap-2">
                <i class="fa-solid fa-circle-user text-xl text-blue-600"></i>
                <span>Nguyễn Văn A</span>
            </div>
        </div>
    </nav>

    <main class="flex-grow flex items-center justify-center p-4">
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 max-w-lg w-full text-center overflow-hidden">
            
            <div class="bg-green-500 py-8 flex justify-center">
                <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center text-green-500 text-4xl shadow-inner">
                    <i class="fa-solid fa-check"></i>
                </div>
            </div>

            <div class="p-8">
                <h2 class="text-3xl font-extrabold text-gray-800 mb-2">Đặt vé thành công!</h2>
                <p class="text-gray-500 mb-6">Cảm ơn quý khách đã tin tưởng và sử dụng dịch vụ của chúng tôi. Hệ thống đã gửi thông tin vé về địa chỉ email của quý khách.</p>
                
                <div class="bg-gray-50 rounded-xl p-5 text-left mb-8 border border-gray-200">
                    <div class="grid grid-cols-2 gap-y-4 text-sm">
                        <div class="text-gray-500">Mã đặt chỗ (PNR)</div>
                        <div class="font-bold text-blue-600 text-right text-lg">VK98A2</div>
                        
                        <div class="text-gray-500">Chuyến bay</div>
                        <div class="font-bold text-gray-800 text-right">Hà Nội <i class="fa-solid fa-arrow-right mx-1 text-xs text-gray-400"></i> Đà Nẵng</div>
                        
                        <div class="text-gray-500">Thời gian</div>
                        <div class="font-bold text-gray-800 text-right">08:30 - 22/11/2026</div>

                        <div class="text-gray-500">Tổng thanh toán</div>
                        <div class="font-black text-orange-600 text-right text-lg">1.200.000 đ</div>
                    </div>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="index.jsp" class="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-800 font-bold py-3 px-6 rounded-xl transition">
                        Về trang chủ
                    </a>
                    <a href="history.jsp" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-xl transition shadow-md shadow-blue-200">
                        Xem vé của tôi
                    </a>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-gray-800 text-gray-300 py-8 mt-auto">
        <div class="max-w-6xl mx-auto px-4 flex flex-col md:flex-row justify-between items-center text-center md:text-left">
            <div class="mb-4 md:mb-0">
                <p class="font-semibold text-white mb-1">Hệ thống Đặt vé Máy bay trực tuyến</p>
                <p class="text-sm text-gray-400">© 2026 Bản quyền thuộc về Nhóm Phát Triển.</p>
            </div>
            <div class="space-x-4 text-sm">
                <a href="#" class="hover:text-white transition">Điều khoản sử dụng</a>
                <span class="hidden md:inline">|</span>
                <a href="#" class="hover:text-white transition">Chính sách bảo mật</a>
            </div>
        </div>
    </footer>

</body>
</html>