<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
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

        .register-container {
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

        .register-container::before {
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

     
        .form-control:focus {
            border-color: #ff00ff;
            box-shadow: 0 0 12px rgba(255, 0, 255, 0.6);
            background: rgba(20, 20, 40, 1);
            color: #fff;
            transform: scale(1.02);
        }

        .btn-register {
            width: 100%;
            padding: 0.75rem;
            font-family: 'Orbitron', sans-serif;
            font-size: 1.1rem;
            background: linear-gradient(90deg, #ff00ff, #00eaff);
            border: none;
            border-radius: 50px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.4s ease;
            box-shadow: 0 6px 20px rgba(0, 255, 255, 0.4);
        }

        .btn-register:hover {
            background: linear-gradient(90deg, #00eaff, #ff00ff);
            box-shadow: 0 8px 25px rgba(255, 0, 255, 0.6);
            transform: translateY(-3px);
        }

        .btn-link {
            color: #00eaff;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            text-decoration: none;
            margin-top: 1rem;
            display: block;
            text-align: center;
            transition: all 0.3s ease;
        }

        .btn-link:hover {
            color: #ff00ff;
            text-shadow: 0 0 8px rgba(255, 0, 255, 0.6);
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

        .alert-info {
            background: rgba(0, 234, 255, 0.95);
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

    <div class="register-container">
        <h2>Đăng Ký Tài Khoản</h2>

        <%-- Hiển thị thông báo nếu có --%>
        <% String message = request.getParameter("message");
        if (message != null) {%>
        <div class="alert alert-info"><%= message%></div>
        <% } %>

        <%-- Hiển thị lỗi nếu có --%>
        <% String error = (String) request.getAttribute("error");
        if (error != null) {%>
        <div class="alert alert-danger"><%= error%></div>
        <% }%>

        <form action="RegisterServlet" method="POST" class="mt-3">
            <div class="form-group">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" name="username" 
                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Mật Khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <button type="submit" class="btn btn-register">Đăng Ký</button>
            <a href="login.jsp" class="btn btn-link">Đã có tài khoản? Đăng nhập</a>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>