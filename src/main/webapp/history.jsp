<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt vé của tôi</title>
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
                <a href="history.jsp" class="text-blue-600 border-b-2 border-blue-600 pb-1 flex items-center gap-1">
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

    <main class="flex-grow max-w-4xl mx-auto w-full py-10 px-4">
        
        <div class="mb-8">
            <h1 class="text-2xl font-extrabold text-gray-900">Lịch sử đặt vé</h1>
            <p class="text-gray-500 mt-1">Quản lý các chuyến bay bạn đã đặt và sắp khởi hành.</p>
        </div>

        <div class="flex space-x-4 mb-6 border-b border-gray-200">
            <button class="py-2 px-4 border-b-2 border-blue-600 text-blue-600 font-bold">Tất cả vé</button>
            <button class="py-2 px-4 text-gray-500 hover:text-blue-600 font-medium transition">Sắp bay</button>
            <button class="py-2 px-4 text-gray-500 hover:text-blue-600 font-medium transition">Đã hoàn thành</button>
        </div>

        <div class="space-y-6">
            
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition">
                <div class="bg-green-50 px-5 py-3 border-b border-gray-200 flex justify-between items-center">
                    <div class="flex items-center gap-2 text-green-700 font-bold text-sm">
                        <i class="fa-solid fa-circle-check"></i> ĐẶT THÀNH CÔNG - SẮP KHỞI HÀNH
                    </div>
                    <div class="text-gray-500 text-sm">Mã đặt chỗ: <span class="font-bold text-gray-900">VK98A2</span></div>
                </div>
                
                <div class="p-5 flex flex-col md:flex-row justify-between items-center gap-6">
                    <div class="flex-1 w-full">
                        <div class="flex items-center gap-3 mb-3">
                            <span class="bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded">Vietjet Air</span>
                            <span class="text-sm font-bold text-gray-700">VJ-101</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <div>
                                <div class="text-xl font-bold">08:30</div>
                                <div class="text-sm text-gray-500">Hà Nội (HAN)</div>
                            </div>
                            <div class="flex flex-col items-center px-4 flex-1">
                                <span class="text-xs text-gray-400">1h 30m</span>
                                <div class="w-full border-t border-dashed border-gray-400 my-1 relative">
                                    <i class="fa-solid fa-plane text-blue-500 absolute top-[-7px] right-0 bg-white pl-1"></i>
                                </div>
                                <span class="text-xs text-gray-800 font-medium">22/11/2026</span>
                            </div>
                            <div class="text-right">
                                <div class="text-xl font-bold">10:00</div>
                                <div class="text-sm text-gray-500">Đà Nẵng (DAD)</div>
                            </div>
                        </div>
                    </div>

                    <div class="w-full md:w-auto flex flex-col gap-2 border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-6 border-gray-200">
                        <div class="text-right mb-2 hidden md:block">
                            <div class="text-sm text-gray-500">Tổng tiền</div>
                            <div class="text-lg font-black text-orange-600">1.200.000 đ</div>
                        </div>
                        <button class="bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-6 rounded-lg transition w-full md:w-auto border border-blue-200">
                            Xem vé điện tử
                        </button>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden opacity-75 hover:opacity-100 transition">
                <div class="bg-gray-100 px-5 py-3 border-b border-gray-200 flex justify-between items-center">
                    <div class="flex items-center gap-2 text-gray-600 font-bold text-sm">
                        <i class="fa-solid fa-plane-arrival"></i> ĐÃ HOÀN THÀNH
                    </div>
                    <div class="text-gray-500 text-sm">Mã đặt chỗ: <span class="font-bold text-gray-900">VNX291</span></div>
                </div>
                
                <div class="p-5 flex flex-col md:flex-row justify-between items-center gap-6">
                    <div class="flex-1 w-full">
                        <div class="flex items-center gap-3 mb-3">
                            <span class="bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded">Vietnam Airlines</span>
                            <span class="text-sm font-bold text-gray-700">VN-223</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <div>
                                <div class="text-xl font-bold text-gray-600">14:00</div>
                                <div class="text-sm text-gray-400">Hồ Chí Minh (SGN)</div>
                            </div>
                            <div class="flex flex-col items-center px-4 flex-1">
                                <span class="text-xs text-gray-400">2h 10m</span>
                                <div class="w-full border-t border-dashed border-gray-300 my-1 relative">
                                    <i class="fa-solid fa-plane text-gray-400 absolute top-[-7px] right-0 bg-white pl-1"></i>
                                </div>
                                <span class="text-xs text-gray-500 font-medium">15/08/2025</span>
                            </div>
                            <div class="text-right">
                                <div class="text-xl font-bold text-gray-600">16:10</div>
                                <div class="text-sm text-gray-400">Hà Nội (HAN)</div>
                            </div>
                        </div>
                    </div>

                    <div class="w-full md:w-auto flex flex-col gap-2 border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-6 border-gray-200">
                        <div class="text-right mb-2 hidden md:block">
                            <div class="text-sm text-gray-500">Tổng tiền</div>
                            <div class="text-lg font-black text-gray-600">1.850.000 đ</div>
                        </div>
                        <button class="bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-2 px-6 rounded-lg transition w-full md:w-auto">
                            Xem lại chi tiết
                        </button>
                    </div>
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
            <div class="space-x-4 text-sm flex flex-col md:flex-row items-center gap-2 md:gap-0">
                <a href="#" class="hover:text-white transition">Điều khoản sử dụng</a>
                <span class="hidden md:inline">|</span>
                <a href="#" class="hover:text-white transition">Chính sách bảo mật</a>
            </div>
        </div>
    </footer>

</body>
</html>