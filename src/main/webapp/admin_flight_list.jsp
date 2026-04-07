<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách chuyến bay - Admin</title>
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
            <a href="admin_dashboard.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-chart-pie w-5"></i> Tổng quan
            </a>
            <a href="admin_flight_list.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
                <i class="fa-solid fa-plane w-5"></i> Quản lý chuyến bay
            </a>
            <a href="admin_customer_list.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-users w-5"></i> Danh sách đặt vé
            </a>
            <a href="logout" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>
        <div class="p-6 border-t border-blue-700">
            <a href="index.jsp" class="flex items-center gap-3 py-2 px-4 text-blue-300 hover:text-white transition"> Về trang chủ </a>
        </div>
    </aside>

    <main class="flex-1 flex flex-col overflow-x-hidden">
        <div class="bg-[#1e3a8a] text-white pt-8 pb-12 px-8">
            <div class="flex justify-between items-end">
                <div>
                    <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Dữ liệu chuyến bay</div>
                    <h2 class="text-3xl font-bold">Danh sách chuyến bay</h2>
                </div>
                <a href="admin_add_flight.jsp" class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-3 px-6 rounded-xl transition shadow-lg flex items-center gap-2">
                    <i class="fa-solid fa-plus"></i> THÊM MỚI
                </a>
            </div>
        </div>

        <div class="px-8 -mt-6 space-y-4 pb-12">

            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition">
                <div class="flex flex-col md:flex-row justify-between items-center gap-6">
                    <div class="w-full md:w-1/5">
                        <span class="inline-block bg-yellow-100 text-yellow-800 text-[10px] font-black px-2 py-0.5 rounded uppercase mb-1">Vietjet Air</span>
                        <div class="text-lg font-bold text-gray-800">VJ-101</div>
                        <div class="text-xs text-gray-400 font-bold uppercase tracking-tighter">Airbus A320</div>
                    </div>

                    <div class="flex-1 flex justify-between items-center px-4">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-gray-900">08:30</div>
                            <div class="text-xs font-bold text-gray-400 uppercase">HAN</div>
                        </div>
                        <div class="flex flex-col items-center flex-1 px-8">
                            <span class="text-[10px] text-gray-400 font-bold mb-1">1h 30m</span>
                            <div class="w-full border-t-2 border-dashed border-gray-200 relative">
                                <i class="fa-solid fa-plane text-blue-800 absolute top-[-9px] right-0 bg-white px-1 text-sm"></i>
                            </div>
                            <span class="text-[10px] text-green-600 font-bold uppercase mt-1">Bay thẳng</span>
                        </div>
                        <div class="text-center">
                            <div class="text-2xl font-bold text-gray-900">10:00</div>
                            <div class="text-xs font-bold text-gray-400 uppercase">DAD</div>
                        </div>
                    </div>

                    <div class="w-full md:w-1/4 flex flex-col items-end border-l pl-6 border-gray-100">
                        <div class="text-2xl font-black text-orange-600 mb-3 tracking-tighter">1.200.000 đ</div>
                        <div class="flex gap-2 w-full">
                            <a href="admin_edit_flight.jsp" class="flex-1 bg-blue-50 text-blue-600 text-center font-bold py-2 rounded-lg hover:bg-blue-100 transition text-sm">Sửa</a>
                            <button class="flex-1 bg-red-50 text-red-600 text-center font-bold py-2 rounded-lg hover:bg-red-100 transition text-sm">Xóa</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>
</body>
</html>