<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Đặt vé Máy bay</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans flex flex-col min-h-screen">

    <nav class="bg-white px-8 py-4 flex justify-between items-center shadow-sm">
        <div class="flex items-center space-x-8">
            <div class="text-2xl font-black text-blue-800 flex items-center gap-2">
                <i class="fa-solid fa-plane-departure"></i> Vé Máy Bay
            </div>
            <div class="hidden md:flex space-x-6 font-medium items-center">
                <a href="index.jsp" class="text-blue-600 border-b-2 border-blue-600 pb-1">Trang Chủ</a>
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

    <main class="flex-grow">
        <div class="bg-[#1e3a8a] py-16 px-4">
            <div class="max-w-6xl mx-auto bg-white rounded-2xl shadow-xl p-6 md:p-8">
                
                <div class="flex space-x-6 mb-6">
                    <label class="flex items-center space-x-2 cursor-pointer text-gray-700 font-medium">
                        <input type="radio" name="trip_type" value="oneway" id="radio-oneway" class="w-5 h-5 text-blue-600 focus:ring-blue-500" checked onclick="toggleReturnDate()">
                        <span>Một chiều</span>
                    </label>
                    <label class="flex items-center space-x-2 cursor-pointer text-gray-700 font-medium">
                        <input type="radio" name="trip_type" value="roundtrip" id="radio-roundtrip" class="w-5 h-5 text-blue-600 focus:ring-blue-500" onclick="toggleReturnDate()">
                        <span>Khứ hồi</span>
                    </label>
                </div>

                <form action="flight_list.jsp" method="GET" class="grid grid-cols-1 md:grid-cols-5 gap-4 items-end">
                    
                    <div class="relative">
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-2">Điểm đi</label>
                        <div class="relative">
                            <i class="fa-solid fa-location-dot absolute left-4 top-3.5 text-gray-400"></i>
                            <input type="text" name="departure" placeholder="Ví dụ: Hà Nội" class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 font-medium">
                        </div>
                    </div>

                    <div class="relative">
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-2">Điểm đến</label>
                        <div class="relative">
                            <i class="fa-solid fa-location-dot absolute left-4 top-3.5 text-gray-400"></i>
                            <input type="text" name="destination" placeholder="Ví dụ: Đà Nẵng" class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 font-medium">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-2">Ngày khởi hành</label>
                        <div class="relative">
                            <input type="date" name="depart_date" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 text-gray-600">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-2">Khứ hồi</label>
                        <div class="relative">
                            <input type="date" id="return-date-input" name="return_date" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 text-gray-400 bg-gray-100" disabled>
                        </div>
                    </div>

                    <button type="submit" class="bg-[#f97316] text-white font-bold py-3 rounded-lg hover:bg-orange-600 transition flex justify-center items-center gap-2">
                        <i class="fa-solid fa-magnifying-glass"></i> TÌM CHUYẾN BAY
                    </button>
                </form>
            </div>
        </div>

        <div class="bg-white py-12 px-4 text-center">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-50 rounded-full mb-4">
                <i class="fa-solid fa-plane text-2xl text-blue-600"></i>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Tìm kiếm dễ dàng</h3>
            <p class="text-gray-500 max-w-sm mx-auto">Hơn 100 hãng hàng không nội địa và quốc tế được tích hợp.</p>
        </div>

        <div class="bg-gray-50 py-16 px-4">
            <div class="text-center mb-10">
                <h2 class="text-3xl font-extrabold text-gray-900 mb-3">Vé máy bay rẻ nhất</h2>
                <p class="text-gray-500">Cập nhật giá vé tốt nhất mỗi ngày.</p>
            </div>

            <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                
                <div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition overflow-hidden relative border border-gray-100">
                    <div class="absolute top-3 right-3 bg-red-600 text-white text-sm font-bold px-3 py-1.5 rounded">
                        1.200.000 đ
                    </div>
                    <img src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=2102&auto=format&fit=crop" alt="Đà Nẵng" class="w-full h-48 object-cover">
                    <div class="p-5 text-center">
                        <span class="inline-block bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded mb-2">Vietjet Air</span>
                        <h4 class="text-lg font-bold text-gray-900 mb-1">
                            Hà Nội <i class="fa-solid fa-arrow-right text-blue-500 mx-1 text-sm"></i> Đà Nẵng
                        </h4>
                        <p class="text-xs text-gray-400 mb-5">Khởi hành: 22/11/2026</p>
                        <button class="w-full border-2 border-blue-600 text-blue-600 font-semibold py-2 rounded-lg hover:bg-blue-50 transition">
                            Mua ngay
                        </button>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition overflow-hidden relative border border-gray-100">
                    <div class="absolute top-3 right-3 bg-red-600 text-white text-sm font-bold px-3 py-1.5 rounded">
                        1.550.000 đ
                    </div>
                    <img src="https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&q=80&w=2070" alt="Hà Nội" class="w-full h-48 object-cover">
                    <div class="p-5 text-center">
                        <span class="inline-block bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded mb-2">Vietnam Airlines</span>
                        <h4 class="text-lg font-bold text-gray-900 mb-1">
                            Hồ Chí Minh <i class="fa-solid fa-arrow-right text-blue-500 mx-1 text-sm"></i> Hà Nội
                        </h4>
                        <p class="text-xs text-gray-400 mb-5">Khởi hành: 25/11/2026</p>
                        <button class="w-full border-2 border-blue-600 text-blue-600 font-semibold py-2 rounded-lg hover:bg-blue-50 transition">
                            Mua ngay
                        </button>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition overflow-hidden relative border border-gray-100">
                    <div class="absolute top-3 right-3 bg-red-600 text-white text-sm font-bold px-3 py-1.5 rounded">
                        980.000 đ
                    </div>
                    <img src="https://images.unsplash.com/photo-1583417319070-4a69db38a482?q=80&w=2070&auto=format&fit=crop" alt="Nha Trang" class="w-full h-48 object-cover">
                    <div class="p-5 text-center">
                        <span class="inline-block bg-green-100 text-green-800 text-xs font-bold px-2 py-1 rounded mb-2">Bamboo Airways</span>
                        <h4 class="text-lg font-bold text-gray-900 mb-1">
                            Hà Nội <i class="fa-solid fa-arrow-right text-blue-500 mx-1 text-sm"></i> Nha Trang
                        </h4>
                        <p class="text-xs text-gray-400 mb-5">Khởi hành: 30/11/2026</p>
                        <button class="w-full border-2 border-blue-600 text-blue-600 font-semibold py-2 rounded-lg hover:bg-blue-50 transition">
                            Mua ngay
                        </button>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition overflow-hidden relative border border-gray-100">
                    <div class="absolute top-3 right-3 bg-red-600 text-white text-sm font-bold px-3 py-1.5 rounded">
                        890.000 đ
                    </div>
                    <img src="https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?q=80&w=1974&auto=format&fit=crop" alt="Đà Lạt" class="w-full h-48 object-cover">
                    <div class="p-5 text-center">
                        <span class="inline-block bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded mb-2">Vietjet Air</span>
                        <h4 class="text-lg font-bold text-gray-900 mb-1">
                            Hồ Chí Minh <i class="fa-solid fa-arrow-right text-blue-500 mx-1 text-sm"></i> Đà Lạt
                        </h4>
                        <p class="text-xs text-gray-400 mb-5">Khởi hành: 05/12/2026</p>
                        <button class="w-full border-2 border-blue-600 text-blue-600 font-semibold py-2 rounded-lg hover:bg-blue-50 transition">
                            Mua ngay
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
    
    <script>
        function toggleReturnDate() {
            const isRoundTrip = document.getElementById('radio-roundtrip').checked;
            const returnDateInput = document.getElementById('return-date-input');
            
            if (isRoundTrip) {
                // Mở khóa ô chọn ngày
                returnDateInput.disabled = false;
                // Đổi màu nền trắng, chữ đen cho giống các ô khác
                returnDateInput.classList.remove('bg-gray-100', 'text-gray-400');
                returnDateInput.classList.add('text-gray-600', 'bg-white');
            } else {
                // Khóa lại ô chọn ngày
                returnDateInput.disabled = true;
                returnDateInput.value = ''; // Xóa trắng ngày đã chọn (nếu có)
                // Đổi màu nền xám, chữ mờ
                returnDateInput.classList.add('bg-gray-100', 'text-gray-400');
                returnDateInput.classList.remove('text-gray-600', 'bg-white');
            }
        }
    </script>
    
    
</body>
</html>