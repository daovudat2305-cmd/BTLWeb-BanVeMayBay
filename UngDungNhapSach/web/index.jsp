<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UNG DUNG NHAP SACH</title>
    <style>
        body { background-color: #F5F5DC; font-family: Arial, sans-serif; display: flex; justify-content: center; padding-top: 50px; }
        .container { text-align: center; }
        .form-group { margin: 15px 0; display: flex; align-items: center; justify-content: center; }
        .form-group label { width: 100px; text-align: left; }
        .form-group input, .form-group select { 
            width: 200px; 
            padding: 5px; 
            box-sizing: border-box; 
            border: 1px solid #767676;
            margin: 0;
        }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
        .btn-add { background-color: #ADD8E6; border: none; padding: 8px 20px; cursor: pointer; }
        .btn-reset { background-color: #FFC0CB; border: none; padding: 8px 20px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h2>UNG DUNG NHAP SACH</h2>
        
        <%-- Khối hiển thị lỗi nếu có --%>
        <% String error = (String) request.getAttribute("error"); %>
        <% if(error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <%-- Lấy category từ session, nếu chưa có mặc định là Comic --%>
        <% 
            String selectedCategory = (String) session.getAttribute("selectedCategory");
            if (selectedCategory == null) selectedCategory = "Comic";
        %>

        <form action="BookServlet" method="POST">
            <input type="hidden" name="action" value="add">
            
            <div class="form-group">
                <label>bookcode</label>
                <input type="text" name="bookcode" value="${param.bookcode}">
            </div>
            <div class="form-group">
                <label>title</label>
                <input type="text" name="title" value="${param.title}">
            </div>
            <div class="form-group">
                <label>author</label>
                <input type="text" name="author" value="${param.author}">
            </div>
            <div class="form-group">
                <label>category</label>
                <select name="category">
                    <option value="Comic" <%= "Comic".equals(selectedCategory) ? "selected" : "" %>>Comic</option>
                    <option value="Novel" <%= "Novel".equals(selectedCategory) ? "selected" : "" %>>Novel</option>
                    <option value="Science" <%= "Science".equals(selectedCategory) ? "selected" : "" %>>Science</option>
                </select>
            </div>
            
            <%-- Căn chỉnh khoảng cách 2 nút bấm --%>
            <div class="form-group" style="margin-top: 20px;">
                <div style="width: 100px;"></div>
                <div style="width: 200px; display: flex; justify-content: space-between;">
                    <button type="submit" class="btn-add">Add</button>
                    <button type="reset" class="btn-reset">Reset</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>