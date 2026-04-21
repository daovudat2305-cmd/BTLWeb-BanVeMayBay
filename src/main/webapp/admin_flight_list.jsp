<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách chuyến bay - Admin</title>
    <link rel="icon" type="image/svg+xml" href="./assets/logo.svg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script defer src="./js/toast-message.js"></script>
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
            <a href="adminBookings" class="flex items-center gap-3 py-3 px-4 rounded-xl hover:bg-blue-700 transition text-blue-100 hover:text-white font-medium">
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
                    <div class="text-blue-300 font-bold text-xs uppercase tracking-widest mb-2">Dữ liệu chuyến bay</div>
                    <h2 class="text-3xl font-bold">Danh sách chuyến bay</h2>
                </div>
                <a href="admin_add_flight.jsp" class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-3 px-6 rounded-xl transition shadow-lg flex items-center gap-2">
                    <i class="fa-solid fa-plus"></i> THÊM MỚI
                </a>
            </div>
        </div>

        <div class="px-8 -mt-6 space-y-4 pb-12">
			<div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5 mb-6">
                <form action="adminFlights" method="GET" class="flex flex-col md:flex-row flex-wrap gap-4 items-end m-0">
                    <div class="flex-1 min-w-[150px]">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Hãng bay</label>
                        <select name="airline" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50 cursor-pointer">
                            <option value="ALL" ${selectedAirline == 'ALL' ? 'selected' : ''}>Tất cả hãng</option>
                            <option value="Vietjet Air" ${selectedAirline == 'Vietjet Air' ? 'selected' : ''}>Vietjet Air</option>
                            <option value="Vietnam Airlines" ${selectedAirline == 'Vietnam Airlines' ? 'selected' : ''}>Vietnam Airlines</option>
                            <option value="Bamboo Airways" ${selectedAirline == 'Bamboo Airways' ? 'selected' : ''}>Bamboo Airways</option>
                            <option value="Vietravel Airlines" ${selectedAirline == 'Vietravel Airlines' ? 'selected' : ''}>Vietravel Airlines</option>
                            <option value="Pacific Airlines" ${selectedAirline == 'Pacific Airlines' ? 'selected' : ''}>Pacific Airlines</option>
                        </select>
                    </div>
                    <div class="w-full md:w-32">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Điểm đi</label>
                        <input type="text" name="dep" value="${selectedDep == 'ALL' ? '' : selectedDep}" placeholder="Mã VD: HAN" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50 uppercase">
                    </div>
                    <div class="w-full md:w-32">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Điểm đến</label>
                        <input type="text" name="dest" value="${selectedDest == 'ALL' ? '' : selectedDest}" placeholder="Mã VD: SGN" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50 uppercase">
                    </div>
                    <div class="w-full md:w-40">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Ngày bay</label>
                        <input type="date" name="date" value="${selectedDate}" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50">
                    </div>
                    <div class="w-full md:w-32">
                        <label class="block text-[11px] font-bold text-gray-500 uppercase tracking-widest mb-1.5 ml-1">Từ Giờ</label>
                        <input type="time" name="time" value="${selectedTime}" class="w-full px-4 py-2.5 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none text-sm font-bold text-gray-700 bg-gray-50">
                    </div>
                    <div class="w-full md:w-auto flex gap-2 mt-2 md:mt-0">
                        <a href="adminFlights" class="px-5 py-2.5 rounded-xl font-bold text-gray-600 bg-gray-100 hover:bg-gray-200 transition text-sm flex items-center justify-center">Xóa</a>
                        <button type="submit" class="px-6 py-2.5 rounded-xl font-bold text-white bg-blue-600 hover:bg-blue-700 transition shadow-md shadow-blue-200 text-sm flex items-center justify-center gap-2">
                            <i class="fa-solid fa-filter"></i> Lọc
                        </button>
                    </div>
                </form>
            </div>
			
            <c:forEach var="f" items="${flightList}">
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition">
                    <div class="flex flex-col md:flex-row justify-between items-center gap-6">
                        
                        <div class="w-full md:w-1/5">
                            <span class="inline-block bg-yellow-100 text-yellow-800 text-[10px] font-black px-2 py-0.5 rounded uppercase mb-1">${f.airlineName}</span>
                            <div class="text-lg font-bold text-gray-800">${f.flightId}</div>
                            <div class="text-xs text-gray-400 font-bold uppercase tracking-tighter">Ghế trống: ${f.availableSeats}</div>
                        </div>

                        <div class="flex-1 flex justify-between items-center px-4">
                            <div class="text-center">
                                <div class="text-2xl font-bold text-gray-900">
                                    <fmt:formatDate pattern="HH:mm" value="${f.departureTime}" />
                                </div>
                                <div class="text-xs font-bold text-gray-400 uppercase">${f.departureAirport}</div>
                            </div>
                            <div class="flex flex-col items-center flex-1 px-8">
                                <span class="text-[10px] text-gray-400 font-bold mb-1">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${f.departureTime}" />
                                </span>
                                <div class="w-full border-t-2 border-dashed border-gray-200 relative">
                                    <i class="fa-solid fa-plane text-blue-800 absolute top-[-9px] right-0 bg-white px-1 text-sm"></i>
                                </div>
                                <span class="text-[10px] text-green-600 font-bold uppercase mt-1">Bay thẳng</span>
                            </div>
                            
                            <div class="text-center">
                                <div class="text-2xl font-bold text-gray-900">
                                    <fmt:formatDate pattern="HH:mm" value="${f.arrivalTime}" />
                                </div>
                                <div class="text-xs font-bold text-gray-400 uppercase">${f.destinationAirport}</div>
                            </div>
                        </div>

                        <div class="w-full md:w-1/4 flex flex-col items-end border-l pl-6 border-gray-100">
                            <div class="text-2xl font-black text-orange-600 mb-3 tracking-tighter">
                                <fmt:formatNumber value="${f.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                            </div>
                            <div class="flex gap-2 w-full">
                                <a href="EditFlightServlet?id=${f.flightId}" class="flex-1 bg-blue-50 text-blue-600 text-center font-bold py-2 rounded-lg hover:bg-blue-100 transition text-sm">Sửa</a>
                               <button type="button" onclick="openDeleteModal('DeleteFlightServlet?id=${f.flightId}')" class="flex-1 bg-red-50 text-red-600 text-center font-bold py-2 rounded-lg hover:bg-red-100 transition text-sm">Xóa</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
			
			<c:if test="${empty flightList}">
                <div class="text-center text-gray-500 py-10 font-bold">
                    Chưa có chuyến bay nào trong hệ thống.
                </div>
            </c:if>

            <c:if test="${totalPages > 1}">
                <c:set var="startPage" value="${currentPage - 2}" />
                <c:set var="endPage" value="${currentPage + 2}" />

                <c:if test="${startPage < 1}">
                    <c:set var="startPage" value="1" />
                    <c:set var="endPage" value="5" />
                </c:if>

                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}" />
                    <c:set var="startPage" value="${totalPages - 4}" />
                    <c:if test="${startPage < 1}">
                        <c:set var="startPage" value="1" />
                    </c:if>
                </c:if>

                <div class="flex justify-center items-center gap-2 mt-8">
                    
                    <c:if test="${currentPage > 1}">
                        <a href="adminFlights?page=${currentPage - 1}&airline=${selectedAirline}&date=${selectedDate}&time=${selectedTime}&dep=${selectedDep}&dest=${selectedDest}">
                            <i class="fa-solid fa-chevron-left text-xs"></i>
                        </a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <c:choose>
                            <c:when test="${currentPage == i}">
                                <span class="px-4 py-2 rounded-lg bg-blue-700 text-white font-black shadow-md">
                                    ${i}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <a href="adminFlights?page=${i}&airline=${selectedAirline}&date=${selectedDate}&time=${selectedTime}&dep=${selectedDep}&dest=${selectedDest}">
                                    ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="adminFlights?page=${currentPage + 1}&airline=${selectedAirline}&date=${selectedDate}&time=${selectedTime}&dep=${selectedDep}&dest=${selectedDest}">
                            <i class="fa-solid fa-chevron-right text-xs"></i>
                        </a>
                    </c:if>
                    
                </div>
            </c:if>
        </div>
    </main>
    
    <!-- toast message -->
    <div id="toast-container" class="fixed z-50 space-y-3 top-5 right-5"></div>
    
    <script>
    	// toast message thông báo
	    window.addEventListener('DOMContentLoaded', (event) => {
	        const msg = "${param.msg}"; 
	        
	        if (msg === "success") {
	            showToast("Thêm chuyến bay thành công!", "success");
	        } else if (msg === "error") {
	            showToast("Thêm thất bại. Vui lòng thử lại!", "error");
	        } else if (msg === "exception") {
	            showToast("Lỗi nhập liệu! Vui lòng kiểm tra lại định dạng số và ngày giờ.", "error");
	        }
	
	        const serverError = "${error}";
	        if (serverError && serverError.trim() !== "") {
	            showToast(serverError, "error");
	        }
	    });
            // Hàm mở Modal xóa
            function openDeleteModal(url) {
                const modal = document.getElementById('deleteModal');
                const link = document.getElementById('confirmDeleteLink');
                link.href = url; // Gán đường dẫn xóa vào nút xác nhận
                modal.classList.remove('hidden');
                document.body.style.overflow = 'hidden'; // Chặn cuộn trang
            }

            // Hàm đóng Modal
            function closeDeleteModal() {
                const modal = document.getElementById('deleteModal');
                modal.classList.add('hidden');
                document.body.style.overflow = 'auto'; // Cho phép cuộn lại
            }

            // Đóng khi click ra ngoài vùng trắng
            window.addEventListener('click', function(e) {
                const modal = document.getElementById('deleteModal');
                if (e.target === modal) closeDeleteModal();
            });
    </script>
        <div id="deleteModal" class="fixed inset-0 z-[60] hidden overflow-y-auto">
         <div class="fixed inset-0 bg-black/50 backdrop-blur-sm transition-opacity"></div>
         <div class="relative flex items-center justify-center min-h-screen p-4">
             <div class="relative bg-white rounded-3xl shadow-2xl max-w-sm w-full p-8 transform transition-all border border-gray-100">
                 <div class="mx-auto flex items-center justify-center h-20 w-20 rounded-full bg-red-50 mb-6">
                     <i class="fa-solid fa-triangle-exclamation text-red-500 text-3xl"></i>
                 </div>
                 <div class="text-center">
                     <h3 class="text-2xl font-black text-gray-900 mb-3">Xác nhận xóa?</h3>
                     <p class="text-gray-500 leading-relaxed">
                         Dữ liệu về chuyến bay này sẽ bị xóa vĩnh viễn khỏi hệ thống. Bạn có chắc chắn không?
                     </p>
                 </div>
                 <div class="mt-8 flex gap-3">
                     <button onclick="closeDeleteModal()" class="flex-1 px-4 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold rounded-2xl transition-all">
                         Quay lại
                     </button>
                     <a id="confirmDeleteLink" href="#" class="flex-1 px-4 py-3 bg-red-600 hover:bg-red-700 text-white text-center font-bold rounded-2xl transition-all shadow-lg shadow-red-200">
                         Đồng ý xóa
                     </a>
                 </div>
             </div>
         </div>
     </div> 
</body>
</html> 