<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Book"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xac nhan thong tin</title>
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
        .btn-confirm { background-color: #ADD8E6; border: none; padding: 8px 20px; cursor: pointer; }
        .btn-back { background-color: #FFC0CB; border: none; padding: 8px 20px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Xac nhan thong tin da nhap</h2>
        
        <%
            // Lấy thông tin sách từ session do Servlet gửi sang
            Book book = (Book) session.getAttribute("pendingBook");
            if (book == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>

        <div class="form-group">
            <label>bookcode</label>
            <input type="text" value="<%= book.getBookcode() %>" readonly>
        </div>
        <div class="form-group">
            <label>title</label>
            <input type="text" value="<%= book.getTitle() %>" readonly>
        </div>
        <div class="form-group">
            <label>author</label>
            <input type="text" value="<%= book.getAuthor() %>" readonly>
        </div>
        <div class="form-group">
            <label>category</label>
            <input type="text" value="<%= book.getCategory() %>" readonly>
        </div>
        
        <%-- Căn khoảng cách 2 nút bấm --%>
        <form action="BookServlet" method="POST" class="form-group" style="margin-top: 20px;">
            <div style="width: 100px;"></div>
            <div style="width: 200px; display: flex; justify-content: space-between;">
                <button type="submit" name="action" value="confirm" class="btn-confirm">Confirm</button>
                <button type="submit" name="action" value="back" class="btn-back">Back</button>
            </div>
        </form>
    </div>
</body>
</html>