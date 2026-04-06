<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điền thông tin đặt vé</title>
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
                <a href="index.jsp" class="text-gray-600 hover:text-blue-600">Trang Chủ</a>
                <a href="#" class="text-gray-600 hover:text-blue-600">Săn Vé Rẻ</a>
                <a href="history.jsp" class="text-gray-600 hover:text-blue-600 flex items-center gap-1">
                    <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đặt vé
                </a>
            </div>
        </div>
        <div class="flex items-center space-x-4">
            <div class="text-gray-600 font-medium flex items-center gap-2">
                <i class="fa-solid fa-circle-user text-xl text-blue-600"></i>
                <span>Nguyễn Văn A</span>
            </div>
        </div>
    </nav>

    <main class="flex-grow max-w-6xl mx-auto w-full py-10 px-4 grid grid-cols-1 md:grid-cols-3 gap-8">
        
        <div class="md:col-span-2 space-y-6">
            
            <div class="bg-white rounded-xl shadow-sm p-4 border border-gray-200 flex justify-between items-center text-sm font-bold text-gray-500">
                <div class="flex items-center gap-2 text-blue-600">
                    <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center">1</div>
                    <span>Chọn chuyến bay</span>
                </div>
                <div class="flex-1 border-t-2 border-dashed border-gray-300 mx-4"></div>
                <div class="flex items-center gap-2 text-blue-600">
                    <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center">2</div>
                    <span>Điền thông tin</span>
                </div>
                <div class="flex-1 border-t-2 border-dashed border-gray-300 mx-4"></div>
                <div class="flex items-center gap-2">
                    <div class="w-6 h-6 rounded-full bg-gray-200 text-gray-500 flex items-center justify-center">3</div>
                    <span>Hoàn tất</span>
                </div>
            </div>

            <form action="success.jsp" method="POST" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                <div class="bg-blue-800 text-white px-6 py-4">
                    <h2 class="text-lg font-bold"><i class="fa-solid fa-address-card mr-2"></i>Thông tin hành khách</h2>
                    <p class="text-sm text-blue-200 mt-1">Vui lòng điền đầy đủ và chính xác thông tin để xuất vé.</p>
                </div>
                
                <div class="p-6 space-y-5">
                    <div>
                        <label class="block text-gray-700 font-bold mb-2">Họ và tên hành khách <span class="text-red-500">*</span></label>
                        <input type="text" name="passengerName" placeholder="Ví dụ: NGUYEN VAN A (Viết hoa không dấu)" 
                               required 
                               oninvalid="this.setCustomValidity('Vui lòng điền họ và tên hành khách')" 
                               oninput="this.setCustomValidity('')"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 uppercase">
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                        <div>
                            <label class="block text-gray-700 font-bold mb-2">Số Căn cước công dân (CCCD) <span class="text-red-500">*</span></label>
                            <input type="text" name="cccd" placeholder="Nhập 12 số CCCD" 
                                   required pattern="[0-9]{12}"
                                   oninvalid="if(this.value === '') { this.setCustomValidity('Vui lòng điền số CCCD') } else { this.setCustomValidity('CCCD phải bao gồm đúng 12 chữ số') }" 
                                   oninput="this.setCustomValidity('')"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>

                        <div>
                            <label class="block text-gray-700 font-bold mb-2">Số điện thoại <span class="text-red-500">*</span></label>
                            <input type="tel" name="phone" placeholder="Ví dụ: 0912345678" 
                                   required 
                                   oninvalid="this.setCustomValidity('Vui lòng điền số điện thoại liên hệ')" 
                                   oninput="this.setCustomValidity('')"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-gray-700 font-bold mb-2">Địa chỉ Email <span class="text-red-500">*</span></label>
                        <input type="email" name="email" placeholder="Hệ thống sẽ gửi vé điện tử về email này" 
                               required 
                               oninvalid="if(this.value === '') { this.setCustomValidity('Vui lòng điền địa chỉ email') } else { this.setCustomValidity('Vui lòng nhập đúng định dạng email (ví dụ: a@gmail.com)') }" 
                               oninput="this.setCustomValidity('')"
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div class="p-6 bg-gray-50 border-t border-gray-200">
                    <p class="text-sm text-gray-500 mb-4">
                        Bằng việc bấm xác nhận, bạn đồng ý với các <a href="#" class="text-blue-600 hover:underline">Điều khoản và Chính sách</a> của chúng tôi.
                    </p>
                    <button type="submit" class="w-full bg-orange-500 hover:bg-orange-600 text-white font-bold text-lg py-4 rounded-xl transition flex justify-center items-center gap-2">
                        XÁC NHẬN ĐẶT VÉ <i class="fa-solid fa-circle-check"></i>
                    </button>
                </div>
            </form>

        </div>

        <aside class="md:col-span-1">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden sticky top-24">
                <div class="p-5 border-b border-gray-200">
                    <h3 class="font-bold text-lg text-gray-800">Tóm tắt chuyến bay</h3>
                </div>
                
                <div class="p-5">
                    <div class="flex items-center gap-3 mb-4">
                        <span class="bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded">Vietjet Air</span>
                        <span class="text-sm font-bold text-gray-700">VJ-101</span>
                    </div>

                    <div class="flex justify-between items-center mb-6">
                        <div class="text-center">
                            <div class="text-lg font-bold">08:30</div>
                            <div class="text-xs text-gray-500">Hà Nội (HAN)</div>
                        </div>
                        <div class="flex flex-col items-center px-2 flex-1">
                            <span class="text-xs text-gray-400">1h 30m</span>
                            <div class="w-full border-t border-dashed border-gray-400 my-1 relative">
                                <i class="fa-solid fa-plane text-gray-400 absolute top-[-7px] right-0 bg-white pl-1"></i>
                            </div>
                            <span class="text-xs text-gray-400">22/11/2026</span>
                        </div>
                        <div class="text-center">
                            <div class="text-lg font-bold">10:00</div>
                            <div class="text-xs text-gray-500">Đà Nẵng (DAD)</div>
                        </div>
                    </div>

                    <div class="space-y-3 text-sm border-t border-gray-200 pt-4">
                        <div class="flex justify-between text-gray-600">
                            <span>Giá vé người lớn (x1)</span>
                            <span>1.200.000 đ</span>
                        </div>
                        <div class="flex justify-between text-gray-600">
                            <span>Thuế, phí sân bay</span>
                            <span>Sẽ tính ở bước thanh toán</span>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 p-5 border-t border-gray-200">
                    <div class="flex justify-between items-end">
                        <span class="font-bold text-gray-700">TỔNG CỘNG</span>
                        <span class="text-2xl font-black text-orange-600">1.200.000 đ</span>
                    </div>
                </div>
            </div>
        </aside>

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