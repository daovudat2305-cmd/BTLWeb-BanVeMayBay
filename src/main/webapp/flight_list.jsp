<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm chuyến bay</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans flex flex-col min-h-screen">

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
        <c:choose>
		    <c:when test="${user == null}">
		        <div class="flex items-center space-x-4">
		            <a href="login.jsp" class="text-gray-600 font-medium hover:text-blue-600">Đăng nhập</a>
		            <a href="register.jsp" class="bg-blue-600 text-white px-5 py-2 rounded-lg font-bold hover:bg-blue-700 transition">Đăng ký</a>
		        </div>
		    </c:when>
		    <c:otherwise>
		        <div class="flex items-center space-x-4">
		            <div class="text-gray-600 font-medium flex items-center gap-2">
		                <i class="fa-solid fa-circle-user text-xl text-blue-600"></i>
		                <span>${user.fullName}</span>
		            </div>
		            <a href="logout" class="text-red-400 font-medium hover:text-red-600 transition flex items-center gap-2">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </a>
		        </div>
		    </c:otherwise>
		</c:choose>
    </nav>

    <div class="bg-[#1e3a8a] text-white py-6 px-4 shadow-md">
        <div class="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center">
            <div class="flex items-center gap-4 text-xl font-bold mb-4 md:mb-0">
                <span>Hà Nội (HAN)</span>
                <i class="fa-solid fa-arrow-right-long text-gray-400"></i>
                <span>Đà Nẵng (DAD)</span>
            </div>
            <div class="flex gap-6 text-sm font-medium">
                <div class="flex items-center gap-2"><i class="fa-regular fa-calendar"></i> Thứ 5, 22/11/2026</div>
                <div class="flex items-center gap-2"><i class="fa-solid fa-user"></i> 1 Hành khách</div>
                <div class="flex items-center gap-2"><i class="fa-solid fa-ticket"></i> Phổ thông</div>
            </div>
            <a href="index.jsp" class="inline-block mt-4 md:mt-0 bg-white text-blue-800 px-4 py-2 rounded font-bold text-sm hover:bg-gray-100 transition text-center">
                Đổi tìm kiếm
            </a>
        </div>
    </div>

    <main class="flex-grow max-w-6xl mx-auto w-full py-8 px-4 grid grid-cols-1 md:grid-cols-4 gap-6">
        
        <aside class="md:col-span-1">
            <div class="bg-white rounded-xl shadow-sm p-5 border border-gray-200">
                <div class="flex justify-between items-center mb-4 pb-4 border-b">
                    <h3 class="font-bold text-lg text-gray-800">Bộ lọc</h3>
                    <button class="text-blue-600 text-sm font-medium hover:underline">Xóa lọc</button>
                </div>
                
                <div class="mb-6">
                    <h4 class="font-semibold text-gray-700 mb-3">Hãng hàng không</h4>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600" checked>
                        <span class="text-gray-600">Vietjet Air</span>
                    </label>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600" checked>
                        <span class="text-gray-600">Vietnam Airlines</span>
                    </label>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600" checked>
                        <span class="text-gray-600">Bamboo Airways</span>
                    </label>
                </div>

                <div>
                    <h4 class="font-semibold text-gray-700 mb-3">Thời gian cất cánh</h4>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600">
                        <span class="text-gray-600">Sáng (00:00 - 12:00)</span>
                    </label>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600">
                        <span class="text-gray-600">Chiều (12:00 - 18:00)</span>
                    </label>
                    <label class="flex items-center gap-2 mb-2 cursor-pointer">
                        <input type="checkbox" class="w-4 h-4 text-blue-600">
                        <span class="text-gray-600">Tối (18:00 - 24:00)</span>
                    </label>
                </div>
            </div>
        </aside>

        <div class="md:col-span-3 space-y-4">
            
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-5 hover:shadow-md transition">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                    <div class="w-full md:w-1/4 flex flex-col">
                        <span class="inline-block bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded w-max mb-1">Vietjet Air</span>
                        <span class="text-sm text-gray-500">VJ-101 • Airbus A320</span>
                    </div>
                    
                    <div class="w-full md:w-2/4 flex justify-between items-center px-4">
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">08:30</div>
                            <div class="text-sm text-gray-500">Hà Nội</div>
                        </div>
                        <div class="flex flex-col items-center flex-1 px-4">
                            <span class="text-xs text-gray-400 mb-1">1h 30m</span>
                            <div class="w-full border-t-2 border-dashed border-gray-300 relative">
                                <i class="fa-solid fa-plane text-blue-500 absolute top-[-8px] right-0 bg-white px-1"></i>
                            </div>
                            <span class="text-xs text-green-600 mt-1">Bay thẳng</span>
                        </div>
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">10:00</div>
                            <div class="text-sm text-gray-500">Đà Nẵng</div>
                        </div>
                    </div>

                    <div class="w-full md:w-1/4 flex flex-col items-end border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-4">
                        <div class="text-2xl font-black text-orange-600 mb-2">1.200.000 đ</div>
                        <div class="text-xs text-gray-500 mb-3">/khách</div>
                        <a href="booking.jsp" class="w-full bg-orange-500 hover:bg-orange-600 text-white text-center font-bold py-2 px-4 rounded transition">
                            Chọn vé
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-5 hover:shadow-md transition">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                    <div class="w-full md:w-1/4 flex flex-col">
                        <span class="inline-block bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded w-max mb-1">Vietnam Airlines</span>
                        <span class="text-sm text-gray-500">VN-223 • Boeing 787</span>
                    </div>
                    
                    <div class="w-full md:w-2/4 flex justify-between items-center px-4">
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">14:00</div>
                            <div class="text-sm text-gray-500">Hà Nội</div>
                        </div>
                        <div class="flex flex-col items-center flex-1 px-4">
                            <span class="text-xs text-gray-400 mb-1">1h 20m</span>
                            <div class="w-full border-t-2 border-dashed border-gray-300 relative">
                                <i class="fa-solid fa-plane text-blue-500 absolute top-[-8px] right-0 bg-white px-1"></i>
                            </div>
                            <span class="text-xs text-green-600 mt-1">Bay thẳng</span>
                        </div>
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">15:20</div>
                            <div class="text-sm text-gray-500">Đà Nẵng</div>
                        </div>
                    </div>

                    <div class="w-full md:w-1/4 flex flex-col items-end border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-4">
                        <div class="text-2xl font-black text-orange-600 mb-2">1.550.000 đ</div>
                        <div class="text-xs text-gray-500 mb-3">/khách</div>
                        <a href="booking.jsp" class="w-full bg-orange-500 hover:bg-orange-600 text-white text-center font-bold py-2 px-4 rounded transition">
                            Chọn vé
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-5 hover:shadow-md transition">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                    <div class="w-full md:w-1/4 flex flex-col">
                        <span class="inline-block bg-green-100 text-green-800 text-xs font-bold px-2 py-1 rounded w-max mb-1">Bamboo Airways</span>
                        <span class="text-sm text-gray-500">QH-304 • Embraer 190</span>
                    </div>
                    
                    <div class="w-full md:w-2/4 flex justify-between items-center px-4">
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">19:15</div>
                            <div class="text-sm text-gray-500">Hà Nội</div>
                        </div>
                        <div class="flex flex-col items-center flex-1 px-4">
                            <span class="text-xs text-gray-400 mb-1">1h 25m</span>
                            <div class="w-full border-t-2 border-dashed border-gray-300 relative">
                                <i class="fa-solid fa-plane text-blue-500 absolute top-[-8px] right-0 bg-white px-1"></i>
                            </div>
                            <span class="text-xs text-green-600 mt-1">Bay thẳng</span>
                        </div>
                        <div class="text-center">
                            <div class="text-xl font-bold text-gray-900">20:40</div>
                            <div class="text-sm text-gray-500">Đà Nẵng</div>
                        </div>
                    </div>

                    <div class="w-full md:w-1/4 flex flex-col items-end border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-4">
                        <div class="text-2xl font-black text-orange-600 mb-2">980.000 đ</div>
                        <div class="text-xs text-gray-500 mb-3">/khách</div>
                        <a href="booking.jsp" class="w-full bg-orange-500 hover:bg-orange-600 text-white text-center font-bold py-2 px-4 rounded transition">
                            Chọn vé
                        </a>
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