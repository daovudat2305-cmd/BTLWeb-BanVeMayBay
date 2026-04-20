<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt vé của tôi</title>
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
                <a href="history" class="text-blue-600 border-b-2 border-blue-600 pb-1 flex items-center gap-1">
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

    <main class="flex-grow max-w-5xl mx-auto w-full py-10 px-4">
        <div class="mb-8 flex flex-col md:flex-row md:items-end md:justify-between gap-4">
            <div>
                <h1 class="text-2xl font-extrabold text-gray-900">Lịch sử đặt vé</h1>
                <p class="text-gray-500 mt-1">Xem lại toàn bộ mã đặt chỗ, hành khách và thông tin chuyến bay thuộc tài khoản của bạn.</p>
            </div>
            <a href="home" class="inline-flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-bold px-5 py-3 rounded-xl transition">
                <i class="fa-solid fa-magnifying-glass"></i> Tìm chuyến bay mới
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <div class="bg-white rounded-2xl border border-gray-200 shadow-sm p-5">
                <div class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-2">Tổng số vé</div>
                <div class="text-3xl font-black text-gray-900">${totalBookings}</div>
            </div>
            <div class="bg-white rounded-2xl border border-green-100 shadow-sm p-5">
                <div class="text-xs font-bold uppercase tracking-widest text-green-500 mb-2">Sắp khởi hành</div>
                <div class="text-3xl font-black text-green-600">${upcomingCount}</div>
            </div>
            <div class="bg-white rounded-2xl border border-gray-200 shadow-sm p-5">
                <div class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-2">Đã hoàn thành</div>
                <div class="text-3xl font-black text-gray-700">${completedCount}</div>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-10 text-center">
                    <div class="w-20 h-20 mx-auto mb-5 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center text-4xl">
                        <i class="fa-solid fa-ticket"></i>
                    </div>
                    <h2 class="text-2xl font-extrabold text-gray-900 mb-3">Bạn chưa có vé nào</h2>
                    <p class="text-gray-500 mb-6">Sau khi hoàn tất đặt chỗ, mã vé và thông tin chuyến bay sẽ xuất hiện tại đây.</p>
                    <a href="home" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-bold px-6 py-3 rounded-xl transition">
                        <i class="fa-solid fa-plane-up"></i> Bắt đầu đặt vé
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-6">
                    <c:forEach var="b" items="${bookings}">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition">
                            <div class="${b.upcoming ? 'bg-green-50' : 'bg-gray-100'} px-5 py-3 border-b border-gray-200 flex flex-col md:flex-row md:justify-between md:items-center gap-2">
                                <div class="flex items-center gap-2 ${b.upcoming ? 'text-green-700' : 'text-gray-600'} font-bold text-sm">
                                    <i class="fa-solid ${b.upcoming ? 'fa-circle-check' : 'fa-plane-arrival'}"></i>
                                    ${b.upcoming ? 'ĐÃ ĐẶT - SẮP KHỞI HÀNH' : 'ĐÃ HOÀN THÀNH'}
                                </div>
                                <div class="text-gray-500 text-sm">
                                    Mã đặt chỗ:
                                    <span class="font-bold text-gray-900">${b.bookingId}</span>
                                </div>
                            </div>

                            <div class="p-5 flex flex-col md:flex-row justify-between items-center gap-6">
                                <div class="flex-1 w-full">
                                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3 mb-4">
                                        <div class="flex items-center gap-3">
                                            <span class="bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded">${b.flight.airlineName}</span>
                                            <span class="text-sm font-bold text-gray-700">${b.flight.flightId}</span>
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            Đặt lúc:
                                            <span class="font-bold text-gray-700"><fmt:formatDate pattern="HH:mm - dd/MM/yyyy" value="${b.bookingTime}" /></span>
                                        </div>
                                    </div>

                                    <div class="flex justify-between items-center gap-4">
                                        <div>
                                            <div class="text-xl font-bold"><fmt:formatDate pattern="HH:mm" value="${b.flight.departureTime}" /></div>
                                            <div class="text-sm text-gray-500">${b.flight.departureAirportName} (${b.flight.departureAirport})</div>
                                        </div>
                                        <div class="flex flex-col items-center px-4 flex-1">
                                            <span class="text-xs text-gray-400">${b.passengerName}</span>
                                            <div class="w-full border-t border-dashed border-gray-400 my-1 relative">
                                                <i class="fa-solid fa-plane text-blue-500 absolute top-[-7px] right-0 bg-white pl-1"></i>
                                            </div>
                                            <span class="text-xs text-gray-800 font-medium"><fmt:formatDate pattern="dd/MM/yyyy" value="${b.flight.departureTime}" /></span>
                                        </div>
                                        <div class="text-right">
                                            <div class="text-xl font-bold"><fmt:formatDate pattern="HH:mm" value="${b.flight.arrivalTime}" /></div>
                                            <div class="text-sm text-gray-500">${b.flight.destinationAirportName} (${b.flight.destinationAirport})</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="w-full md:w-auto flex flex-col gap-3 border-t md:border-t-0 md:border-l pt-4 md:pt-0 pl-0 md:pl-6 border-gray-200">
                                    <div class="text-right">
                                        <div class="text-sm text-gray-500">Tổng tiền</div>
                                        <div class="text-lg font-black text-orange-600"><fmt:formatNumber value="${b.flight.price}" type="number" pattern="###,###" /> đ</div>
                                    </div>
                                    <div class="text-sm text-gray-500">
                                        CCCD:
                                        <span class="font-bold text-gray-700">${b.cccd}</span>
                                    </div>
                                    <a href="booking-success?id=${b.bookingId}" class="bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold py-2 px-6 rounded-lg transition text-center border border-blue-200">
                                        Xem chi tiết vé
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
            <div class="space-x-4 text-sm flex flex-col md:flex-row items-center gap-2 md:gap-0">
                <a href="#" class="hover:text-white transition">Điều khoản sử dụng</a>
                <span class="hidden md:inline">|</span>
                <a href="#" class="hover:text-white transition">Chính sách bảo mật</a>
            </div>
        </div>
    </footer>

</body>
</html>
