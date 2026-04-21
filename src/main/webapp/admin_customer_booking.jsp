<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đặt vé - Admin</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans flex min-h-screen">

    <aside class="w-64 bg-[#1e3a8a] text-white flex flex-col sticky top-0 h-screen shrink-0">
        <div class="p-6 text-xl font-black border-b border-blue-700 flex items-center gap-2">
            <i class="fa-solid fa-plane-departure"></i> Vé Máy Bay
        </div>  
        <nav class="flex-grow p-4 space-y-2 mt-4">
            <a href="adminDashboard" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-chart-pie w-5"></i> Tổng quan
            </a>
            <a href="adminFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-plane w-5"></i> Quản lý chuyến bay
            </a>
            <a href="adminCompletedFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-file-invoice-dollar w-5"></i> Chuyến bay hoàn thành
            </a>
            <a href="adminBookings" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
                <i class="fa-solid fa-users w-5"></i> Danh sách đặt vé
            </a>
            <a href="logout" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>
        <div class="p-6 border-t border-blue-700">
            <a href="home" class="flex items-center gap-3 py-2 px-4 text-blue-300 hover:text-white transition"> Về trang chủ </a>
        </div>
    </aside>

    <main class="flex-1 flex flex-col overflow-x-hidden">
        <div class="bg-[#1e3a8a] text-white pt-8 pb-12 px-8">
            <div class="flex justify-between items-end">
                <div>
                    <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Hành khách & Giao dịch</div>
                    <h2 class="text-3xl font-bold">Danh sách đặt vé</h2>
                </div>
            </div>
        </div>

        <div class="px-8 -mt-6 pb-12">
            <form action="adminBookings" method="GET" class="bg-white p-4 rounded-t-2xl border border-gray-100 shadow-sm flex flex-wrap gap-4 items-center justify-between m-0">
                <div class="relative w-full md:w-96">
                    <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" name="search" value="${searchQuery}" placeholder="Tìm theo mã PNR, Tên hoặc CCCD..." 
                           class="w-full pl-10 pr-4 py-2 border rounded-xl outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex gap-2">
                    <select name="status" onchange="this.form.submit()" class="border rounded-xl px-4 py-2 text-sm font-medium outline-none focus:ring-2 focus:ring-blue-500 cursor-pointer">
                        <option value="ALL" ${statusFilter == 'ALL' ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="APPROVED" ${statusFilter == 'APPROVED' ? 'selected' : ''}>Đã duyệt</option>
                        <option value="PENDING" ${statusFilter == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                        <option value="REJECTED" ${statusFilter == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
                    </select>
                    <button type="submit" class="hidden">Tìm</button>
                </div>
            </form>

            <div class="bg-white rounded-b-2xl shadow-sm border border-t-0 border-gray-100 overflow-hidden">
                <table class="w-full text-left border-collapse whitespace-nowrap">
                    <thead>
                        <tr class="bg-gray-50 text-gray-500 text-[10px] font-black uppercase tracking-widest border-b">
                            <th class="px-5 py-4">Mã đặt chỗ (PNR)</th>
                            <th class="px-5 py-4">Hành khách</th>
                            <th class="px-5 py-4">Chuyến bay</th>
                            <th class="px-5 py-4">Ngày đặt</th>
                            <th class="px-5 py-4 text-right">Tổng tiền</th>
                            <th class="px-5 py-4 text-center">Trạng thái</th>
                            <th class="px-5 py-4 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-50">
                        <c:forEach var="b" items="${bookingList}">
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-5 py-4">
                                    <span class="font-black text-blue-800 tracking-wider text-sm">${b.bookingId}</span>
                                </td>
                                <td class="px-5 py-4">
                                    <div class="font-bold text-gray-800 text-[13px] uppercase">${b.passengerName}</div>
                                    <div class="text-[10px] text-gray-400 mt-0.5">CCCD: ${b.cccd}</div>
                                </td>
                                <td class="px-5 py-4">
                                    <div class="text-xs font-bold text-gray-700">${b.flight.flightId}</div>
                                    <div class="text-[10px] text-gray-400 uppercase tracking-tighter mt-0.5">
                                        ${b.flight.departureAirport} <i class="fa-solid fa-arrow-right mx-1"></i> ${b.flight.destinationAirport}
                                    </div>
                                </td>
                                <td class="px-5 py-4 text-xs text-gray-500">
                                    <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${b.bookingTime}" />
                                </td>
                                <td class="px-5 py-4 text-right font-black text-orange-600 text-sm">
                                    <fmt:formatNumber value="${b.flight.price}" type="number" pattern="###,###"/> đ
                                </td>
                                <td class="px-5 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${b.status == 'PENDING'}">
                                            <span class="bg-orange-100 text-orange-700 text-[10px] font-black px-3 py-1.5 rounded-full uppercase inline-block">Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${b.status == 'APPROVED'}">
                                            <span class="bg-green-100 text-green-700 text-[10px] font-black px-3 py-1.5 rounded-full uppercase inline-block">Đã duyệt</span>
                                        </c:when>
                                        <c:when test="${b.status == 'REJECTED'}">
                                            <span class="bg-red-100 text-red-700 text-[10px] font-black px-3 py-1.5 rounded-full uppercase inline-block">Từ chối</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-4 flex justify-center gap-2 items-center">
                                    <c:if test="${b.status == 'PENDING'}">
                                        <form action="adminBookings" method="POST" class="m-0">
                                            <input type="hidden" name="bookingId" value="${b.bookingId}">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="page" value="${currentPage}">
                                            <button type="submit" class="w-8 h-8 flex items-center justify-center rounded-full bg-green-100 text-green-600 hover:bg-green-600 hover:text-white transition shadow-sm" title="Duyệt vé">
                                                <i class="fa-solid fa-check"></i>
                                            </button>
                                        </form>
                                        
                                        <button type="button" onclick="openRejectModal('${b.bookingId}', '${currentPage}')" class="w-8 h-8 flex items-center justify-center rounded-full bg-red-100 text-red-600 hover:bg-red-600 hover:text-white transition shadow-sm" title="Từ chối vé">
										    <i class="fa-solid fa-xmark"></i>
										</button>
                                    </c:if>

                                    <button class="w-8 h-8 flex items-center justify-center rounded-full bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white transition shadow-sm" title="Xem chi tiết">
                                        <i class="fa-solid fa-circle-info"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="p-4 bg-gray-50 border-t flex flex-col md:flex-row justify-between items-center text-xs text-gray-500 font-bold gap-4">
                    <div>Hiển thị ${startItem} - ${endItem} trên <fmt:formatNumber value="${totalBookings}" type="number" pattern="###,###"/> kết quả</div>
                    
                    <c:if test="${totalPages > 1}">
                        <div class="flex gap-1">
                            <c:if test="${currentPage > 1}">
                                <a href="adminBookings?page=${currentPage - 1}&search=${searchQuery}&status=${statusFilter}" class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition shadow-sm"><i class="fa-solid fa-chevron-left"></i></a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="adminBookings?page=${i}&search=${searchQuery}&status=${statusFilter}" class="w-8 h-8 flex items-center justify-center rounded transition shadow-sm ${currentPage == i ? 'bg-[#1e3a8a] text-white' : 'bg-white border border-gray-200 hover:bg-gray-100'}">
                                    ${i}
                                </a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="adminBookings?page=${currentPage + 1}&search=${searchQuery}&status=${statusFilter}" class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition shadow-sm"><i class="fa-solid fa-chevron-right"></i></a>
                            </c:if>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>
    </main>
    
    
    
    <div id="rejectModal" class="fixed inset-0 z-50 hidden bg-gray-900/60 backdrop-blur-sm flex items-center justify-center transition-opacity">
        <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6 transform scale-100 transition-transform relative">
            
            <button onclick="closeRejectModal()" class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition">
                <i class="fa-solid fa-xmark text-xl"></i>
            </button>

            <div class="flex items-start gap-4 mb-5 mt-2">
                <div class="w-12 h-12 rounded-full bg-red-100 text-red-600 flex items-center justify-center text-2xl shrink-0 shadow-inner">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-gray-900">Từ chối đơn vé?</h3>
                    <p class="text-sm text-gray-500 mt-1 leading-relaxed">
                        Bạn có chắc chắn muốn từ chối mã đặt chỗ <span id="modalBookingIdDisplay" class="font-black text-red-600 text-base"></span> không?
                    </p>
                </div>
            </div>
            
            <div class="bg-orange-50 border border-orange-200 rounded-xl p-3.5 mb-6 text-sm text-orange-800 flex gap-2 items-start">
                <i class="fa-solid fa-circle-info mt-0.5"></i> 
                <p>Hành động này không thể hoàn tác. Số ghế của chuyến bay sẽ tự động được <strong>hoàn lại +1</strong> vào hệ thống.</p>
            </div>

            <form action="adminBookings" method="POST" class="flex gap-3 justify-end m-0">
                <input type="hidden" name="search" value="${searchQuery}">
                <input type="hidden" name="status" value="${statusFilter}">
                <input type="hidden" name="bookingId" id="modalBookingIdInput">
                <input type="hidden" name="action" value="reject">
                <input type="hidden" name="page" id="modalPageInput">
                
                <button type="button" onclick="closeRejectModal()" class="px-5 py-2.5 rounded-xl font-bold text-gray-700 bg-gray-100 hover:bg-gray-200 transition">
                    Hủy bỏ
                </button>
                <button type="submit" class="px-5 py-2.5 rounded-xl font-bold text-white bg-red-600 hover:bg-red-700 transition shadow-lg shadow-red-200 flex items-center gap-2">
                    <i class="fa-solid fa-trash-can"></i> Xác nhận Từ chối
                </button>
            </form>
        </div>
    </div>

    <script>
        function openRejectModal(bookingId, page) {
            // Đẩy dữ liệu vào Modal
            document.getElementById('modalBookingIdDisplay').innerText = bookingId;
            document.getElementById('modalBookingIdInput').value = bookingId;
            document.getElementById('modalPageInput').value = page;
            
            // Hiển thị Modal
            const modal = document.getElementById('rejectModal');
            modal.classList.remove('hidden');
        }

        function closeRejectModal() {
            // Ẩn Modal
            document.getElementById('rejectModal').classList.add('hidden');
        }
    </script>
</body>
</html>
</body>
</html>