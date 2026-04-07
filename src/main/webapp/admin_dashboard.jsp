<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bảng điều khiển - Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-50 font-sans flex min-h-screen">

        <aside class="w-64 bg-[#1e3a8a] text-white flex flex-col sticky top-0 h-screen shrink-0">
            <div class="p-6 text-xl font-black border-b border-blue-700 flex items-center gap-2">
                <i class="fa-solid fa-plane-departure"></i> Vé Máy Bay
            </div>  
            <nav class="flex-grow p-4 space-y-2 mt-4">
                <a href="admin_dashboard.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl bg-blue-700 font-bold shadow-lg shadow-blue-900/20">
                    <i class="fa-solid fa-chart-pie w-5"></i> Tổng quan
                </a>
                <a href="admin_flight_list.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                    <i class="fa-solid fa-plane w-5"></i> Quản lý chuyến bay
                </a>
                <a href="admin_customer_list.jsp" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
                    <i class="fa-solid fa-users w-5"></i> Danh sách đặt vé
                </a>
            </nav>
            <div class="p-6 border-t border-blue-700">
                <a href="index.jsp" class="flex items-center gap-3 py-2 px-4 text-blue-300 hover:text-white transition font-medium"> Về trang chủ </a>
            </div>
        </aside>

        <main class="flex-1 flex flex-col overflow-x-hidden">
            <div class="bg-[#1e3a8a] text-white pt-8 pb-12 px-8">
                <div class="flex justify-between items-end">
                    <div>
                        <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Hệ thống quản trị</div>
                        <h2 class="text-3xl font-bold">Bảng điều khiển tổng quan</h2>
                    </div>
                </div>
            </div>

            <div class="px-8 -mt-6 space-y-6 pb-12">

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-6 hover:shadow-md transition">
                        <div class="w-14 h-14 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center text-2xl">
                            <i class="fa-solid fa-ticket"></i>
                        </div>
                        <div>
                            <div class="text-black text-[11px] font-bold uppercase tracking-widest">Vé đã bán</div>
                            <div class="text-3xl font-bold text-gray-800">452</div>
                            <div class="text-green-500 text-xs font-bold mt-1"><i class="fa-solid fa-arrow-up"></i> +5.2%</div>
                        </div>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-6 hover:shadow-md transition">
                        <div class="w-14 h-14 bg-orange-50 text-orange-600 rounded-2xl flex items-center justify-center text-2xl">
                            <i class="fa-solid fa-sack-dollar"></i>
                        </div>
                        
                        <div>
                            <div class="text-black text-[11px] font-bold uppercase tracking-widest">Doanh thu (VNĐ)</div>
                            <div class="text-3xl font-bold text-gray-800">340.5M</div>
                            <div class="text-gray-400 text-xs font-bold mt-1 uppercase italic">Tháng này</div>
                        </div>
                    </div>

                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-6 hover:shadow-md transition">
                        <div class="w-14 h-14 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center text-2xl">
                            <i class="fa-solid fa-plane-up"></i>
                        </div>
                        <div>
                            <div class="text-black text-[11px] font-bold uppercase tracking-widest">Chuyến bay hoạt động</div>
                            <div class="text-3xl font-bold text-gray-800">18</div>
                            <div class="text-blue-500 text-xs font-bold mt-1 italic uppercase">Đang vận hành</div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-3xl p-1 border border-gray-100 shadow-sm overflow-hidden">
                    <div class="bg-[#1e3a8a] rounded-[1.4rem] p-8 text-white flex flex-col md:flex-row justify-between items-center gap-6">
                        <div class="flex items-center gap-6">
                            <div class="hidden lg:flex w-20 h-20 bg-white/10 rounded-full items-center justify-center text-4xl border border-white/10">
                                <i class="fa-solid fa-rocket"></i>
                            </div>
                            <div>
                                <h3 class="text-2xl font-bold mb-1 italic">Quản lý chuyến bay ngay bây giờ?</h3>
                                <p class="text-blue-200 text-sm font-medium">Thêm mới lịch trình hoặc cập nhật giá vé cho các chuyến bay sắp tới để tối ưu doanh thu.</p>
                            </div>
                        </div>
                        <a href="admin_add_flight.jsp" class="w-full md:w-auto bg-orange-500 hover:bg-orange-600 text-white font-bold py-4 px-10 rounded-2xl transition shadow-xl shadow-orange-900/20 uppercase tracking-widest text-sm flex items-center justify-center gap-2 group">
                            <span>Thêm chuyến bay</span>
                            <i class="fa-solid fa-plus group-hover:rotate-90 transition"></i>
                        </a>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                        <h4 class="font-bold text-gray-800 uppercase text-xs tracking-widest mb-4 flex items-center gap-2">
                            <span class="w-2 h-2 bg-blue-600 rounded-full"></span> Trạng thái hệ thống
                        </h4>
                        <div class="space-y-4">
                            <div class="flex justify-between items-center p-3 bg-gray-50 rounded-xl">
                                <span class="text-sm font-bold text-gray-600">Máy chủ dữ liệu</span>
                                <span class="text-[10px] px-2 py-1 bg-green-100 text-green-700 rounded-lg font-bold uppercase">Hoạt động tốt</span>
                            </div>
                            <div class="flex justify-between items-center p-3 bg-gray-50 rounded-xl">
                                <span class="text-sm font-bold text-gray-600">Cổng thanh toán</span>
                                <span class="text-[10px] px-2 py-1 bg-green-100 text-green-700 rounded-lg font-bold uppercase">Trực tuyến</span>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm flex items-center justify-center border-dashed border-2">
                        <div class="text-center">
                            <i class="fa-solid fa-chart-line text-gray-200 text-4xl mb-2"></i>
                            <p class="text-gray-400 font-bold text-xs uppercase italic">Biểu đồ đang được cập nhật...</p>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </body>
</html>