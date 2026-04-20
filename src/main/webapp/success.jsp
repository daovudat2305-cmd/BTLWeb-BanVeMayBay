<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé thành công</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
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
                <a href="home" class="text-gray-600 hover:text-blue-600">Trang Chủ</a>
                <a href="#" class="text-gray-600 hover:text-blue-600">Săn Vé Rẻ</a>
                <a href="history" class="text-gray-600 hover:text-blue-600 flex items-center gap-1">
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

    <main class="flex-grow flex items-center justify-center p-4">
        <c:choose>
            <c:when test="${empty booking}">
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 max-w-lg w-full text-center p-10">
                    <div class="w-20 h-20 mx-auto mb-5 rounded-full bg-red-50 text-red-500 flex items-center justify-center text-4xl">
                        <i class="fa-solid fa-ticket"></i>
                    </div>
                    <h1 class="text-2xl font-extrabold text-gray-900 mb-3">Không tìm thấy thông tin đặt vé</h1>
                    <p class="text-gray-500 mb-6">Mã đặt chỗ không tồn tại hoặc không thuộc tài khoản hiện tại.</p>
                    <a href="history" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-bold px-6 py-3 rounded-xl transition">
                        <i class="fa-solid fa-clock-rotate-left"></i> Xem lịch sử đặt vé
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 max-w-2xl w-full text-center overflow-hidden">
                    <div class="bg-green-500 py-8 flex justify-center">
                        <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center text-green-500 text-4xl shadow-inner">
                            <i class="fa-solid fa-check"></i>
                        </div>
                    </div>

                    <div class="p-8">
                        <h2 class="text-3xl font-extrabold text-gray-800 mb-2">Đặt vé thành công!</h2>
                        <p class="text-gray-500 mb-6">Hệ thống đã ghi nhận mã đặt chỗ cho tài khoản của bạn. Bạn có thể xem lại bất kỳ lúc nào trong phần lịch sử đặt vé.</p>

                        <div class="bg-gray-50 rounded-xl p-5 text-left mb-8 border border-gray-200">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4 text-sm">
                                <div class="text-gray-500">Mã đặt chỗ (PNR)</div>
                                <div class="font-bold text-blue-600 md:text-right text-lg">${booking.bookingId}</div>

                                <div class="text-gray-500">Hành khách</div>
                                <div class="font-bold text-gray-800 md:text-right">${booking.passengerName}</div>

                                <div class="text-gray-500">Chuyến bay</div>
                                <div class="font-bold text-gray-800 md:text-right">
                                    ${booking.flight.departureAirportName}
                                    <i class="fa-solid fa-arrow-right mx-1 text-xs text-gray-400"></i>
                                    ${booking.flight.destinationAirportName}
                                </div>

                                <div class="text-gray-500">Mã chuyến</div>
                                <div class="font-bold text-gray-800 md:text-right">${booking.flight.flightId}</div>

                                <div class="text-gray-500">Thời gian khởi hành</div>
                                <div class="font-bold text-gray-800 md:text-right">
                                    <fmt:formatDate pattern="HH:mm - dd/MM/yyyy" value="${booking.flight.departureTime}" />
                                </div>

                                <div class="text-gray-500">Số điện thoại</div>
                                <div class="font-bold text-gray-800 md:text-right">${booking.phone}</div>

                                <div class="text-gray-500">Email liên hệ</div>
                                <div class="font-bold text-gray-800 md:text-right">${empty booking.email ? 'Chưa cập nhật' : booking.email}</div>

                                <div class="text-gray-500">Tổng thanh toán</div>
                                <div class="font-black text-orange-600 md:text-right text-lg">
                                    <fmt:formatNumber value="${booking.flight.price}" type="number" pattern="###,###" /> đ
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-col sm:flex-row gap-4 justify-center">
                            <a href="home" class="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-800 font-bold py-3 px-6 rounded-xl transition">
                                Về trang chủ
                            </a>
                            <a href="history" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-xl transition shadow-md shadow-blue-200">
                                Xem vé của tôi
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
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
