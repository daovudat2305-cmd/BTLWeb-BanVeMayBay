<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa chuyến bay - Admin</title>
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
            <a href="adminFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
                <i class="fa-solid fa-plane w-5"></i> Quản lý chuyến bay
            </a>
            <a href="adminCompletedFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-file-invoice-dollar w-5"></i> Chuyến bay hoàn thành
            </a>
            <a href="adminBookings" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-users w-5"></i> Danh sách đặt vé
            </a>
            <a href="logout" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>
        <div class="p-6 border-t border-blue-700">
            <a href="home" class="flex items-center gap-3 py-2 px-4 text-blue-300 hover:text-white transition font-medium"> Về trang chủ </a>
        </div>
    </aside>

    <main class="flex-1 flex flex-col overflow-x-hidden">
        <div class="bg-[#1e3a8a] text-white pt-8 pb-12 px-8">
            <div class="flex justify-between items-end">
                <div>
                    <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Hệ thống quản trị</div>
                    <h2 class="text-3xl font-bold flex items-center gap-3">
                        Sửa chuyến bay <span class="text-yellow-400">#${f.flightId}</span>
                    </h2>
                </div>
                <a href="adminFlights" class="bg-white/10 hover:bg-white/20 text-white font-bold py-3 px-6 rounded-xl transition border border-white/20 flex items-center gap-2 text-sm">
                    <i class="fa-solid fa-arrow-left"></i> QUAY LẠI
                </a>
            </div>
        </div>

        <div class="px-8 -mt-6 pb-12">
            <form action="EditFlightServlet" method="POST" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <input type="hidden" name="flightId" value="${f.flightId}">
                
                <div class="p-8 space-y-8">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Hãng hàng không</label>
                            <select disabled name="airline" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition bg-gray-50 text-gray-800">
                                <option value="Vietjet Air" ${f.airlineName == 'Vietjet Air' ? 'selected' : ''}>Vietjet Air</option>
                                <option value="Vietnam Airlines" ${f.airlineName == 'Vietnam Airlines' ? 'selected' : ''}>Vietnam Airlines</option>
                                <option value="Bamboo Airways" ${f.airlineName == 'Bamboo Airways' ? 'selected' : ''}>Bamboo Airways</option>
                                <option value="Vietravel Airlines" ${f.airlineName == 'Vietravel Airlines' ? 'selected' : ''}>Vietravel Airlines</option>
                                <option value="Pacific Airlines" ${f.airlineName == 'Pacific Airlines' ? 'selected' : ''}>Pacific Airlines</option>
                            </select>
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Số hiệu chuyến bay</label>
                            <input type="text" disabled name="flightNumber" value="${f.flightId}" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                    </div>

                    <div class="space-y-4">
                        <h3 class="text-blue-800 font-bold text-xs uppercase tracking-widest flex items-center gap-2">
                            <i class="fa-solid fa-location-dot"></i> Chi tiết lộ trình
                        </h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-blue-50/50 p-5 rounded-2xl border border-blue-100 shadow-sm">
                            <div class="md:col-span-3 space-y-1">
                                <label class="text-[11px] font-bold text-black uppercase ml-1">Tên sân bay đi</label>
                                <input type="text" disabled name="depName" value="${ad.airportName}" class="w-full px-4 py-2.5 rounded-lg border border-blue-200 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                            </div>
                            <div class="md:col-span-1 space-y-1">
                                <label class="text-[11px] font-bold text-black uppercase">Mã sân bay</label>
                                <input type="text" disabled name="depCode" value="${f.departureAirport}" class="w-full px-4 py-2.5 rounded-lg border border-blue-200 focus:ring-2 focus:ring-blue-500 outline-none font-bold text-center uppercase text-blue-800 transition">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-orange-50/50 p-5 rounded-2xl border border-orange-100 shadow-sm">
                            <div class="md:col-span-3 space-y-1">
                                <label class="text-[11px] font-bold text-black uppercase ml-1">Tên sân bay đến</label>
                                <input type="text" disabled name="destName" value="${ade.airportName}" class="w-full px-4 py-2.5 rounded-lg border border-orange-200 focus:ring-2 focus:ring-orange-500 outline-none font-bold transition text-gray-800">
                            </div>
                            <div class="md:col-span-1 space-y-1">
                                <label class="text-[11px] font-bold text-black uppercase">Mã sân bay</label>
                                <input type="text" disabled name="destCode" value="${f.destinationAirport}" class="w-full px-4 py-2.5 rounded-lg border border-orange-200 focus:ring-2 focus:ring-orange-500 outline-none font-bold text-center uppercase text-orange-600 transition">
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Ngày & Giờ đi</label>
                            <input type="datetime-local" name="departureTime" value="${f.departureTime}" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Giá vé (VNĐ)</label>
                            <input type="number" name="price" value="${f.price}" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold text-orange-600 transition">
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Tổng số ghế</label>
                            <input type="number" name="totalSeats" value="${f.availableSeats}" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-8 py-6 flex justify-end gap-4 border-t">
                    <button type="reset" class="px-6 py-3 rounded-xl text-gray-500 font-bold hover:bg-gray-200 transition uppercase text-xs">
                        Khôi phục gốc
                    </button>
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-10 rounded-xl transition shadow-lg shadow-blue-200 uppercase text-sm tracking-widest">
                        Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>