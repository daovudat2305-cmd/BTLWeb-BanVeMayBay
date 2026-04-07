package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordUtil {
	// trả về mật khẩu đã được băm
    public static String hashPassword(String password) {
        try {
            //thuật toán SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // Băm mật khẩu thành các byte
            byte[] hashBytes = md.digest(password.getBytes());
            
            // chuyển mảng byte thành chuỗi
            return Base64.getEncoder().encodeToString(hashBytes);
            
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
