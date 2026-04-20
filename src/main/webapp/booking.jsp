<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết chuyến bay và đặt vé</title>
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

    <main class="flex-grow max-w-6xl mx-auto w-full py-10 px-4">
        <c:if test="${not empty error}">
            <div class="mb-6 rounded-2xl border border-red-200 bg-red-50 px-5 py-4 text-red-700 font-medium">
                <i class="fa-solid fa-circle-exclamation mr-2"></i>${error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty flight}">
                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-10 text-center">
                    <div class="w-20 h-20 mx-auto mb-5 rounded-full bg-red-50 text-red-500 flex items-center justify-center text-4xl">
                        <i class="fa-solid fa-plane-circle-xmark"></i>
                    </div>
                    <h1 class="text-2xl font-extrabold text-gray-900 mb-3">Không tìm thấy chuyến bay</h1>
                    <p class="text-gray-500 mb-6">Liên kết có thể không còn hợp lệ hoặc chuyến bay đã bị xóa khỏi hệ thống.</p>
                    <a href="home" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-bold px-6 py-3 rounded-xl transition">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="md:col-span-2 space-y-6">
                        <div class="bg-white rounded-xl shadow-sm p-4 border border-gray-200 flex justify-between items-center text-sm font-bold text-gray-500">
                            <div class="flex items-center gap-2 text-blue-600">
                                <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center">1</div>
                                <span>Xem chi tiết</span>
                            </div>
                            <div class="flex-1 border-t-2 border-dashed border-gray-300 mx-4"></div>
                            <div class="flex items-center gap-2 text-blue-600">
                                <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center">2</div>
                                <span>Điền thông tin</span>
                            </div>
                            <div class="flex-1 border-t-2 border-dashed border-gray-300 mx-4"></div>
                            <div class="flex items-center gap-2">
                                <div class="w-6 h-6 rounded-full bg-gray-200 text-gray-500 flex items-center justify-center">3</div>
                                <span>Xác nhận</span>
                            </div>
                        </div>

                        <div class="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="bg-blue-800 text-white px-6 py-5">
                                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
                                    <div>
                                        <div class="text-blue-200 text-xs font-bold uppercase tracking-widest mb-1">Chi tiết chuyến bay</div>
                                        <h1 class="text-2xl font-extrabold">
                                            ${flight.departureAirportName}
                                            <i class="fa-solid fa-arrow-right-long mx-2 text-sm"></i>
                                            ${flight.destinationAirportName}
                                        </h1>
                                    </div>
                                    <div class="bg-white/10 rounded-xl px-4 py-3">
                                        <div class="text-xs text-blue-200 font-bold uppercase">Còn lại</div>
                                        <div class="text-2xl font-black">${flight.availableSeats} ghế</div>
                                    </div>
                                </div>
                            </div>

                            <div class="p-6 grid grid-cols-1 md:grid-cols-4 gap-4">
                                <div class="rounded-2xl border border-blue-100 bg-blue-50 p-4">
                                    <div class="text-xs font-bold uppercase text-blue-600 mb-2">Hãng bay</div>
                                    <div class="text-lg font-black text-gray-900">${flight.airlineName}</div>
                                    <div class="text-sm text-gray-500 mt-1">${flight.flightId}</div>
                                </div>
                                <div class="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                                    <div class="text-xs font-bold uppercase text-gray-500 mb-2">Khởi hành</div>
                                    <div class="text-lg font-black text-gray-900"><fmt:formatDate pattern="HH:mm" value="${flight.departureTime}" /></div>
                                    <div class="text-sm text-gray-500 mt-1"><fmt:formatDate pattern="dd/MM/yyyy" value="${flight.departureTime}" /></div>
                                </div>
                                <div class="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                                    <div class="text-xs font-bold uppercase text-gray-500 mb-2">Điểm đi / điểm đến</div>
                                    <div class="text-sm font-black text-gray-900">${flight.departureAirport} <i class="fa-solid fa-arrow-right mx-1 text-xs text-gray-400"></i> ${flight.destinationAirport}</div>
                                    <div class="text-sm text-gray-500 mt-1">${flight.departureAirportName} đến ${flight.destinationAirportName}</div>
                                </div>
                                <div class="rounded-2xl border border-orange-100 bg-orange-50 p-4">
                                    <div class="text-xs font-bold uppercase text-orange-600 mb-2">Giá vé</div>
                                    <div class="text-2xl font-black text-orange-600"><fmt:formatNumber value="${flight.price}" type="number" pattern="###,###" /> đ</div>
                                </div>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${user == null}">
                                <div class="bg-white rounded-2xl shadow-sm border border-yellow-200 overflow-hidden">
                                    <div class="bg-yellow-50 border-b border-yellow-200 px-6 py-4 text-yellow-800 font-bold">
                                        <i class="fa-solid fa-lock mr-2"></i>Đăng nhập để tiếp tục đặt vé
                                    </div>
                                    <div class="p-6">
                                        <p class="text-gray-600 mb-5">Bạn có thể xem chi tiết chuyến bay ngay tại đây, nhưng cần đăng nhập trước khi nhập thông tin hành khách và xác nhận đặt vé.</p>
                                        <div class="flex flex-col sm:flex-row gap-3">
                                            <a href="login.jsp" class="flex-1 bg-blue-600 hover:bg-blue-700 text-white text-center font-bold py-3 rounded-xl transition">Đăng nhập</a>
                                            <a href="register.jsp" class="flex-1 bg-white border border-blue-200 text-blue-700 text-center font-bold py-3 rounded-xl transition hover:bg-blue-50">Tạo tài khoản</a>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${flight.availableSeats <= 0}">
                                <div class="bg-white rounded-2xl shadow-sm border border-red-200 overflow-hidden">
                                    <div class="bg-red-50 border-b border-red-200 px-6 py-4 text-red-700 font-bold">
                                        <i class="fa-solid fa-seat-airline mr-2"></i>Chuyến bay đã hết ghế
                                    </div>
                                    <div class="p-6 text-gray-600">
                                        Vé cho chuyến bay này hiện không còn khả dụng. Bạn có thể quay lại danh sách chuyến bay để chọn hành trình khác.
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form action="booking-confirm" method="POST" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                                    <input type="hidden" name="flightId" value="${flight.flightId}">

                                    <div class="bg-blue-800 text-white px-6 py-4">
                                        <h2 class="text-lg font-bold"><i class="fa-solid fa-address-card mr-2"></i>Thông tin hành khách</h2>
                                        <p class="text-sm text-blue-200 mt-1">Điền chính xác thông tin để hệ thống ghi nhận đặt chỗ và hiển thị trong lịch sử đặt vé.</p>
                                    </div>

                                    <div class="p-6 space-y-5">
                                        <div>
                                            <label class="block text-gray-700 font-bold mb-2">Họ và tên hành khách <span class="text-red-500">*</span></label>
                                            <input
                                                type="text"
                                                name="passengerName"
                                                value="${not empty formPassengerName ? formPassengerName : user.fullName}"
                                                placeholder="Ví dụ: NGUYEN VAN A"
                                                required
                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 uppercase"
                                            >
                                        </div>

                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                            <div>
                                                <label class="block text-gray-700 font-bold mb-2">Số CCCD <span class="text-red-500">*</span></label>
                                                <input
                                                    type="text"
                                                    name="cccd"
                                                    value="${formCccd}"
                                                    placeholder="Nhập 12 số CCCD"
                                                    required
                                                    pattern="[0-9]{12}"
                                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                                >
                                            </div>

                                            <div>
                                                <label class="block text-gray-700 font-bold mb-2">Số điện thoại <span class="text-red-500">*</span></label>
                                                <input
                                                    type="tel"
                                                    name="phone"
                                                    value="${formPhone}"
                                                    placeholder="Ví dụ: 0912345678"
                                                    required
                                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                                >
                                            </div>
                                        </div>

                                        <div>
                                            <label class="block text-gray-700 font-bold mb-2">Email liên hệ</label>
                                            <input
                                                type="email"
                                                name="email"
                                                value="${formEmail}"
                                                placeholder="Ví dụ: abc@gmail.com"
                                                required
                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                            >
                                            <p class="text-xs text-gray-400 mt-2">Bạn có thể nhập bất kỳ email nào để nhận thông tin liên hệ cho vé này.</p>
                                        </div>
                                    </div>

                                    <div class="p-6 bg-gray-50 border-t border-gray-200">
                                        <p class="text-sm text-gray-500 mb-4">
                                            Sau khi tiếp tục, hệ thống sẽ chuyển sang bước xác nhận cuối cùng trước khi tạo mã đặt chỗ.
                                        </p>
                                        <button type="submit" class="w-full bg-orange-500 hover:bg-orange-600 text-white font-bold text-lg py-4 rounded-xl transition flex justify-center items-center gap-2">
                                            TIẾP TỤC XÁC NHẬN <i class="fa-solid fa-circle-check"></i>
                                        </button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <aside class="md:col-span-1">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden sticky top-24">
                            <div class="p-5 border-b border-gray-200">
                                <h3 class="font-bold text-lg text-gray-800">Tóm tắt chuyến bay</h3>
                            </div>

                            <div class="p-5">
                                <div class="flex items-center gap-3 mb-4">
                                    <span class="bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded">${flight.airlineName}</span>
                                    <span class="text-sm font-bold text-gray-700">${flight.flightId}</span>
                                </div>

                                <div class="flex justify-between items-center mb-6">
                                    <div class="text-center">
                                        <div class="text-lg font-bold"><fmt:formatDate pattern="HH:mm" value="${flight.departureTime}" /></div>
                                        <div class="text-xs text-gray-500">${flight.departureAirport}</div>
                                    </div>
                                    <div class="flex flex-col items-center px-2 flex-1">
                                        <span class="text-xs text-gray-400">Bay thẳng</span>
                                        <div class="w-full border-t border-dashed border-gray-400 my-1 relative">
                                            <i class="fa-solid fa-plane text-gray-400 absolute top-[-7px] right-0 bg-white pl-1"></i>
                                        </div>
                                        <span class="text-xs text-gray-400"><fmt:formatDate pattern="dd/MM/yyyy" value="${flight.departureTime}" /></span>
                                    </div>
                                    <div class="text-center">
                                        <div class="text-lg font-bold"><fmt:formatDate pattern="HH:mm" value="${flight.arrivalTime}" /></div>
                                        <div class="text-xs text-gray-500">${flight.destinationAirport}</div>
                                    </div>
                                </div>

                                <div class="space-y-3 text-sm border-t border-gray-200 pt-4">
                                    <div class="flex justify-between text-gray-600">
                                        <span>Điểm đi</span>
                                        <span class="font-bold text-gray-900">${flight.departureAirportName}</span>
                                    </div>
                                    <div class="flex justify-between text-gray-600">
                                        <span>Điểm đến</span>
                                        <span class="font-bold text-gray-900">${flight.destinationAirportName}</span>
                                    </div>
                                    <div class="flex justify-between text-gray-600">
                                        <span>Số ghế còn lại</span>
                                        <span class="font-bold text-gray-900">${flight.availableSeats}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="bg-gray-50 p-5 border-t border-gray-200">
                                <div class="flex justify-between items-end">
                                    <span class="font-bold text-gray-700">TỔNG CỘNG</span>
                                    <span class="text-2xl font-black text-orange-600"><fmt:formatNumber value="${flight.price}" type="number" pattern="###,###" /> đ</span>
                                </div>
                            </div>
                        </div>
                    </aside>
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
