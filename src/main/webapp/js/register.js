const registerForm = document.querySelector('form');

registerForm.addEventListener('submit', function(event) {
    
	const fullName = document.getElementById('fullName').value;
    if(fullName == null || fullName.trim().length === 0) {
        event.preventDefault();
        showToast("Vui lòng nhập đầy đủ họ tên", "warning");
    }
		
	const email = document.getElementById('email').value;
    if(email == null || email.trim().length === 0) {
        event.preventDefault();
        showToast("Vui lòng nhập email", "warning");
    }
	
    const username = document.getElementById('username').value;
    if(username == null || username.trim().length === 0) {
        event.preventDefault();
        showToast("Vui lòng nhập tên đăng nhập", "warning");
    }
	
	const password = document.getElementById('password').value;
    if(password == null || password.trim().length < 8) {
        event.preventDefault();
        showToast("Mật khẩu phải từ 8 kí tự trở nên", "warning");
    }
    
});