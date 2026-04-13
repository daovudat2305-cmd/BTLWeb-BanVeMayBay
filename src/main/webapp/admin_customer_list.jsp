<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <a href="admin_dashboard.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-chart-pie w-5"></i> Tổng quan
            </a>
            <a href="adminFlights" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                <i class="fa-solid fa-plane w-5"></i> Quản lý chuyến bay
            </a>
            <a href="admin_customer_list.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
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
                    <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Hành khách & Giao dịch</div>
                    <h2 class="text-3xl font-bold">Danh sách đặt vé</h2>
                </div>
                <div class="flex gap-3">
                    <button class="bg-white/10 hover:bg-white/20 text-white font-bold py-2 px-4 rounded-lg transition text-sm border border-white/20">
                        <i class="fa-solid fa-download mr-2"></i> Xuất Excel
                    </button>
                </div>
            </div>
        </div>

        <div class="px-8 -mt-6 pb-12">
            <div class="bg-white p-4 rounded-t-2xl border border-gray-100 shadow-sm flex flex-wrap gap-4 items-center justify-between">
                <div class="relative w-full md:w-96">
                    <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" placeholder="Tìm theo mã PNR, Tên hoặc CCCD..." class="w-full pl-10 pr-4 py-2 border rounded-xl outline-none focus:ring-2 focus:ring-blue-500 transition">
                </div>
                <div class="flex gap-2">
                    <select class="border rounded-xl px-4 py-2 text-sm font-medium outline-none">
                        <option>Tất cả trạng thái</option>
                        <option>Thành công</option>
                        <option>Chờ thanh toán</option>
                    </select>
                </div>
            </div>

            <div class="bg-white rounded-b-2xl shadow-sm border border-t-0 border-gray-100 overflow-hidden">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50 text-gray-500 text-[10px] font-black uppercase tracking-widest border-b">
                            <th class="px-6 py-4">Mã đặt chỗ (PNR)</th>
                            <th class="px-6 py-4">Hành khách</th>
                            <th class="px-6 py-4">Chuyến bay</th>
                            <th class="px-6 py-4">Ngày đặt</th>
                            <th class="px-6 py-4 text-right">Tổng tiền</th>
                            <th class="px-6 py-4 text-center">Trạng thái</th>
                            <th class="px-6 py-4 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-50">
                        <tr class="hover:bg-blue-50/50 transition">
                            <td class="px-6 py-4">
                                <span class="font-black text-blue-800 tracking-wider">VK98A2</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="font-bold text-gray-800 text-sm">NGUYEN VAN A</div>
                                <div class="text-[10px] text-gray-400">CCCD: 012345678901</div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-xs font-bold text-gray-700">VJ-101</div>
                                <div class="text-[10px] text-gray-400 uppercase tracking-tighter">HAN <i class="fa-solid fa-arrow-right mx-1"></i> DAD</div>
                            </td>
                            <td class="px-6 py-4 text-xs text-gray-500">
                                20/11/2026 14:20
                            </td>
                            <td class="px-6 py-4 text-right font-black text-orange-600">
                                1.200.000 đ
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="bg-green-100 text-green-700 text-[10px] font-black px-2 py-1 rounded-full uppercase">Thành công</span>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button class="text-blue-600 hover:text-blue-800 transition" title="Xem chi tiết">
                                    <i class="fa-solid fa-circle-info text-lg"></i>
                                </button>
                            </td>
                        </tr>

                        <tr class="hover:bg-blue-50/50 transition">
                            <td class="px-6 py-4">
                                <span class="font-black text-blue-800 tracking-wider">VN22C9</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="font-bold text-gray-800 text-sm">TRAN THI B</div>
                                <div class="text-[10px] text-gray-400">CCCD: 098765432101</div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-xs font-bold text-gray-700">VN-223</div>
                                <div class="text-[10px] text-gray-400 uppercase tracking-tighter">HAN <i class="fa-solid fa-arrow-right mx-1"></i> SGN</div>
                            </td>
                            <td class="px-6 py-4 text-xs text-gray-500">
                                21/11/2026 09:15
                            </td>
                            <td class="px-6 py-4 text-right font-black text-orange-600">
                                2.550.000 đ
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="bg-orange-100 text-orange-700 text-[10px] font-black px-2 py-1 rounded-full uppercase">Chờ xử lý</span>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button class="text-blue-600 hover:text-blue-800 transition">
                                    <i class="fa-solid fa-circle-info text-lg"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="p-4 bg-gray-50 border-t flex justify-between items-center text-xs text-gray-500 font-bold">
                    <div>Hiển thị 1 - 10 trên 1,280 kết quả</div>
                    <div class="flex gap-1">
                        <button class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition"><i class="fa-solid fa-chevron-left"></i></button>
                        <button class="w-8 h-8 flex items-center justify-center rounded bg-[#1e3a8a] text-white">1</button>
                        <button class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition">2</button>
                        <button class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition">3</button>
                        <button class="w-8 h-8 flex items-center justify-center rounded bg-white border border-gray-200 hover:bg-gray-100 transition"><i class="fa-solid fa-chevron-right"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>