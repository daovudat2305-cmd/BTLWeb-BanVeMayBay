<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đặt vé</title>
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
                    <div class="flex items-center gap-2 text-blue-600">
                        <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center">3</div>
                        <span>Xác nhận</span>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="bg-blue-800 text-white px-6 py-5">
                        <div class="text-blue-200 text-xs font-bold uppercase tracking-widest mb-1">Bước cuối cùng</div>
                        <h1 class="text-2xl font-extrabold">Kiểm tra lại thông tin đặt vé</h1>
                        <p class="text-sm text-blue-200 mt-2">Booking chỉ được tạo sau khi bạn bấm nút xác nhận ở dưới cùng.</p>
                    </div>

                    <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-5">
                        <div class="rounded-2xl border border-gray-200 bg-gray-50 p-5">
                            <div class="text-xs font-bold uppercase text-gray-500 mb-3">Thông tin hành khách</div>
                            <div class="space-y-3 text-sm">
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Họ và tên</span>
                                    <span class="font-bold text-gray-900 text-right">${passengerName}</span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">CCCD</span>
                                    <span class="font-bold text-gray-900 text-right">${cccd}</span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Số điện thoại</span>
                                    <span class="font-bold text-gray-900 text-right">${phone}</span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Email liên hệ</span>
                                    <span class="font-bold text-gray-900 text-right break-all">${email}</span>
                                </div>
                            </div>
                        </div>

                        <div class="rounded-2xl border border-blue-100 bg-blue-50 p-5">
                            <div class="text-xs font-bold uppercase text-blue-600 mb-3">Thông tin chuyến bay</div>
                            <div class="space-y-3 text-sm">
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Hãng bay</span>
                                    <span class="font-bold text-gray-900 text-right">${flight.airlineName}</span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Mã chuyến</span>
                                    <span class="font-bold text-gray-900 text-right">${flight.flightId}</span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Hành trình</span>
                                    <span class="font-bold text-gray-900 text-right">
                                        ${flight.departureAirport} <i class="fa-solid fa-arrow-right mx-1 text-xs text-gray-400"></i> ${flight.destinationAirport}
                                    </span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Khởi hành</span>
                                    <span class="font-bold text-gray-900 text-right">
                                        <fmt:formatDate pattern="HH:mm - dd/MM/yyyy" value="${flight.departureTime}" />
                                    </span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Hạ cánh</span>
                                    <span class="font-bold text-gray-900 text-right">
                                        <fmt:formatDate pattern="HH:mm - dd/MM/yyyy" value="${flight.arrivalTime}" />
                                    </span>
                                </div>
                                <div class="flex justify-between gap-4">
                                    <span class="text-gray-500">Giá vé</span>
                                    <span class="font-black text-orange-600 text-right">
                                        <fmt:formatNumber value="${flight.price}" type="number" pattern="###,###" /> đ
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <form id="bookingForm" action="book-ticket" method="POST" class="border-t border-gray-200 bg-gray-50 px-6 py-6">
                        <input type="hidden" name="flightId" value="${flight.flightId}">
                        <input type="hidden" name="passengerName" value="${passengerName}">
                        <input type="hidden" name="cccd" value="${cccd}">
                        <input type="hidden" name="phone" value="${phone}">
                        <input type="hidden" name="email" value="${email}">

                        <div class="flex flex-col sm:flex-row gap-3">
                            <button type="button" onclick="history.back()" class="flex-1 bg-white border border-gray-300 text-gray-700 font-bold py-3 px-6 rounded-xl hover:bg-gray-100 transition">
                                Quay lại chỉnh sửa
                            </button>
                            <button type="button" onclick="openQRModal()" class="flex-1 bg-orange-500 hover:bg-orange-600 text-white font-bold py-3 px-6 rounded-xl transition">
                                Xác nhận đặt vé
                            </button>
                        </div>
                    </form>
                </div>
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
                                <span>Hành khách</span>
                                <span class="font-bold text-gray-900">${passengerName}</span>
                            </div>
                            <div class="flex justify-between text-gray-600">
                                <span>Email</span>
                                <span class="font-bold text-gray-900 text-right break-all">${email}</span>
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
	
	<div id="qrModal" class="fixed inset-0 z-50 hidden bg-gray-900/60 backdrop-blur-sm flex items-center justify-center transition-opacity px-4">
        <div class="bg-white rounded-2xl shadow-2xl w-full max-w-sm p-6 relative">
            
            <button type="button" onclick="closeQRModal()" class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition">
                <i class="fa-solid fa-xmark text-xl"></i>
            </button>

            <div class="text-center mb-4 mt-2">
                <h3 class="text-xl font-black text-gray-900">Thanh toán vé máy bay</h3>
                <p class="text-sm text-gray-500 mt-1">Quét mã QR qua ứng dụng ngân hàng</p>
            </div>

            <img src="https://img.vietqr.io/image/MB-0343649920-compact.png?amount=${flight.price}&addInfo=Thanh toan ve ${flight.flightId} ${passengerName}" class="w-60 mx-auto mb-4">

            <div class="text-center w-full pt-1 border-t border-dashed border-gray-200 mt-1">
                <span class="block text-[10px] text-gray-500 uppercase font-bold tracking-widest mt-2 mb-1">Tổng tiền thanh toán</span>
                <span class="text-2xl font-black text-orange-600"><fmt:formatNumber value="${flight.price}" type="number" pattern="###,###" /> đ</span>
            </div>

            <div class="text-left text-sm mt-3">
                <p><b>Nội dung:</b> Thanh toan ve ${flight.flightId} ${passengerName}</p>
            </div>
            
            <div class="bg-blue-50 text-blue-700 text-[11px] p-3 rounded-xl mb-5 flex gap-2 items-start border border-blue-100">
                <i class="fa-solid fa-circle-info text-base mt-0.5 shrink-0"></i>
                <p class="leading-relaxed">Sau khi chuyển khoản, vui lòng nhấn <strong>"Hoàn thành"</strong>. Vé sẽ được chuyển sang <strong>Chờ xử lý</strong> để duyệt.</p>
            </div>

            <div class="flex gap-3">
                <button type="button" onclick="closeQRModal()" class="flex-1 px-4 py-3 rounded-xl font-bold text-gray-600 bg-gray-100 hover:bg-gray-200 transition text-sm">
                    Hủy bỏ
                </button>
                <button type="button" onclick="submitBookingFlow()" class="flex-1 px-4 py-3 rounded-xl font-bold text-white bg-blue-600 hover:bg-blue-700 transition shadow-lg shadow-blue-200 flex items-center justify-center gap-2 text-sm">
                    <i class="fa-solid fa-check"></i> Hoàn thành
                </button>
            </div>
        </div>
    </div>

    <script>
        function openQRModal() {
            document.getElementById('qrModal').classList.remove('hidden');
        }

        function closeQRModal() {
            document.getElementById('qrModal').classList.add('hidden');
        }

        function submitBookingFlow() {
            // Khi khách hàng bấm "Hoàn thành", submit form ẩn đi để gọi Servlet
            document.getElementById('bookingForm').submit();
        }
    </script>
</body>
</html>