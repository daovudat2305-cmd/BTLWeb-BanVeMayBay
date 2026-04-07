const loginForm = document.querySelector('form');

loginForm.addEventListener('submit', function(event) {
    
    const username = document.getElementById('username').value;

    if(username == null || username.trim().length === 0) {
        event.preventDefault();
        showToast("Vui lòng nhập tên đăng nhập hoặc email", "warning");
    }
	
	const password = document.getElementById('password').value;

    if(password == null || password.trim().length === 0) {
        event.preventDefault();
        showToast("Vui lòng nhập mật khẩu", "warning");
    }
    
});