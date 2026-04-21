<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuyến bay hoàn thành - Admin</title>
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
            <a href="adminCompletedFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
                <i class="fa-solid fa-file-invoice-dollar w-5"></i> Chuyến bay hoàn thành
            </a>
            <a href="adminBookings" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-users w-5"></i> Danh sách đặt vé
            </a>
            <a href="logout" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>
    </aside>

    <main class="flex-1 flex flex-col overflow-x-hidden">
        <div class="bg-[#1e3a8a] text-white pt-8 pb-12 px-8">
            <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Báo cáo & Thống kê</div>
            <h2 class="text-3xl font-bold">Danh sách chuyến bay hoàn thành</h2>
        </div>

        <div class="px-8 -mt-6 pb-12 space-y-6">
            
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
                <form action="adminCompletedFlights" method="GET" class="flex flex-wrap gap-4 items-end m-0">
                    <div class="flex-1 min-w-[200px]">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Lọc theo Hãng bay</label>
                        <select name="airline" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50">
                            <option value="ALL" ${selectedAirline == 'ALL' ? 'selected' : ''}>Tất cả hãng hàng không</option>
                            <option value="Vietjet Air" ${selectedAirline == 'Vietjet Air' ? 'selected' : ''}>Vietjet Air</option>
                            <option value="Vietnam Airlines" ${selectedAirline == 'Vietnam Airlines' ? 'selected' : ''}>Vietnam Airlines</option>
                            <option value="Bamboo Airways" ${selectedAirline == 'Bamboo Airways' ? 'selected' : ''}>Bamboo Airways</option>
                        </select>
                    </div>
                    <button type="submit" class="px-6 py-2.5 rounded-xl font-bold text-white bg-blue-600 hover:bg-blue-700 transition text-sm flex items-center gap-2">
                        <i class="fa-solid fa-filter"></i> Lọc dữ liệu
                    </button>
                </form>
            </div>

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <table class="w-full text-left border-collapse whitespace-nowrap">
                    <thead>
                        <tr class="bg-gray-50 text-gray-500 text-[10px] font-black uppercase tracking-widest border-b border-gray-200">
                            <th class="px-6 py-4">Chuyến bay</th>
                            <th class="px-6 py-4">Lộ trình</th>
                            <th class="px-6 py-4">Ngày hạ cánh</th>
                            <th class="px-6 py-4 text-center">Vé đã bán</th>
                            <th class="px-6 py-4 text-right text-blue-600">Tổng doanh thu</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-50">
                        <c:forEach var="item" items="${flightList}">
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-6 py-4">
                                    <div class="font-black text-gray-900 text-lg">${item.flight.flightId}</div>
                                    <div class="text-[10px] text-gray-500 uppercase bg-gray-100 inline-block px-2 py-0.5 rounded mt-1">${item.flight.airlineName}</div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="text-xs font-bold text-gray-700 uppercase">${item.flight.departureAirport} <i class="fa-solid fa-arrow-right mx-1 text-gray-400"></i> ${item.flight.destinationAirport}</div>
                                </td>
                                <td class="px-6 py-4 text-xs text-gray-500 font-medium">
                                    <fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${item.flight.arrivalTime}" />
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span class="bg-green-100 text-green-700 font-black px-3 py-1 rounded-full text-sm">
                                        ${item.ticketsSold}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <div class="text-lg font-black text-blue-700">
                                        <fmt:formatNumber value="${item.totalRevenue}" type="number" pattern="###,###"/> đ
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
				
				<c:if test="${empty flightList}">
	                <div class="text-center text-gray-500 py-10 font-bold">
	                    Chưa có chuyến bay nào hoàn thành.
	                </div>
	            </c:if>

                <c:if test="${totalPages > 1}">
                    <div class="p-4 bg-gray-50 border-t flex justify-center items-center gap-2">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="adminCompletedFlights?page=${i}&airline=${selectedAirline}" 
                               class="w-8 h-8 flex items-center justify-center rounded transition shadow-sm ${currentPage == i ? 'bg-blue-600 text-white font-bold' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-100'}">
                                ${i}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</body>
</html>