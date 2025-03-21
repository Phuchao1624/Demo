<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            overflow: hidden;
        }

        .login-container {
            width: 480px;
            background: rgba(40, 40, 70, 0.95);
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 255, 255, 0.25);
            border: 1px solid rgba(0, 255, 255, 0.4);
            backdrop-filter: blur(12px);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -60%;
            left: -60%;
            width: 220%;
            height: 220%;
            background: radial-gradient(circle, rgba(0, 255, 255, 0.15), transparent);
            transform: rotate(45deg);
            pointer-events: none;
            animation: glowMove 8s infinite;
        }

        @keyframes glowMove {
            0% { transform: rotate(45deg) translate(0, 0); }
            50% { transform: rotate(45deg) translate(10%, 10%); }
            100% { transform: rotate(45deg) translate(0, 0); }
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            color: #00eaff;
            text-shadow: 0 0 10px rgba(0, 234, 255, 0.8);
            font-size: 2rem;
            text-align: center;
            margin-bottom: 2rem;
            letter-spacing: 2px;
            background: rgba(0, 234, 255, 0.1);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            display: inline-block;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            font-family: 'Orbitron', sans-serif;
            color: #00eaff;
            font-size: 1rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
            text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
        }

        .form-control {
            background: rgba(20, 20, 40, 0.85);
            border: 1px solid #00eaff;
            color: #fff;
            border-radius: 25px; /* Bo tròn hoàn toàn hai đầu của ô nhập */
            padding: 0.75rem 1.25rem;
            font-size: 1rem;
            transition: all 0.4s ease;
            height: 45px;
            width: 100%;
        }

        .form-control:focus {
            border-color: #ff00ff;
            box-shadow: 0 0 12px rgba(255, 0, 255, 0.6);
            background: rgba(20, 20, 40, 1);
            color: #fff;
            transform: scale(1.02);
        }

        .btn-login {
            width: 100%;
            padding: 0.75rem;
            font-family: 'Orbitron', sans-serif;
            font-size: 1.1rem;
            background: linear-gradient(90deg, #ff00ff, #00eaff); /* Gradient từ tím sang xanh lam */
            border: none;
            border-radius: 50px; /* Bo tròn hoàn toàn nút */
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.4s ease;
            box-shadow: 0 6px 20px rgba(0, 255, 255, 0.4);
        }

        .btn-login:hover {
            background: linear-gradient(90deg, #00eaff, #ff00ff); /* Đảo ngược gradient khi hover */
            box-shadow: 0 8px 25px rgba(255, 0, 255, 0.6);
            transform: translateY(-3px);
        }

        .alert {
            background: rgba(255, 51, 51, 0.95);
            border: none;
            color: #fff;
            font-size: 0.9rem;
            padding: 0.75rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            text-shadow: 0 0 4px rgba(0, 0, 0, 0.4);
            animation: shake 0.3s;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .alert .close {
            color: #fff;
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .alert .close:hover {
            opacity: 1;
        }
    </style>
</head>
<body>
    <jsp:include page="Includes/header.jsp" />

    <div class="login-container">
        <h2>Đăng nhập</h2>
        
        <%-- Hiển thị thông báo lỗi nếu có --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            <%= error %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>
        <% } %>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-login">Đăng nhập</button>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>