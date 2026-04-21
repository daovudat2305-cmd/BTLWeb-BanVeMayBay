<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm chuyến bay mới - Admin</title>
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
                    <h2 class="text-3xl font-bold">Thêm chuyến bay mới</h2>
                </div>
                <a href="adminFlights" class="bg-white/10 hover:bg-white/20 text-white font-bold py-3 px-6 rounded-xl transition border border-white/20 flex items-center gap-2 text-sm">
                    <i class="fa-solid fa-arrow-left"></i> QUAY LẠI
                </a>
            </div>
        </div>

        <div class="px-8 -mt-6 pb-12">
            <form action="addFlight" method="POST" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                
                <div class="p-8 space-y-8">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Hãng hàng không</label>
                            <select name="airline" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition bg-gray-50 text-gray-800">
                                <option>Vietjet Air</option>
                                <option>Vietnam Airlines</option>
                                <option>Bamboo Airways</option>
                                <option>Vietravel Airlines</option>
                                <option>Pacific Airlines</option>
                            </select>
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Số hiệu chuyến bay</label>
                            <input type="text" disabled name="flightNumber" placeholder="VJ-101" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                    </div>

                    <div class="space-y-4">
					    <h3 class="text-blue-800 font-bold text-xs uppercase tracking-widest flex items-center gap-2">
					        <i class="fa-solid fa-location-dot"></i> Chi tiết lộ trình
					    </h3>
					    
					    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-blue-50/50 p-5 rounded-2xl border border-blue-100 shadow-sm">
					        <div class="md:col-span-3 space-y-1">
					            <label class="text-[11px] font-bold text-black uppercase ml-1">Tên sân bay đi</label>
					            <select name="depName" id="depNameSelect" onchange="updateAirportCode('depNameSelect', 'depCodeInput')" class="w-full px-4 py-2.5 rounded-lg border border-blue-200 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800 bg-white cursor-pointer">
					                <option value="" disabled selected>-- Chọn sân bay đi --</option>
					                <optgroup label="Miền Bắc">
					                    <option value="Sân bay quốc tế Nội Bài" data-code="HAN">Sân bay quốc tế Nội Bài</option>
					                    <option value="Sân bay quốc tế Cát Bi" data-code="HPH">Sân bay quốc tế Cát Bi</option>
					                    <option value="Sân bay quốc tế Vân Đồn" data-code="VDO">Sân bay quốc tế Vân Đồn</option>
					                    <option value="Sân bay Điện Biên" data-code="DIN">Sân bay Điện Biên</option>
					                    <option value="Sân bay Thọ Xuân" data-code="THD">Sân bay Thọ Xuân</option>
					                </optgroup>
					                <optgroup label="Miền Trung">
					                    <option value="Sân bay quốc tế Đà Nẵng" data-code="DAD">Sân bay quốc tế Đà Nẵng</option>
					                    <option value="Sân bay Phú Bài" data-code="HUI">Sân bay Phú Bài</option>
					                    <option value="Sân bay Chu Lai" data-code="VCL">Sân bay Chu Lai</option>
					                    <option value="Sân bay Phù Cát" data-code="UIH">Sân bay Phù Cát</option>
					                    <option value="Sân bay Tuy Hòa" data-code="TBB">Sân bay Tuy Hòa</option>
					                    <option value="Sân bay Cam Ranh" data-code="CXR">Sân bay Cam Ranh</option>
					                    <option value="Sân bay Liên Khương" data-code="DLI">Sân bay Liên Khương</option>
					                </optgroup>
					                <optgroup label="Miền Nam">
					                    <option value="Sân bay quốc tế Tân Sơn Nhất" data-code="SGN">Sân bay quốc tế Tân Sơn Nhất</option>
					                    <option value="Sân bay quốc tế Cần Thơ" data-code="VCA">Sân bay quốc tế Cần Thơ</option>
					                    <option value="Sân bay Phú Quốc" data-code="PQC">Sân bay Phú Quốc</option>
					                    <option value="Sân bay Cà Mau" data-code="CAH">Sân bay Cà Mau</option>
					                    <option value="Sân bay Rạch Giá" data-code="VKG">Sân bay Rạch Giá</option>
					                    <option value="Sân bay Côn Đảo" data-code="VCS">Sân bay Côn Đảo</option>
					                    <option value="Sân bay Buôn Ma Thuột" data-code="BMV">Sân bay Buôn Ma Thuột</option>
					                    <option value="Sân bay Pleiku" data-code="PXU">Sân bay Pleiku</option>
					                </optgroup>
					            </select>
					        </div>
					        <div class="md:col-span-1 space-y-1">
					            <label class="text-[11px] font-bold text-black uppercase ">Mã sân bay</label>
					            <input type="text" name="depCode" id="depCodeInput" readonly placeholder="MÃ" class="w-full px-4 py-2.5 rounded-lg border border-blue-200 outline-none font-bold text-center uppercase text-blue-800 transition bg-gray-100 cursor-not-allowed">
					        </div>
					    </div>
					
					    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-orange-50/50 p-5 rounded-2xl border border-orange-100 shadow-sm">
					        <div class="md:col-span-3 space-y-1">
					            <label class="text-[11px] font-bold text-black uppercase ml-1">Tên sân bay đến</label>
					            <select name="destName" id="destNameSelect" onchange="updateAirportCode('destNameSelect', 'destCodeInput')" class="w-full px-4 py-2.5 rounded-lg border border-orange-200 focus:ring-2 focus:ring-orange-500 outline-none font-bold transition text-gray-800 bg-white cursor-pointer">
					                <option value="" disabled selected>-- Chọn sân bay đến --</option>
					                <optgroup label="Miền Bắc">
					                    <option value="Sân bay quốc tế Nội Bài" data-code="HAN">Sân bay quốc tế Nội Bài</option>
					                    <option value="Sân bay quốc tế Cát Bi" data-code="HPH">Sân bay quốc tế Cát Bi</option>
					                    <option value="Sân bay quốc tế Vân Đồn" data-code="VDO">Sân bay quốc tế Vân Đồn</option>
					                    <option value="Sân bay Điện Biên" data-code="DIN">Sân bay Điện Biên</option>
					                    <option value="Sân bay Thọ Xuân" data-code="THD">Sân bay Thọ Xuân</option>
					                </optgroup>
					                <optgroup label="Miền Trung">
					                    <option value="Sân bay quốc tế Đà Nẵng" data-code="DAD">Sân bay quốc tế Đà Nẵng</option>
					                    <option value="Sân bay Phú Bài" data-code="HUI">Sân bay Phú Bài</option>
					                    <option value="Sân bay Chu Lai" data-code="VCL">Sân bay Chu Lai</option>
					                    <option value="Sân bay Phù Cát" data-code="UIH">Sân bay Phù Cát</option>
					                    <option value="Sân bay Tuy Hòa" data-code="TBB">Sân bay Tuy Hòa</option>
					                    <option value="Sân bay Cam Ranh" data-code="CXR">Sân bay Cam Ranh</option>
					                    <option value="Sân bay Liên Khương" data-code="DLI">Sân bay Liên Khương</option>
					                </optgroup>
					                <optgroup label="Miền Nam">
					                    <option value="Sân bay quốc tế Tân Sơn Nhất" data-code="SGN">Sân bay quốc tế Tân Sơn Nhất</option>
					                    <option value="Sân bay quốc tế Cần Thơ" data-code="VCA">Sân bay quốc tế Cần Thơ</option>
					                    <option value="Sân bay Phú Quốc" data-code="PQC">Sân bay Phú Quốc</option>
					                    <option value="Sân bay Cà Mau" data-code="CAH">Sân bay Cà Mau</option>
					                    <option value="Sân bay Rạch Giá" data-code="VKG">Sân bay Rạch Giá</option>
					                    <option value="Sân bay Côn Đảo" data-code="VCS">Sân bay Côn Đảo</option>
					                    <option value="Sân bay Buôn Ma Thuột" data-code="BMV">Sân bay Buôn Ma Thuột</option>
					                    <option value="Sân bay Pleiku" data-code="PXU">Sân bay Pleiku</option>
					                </optgroup>
					            </select>
					        </div>
					        <div class="md:col-span-1 space-y-1">
					            <label class="text-[11px] font-bold text-black uppercase ">Mã sân bay</label>
					            <input type="text" name="destCode" id="destCodeInput" readonly placeholder="MÃ" class="w-full px-4 py-2.5 rounded-lg border border-orange-200 outline-none font-bold text-center uppercase text-orange-600 transition bg-gray-100 cursor-not-allowed">
					        </div>
					    </div>
					</div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Ngày & Giờ đi</label>
                            <input type="datetime-local" name="departureTime" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Giá vé (VNĐ)</label>
                            <input type="number" name="price" placeholder="1200000" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold text-orange-600 transition">
                        </div>
                        <div class="space-y-2">
                            <label class="text-[11px] font-bold text-black uppercase tracking-widest ml-1">Tổng số ghế</label>
                            <input type="number" name="totalSeats" placeholder="180" class="w-full px-5 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none font-bold transition text-gray-800">
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-8 py-6 flex justify-end gap-4 border-t">
                    <button type="reset" class="px-6 py-3 rounded-xl text-gray-500 font-bold hover:bg-gray-200 transition uppercase text-xs">
                        Làm lại
                    </button>
                    <button type="submit" class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-3 px-10 rounded-xl transition shadow-lg shadow-orange-200 uppercase text-sm tracking-widest">
                        Xác nhận thêm chuyến
                    </button>
                </div>
            </form>
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
    </script>
    
    <script>
    	//thêm mã sân bay
        function updateAirportCode(selectId, inputId) {
            const selectElement = document.getElementById(selectId);
            const inputElement = document.getElementById(inputId);
            
            const selectedOption = selectElement.options[selectElement.selectedIndex];
            
            const code = selectedOption.getAttribute('data-code');
            
            if(code) {
                inputElement.value = code;
            }
        }
    </script>
</body>
</html>