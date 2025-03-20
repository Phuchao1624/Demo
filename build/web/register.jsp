<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng Ký</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="Includes/header.jsp" />


        <div class="container mt-5">
            <h2 class="text-center">Đăng Ký Tài Khoản</h2>

            <%-- Hiển thị thông báo nếu có --%>
            <% String message = request.getParameter("message");
        if (message != null) {%>
            <div class="alert alert-info"><%= message%></div>
            <% } %>

            <% String error = request.getParameter("error");
        if (error != null) {%>
            <div class="alert alert-danger"><%= error%></div>
            <% }%>

            <form action="RegisterServlet" method="POST" class="mt-3">
                <div class="mb-3">
                    <label for="username" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Mật Khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <button type="submit" class="btn btn-primary">Đăng Ký</button>
                <a href="login.jsp" class="btn btn-link">Đã có tài khoản? Đăng nhập</a>
            </form>
        </div>

    </body>
</html>
