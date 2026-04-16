/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import dao.UserDAO;

/**
 *
 * @author phant
 */
public class InitAdmin {
    public static void main(String[] args) {
        System.out.println("--- CHƯƠNG TRÌNH KHỞI TẠO ADMIN ---");
        
        // Thông tin admin bạn muốn tạo
        String adminUser = "Admin_1";
        String adminPass = "280825";
        String adminEmail = "admin_1@.com";
        String adminFullName = "Admin hệ thống";

        System.out.println("Đang kiểm tra và tạo tài khoản...");

        // Gọi hàm createAdminUser mà chúng ta đã viết ở bước trước
        // Hàm này đã có sẵn checkUsernameExist nên rất an toàn
        boolean success = UserDAO.createAdminUser(adminUser, adminEmail, adminPass, adminFullName);

        if (success) {
            System.out.println("✅ THÀNH CÔNG: Tài khoản Admin đã được tạo.");
            System.out.println("Bây giờ bạn có thể đăng nhập vào hệ thống Web.");
        } else {
            System.out.println("❌ THẤT BẠI: Tài khoản đã tồn tại hoặc có lỗi kết nối Database.");
        }
    }
}
