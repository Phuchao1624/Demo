<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game Store</title>
    
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #f4f4f9;
            color: #333;
        }

        /* Toast Container */
        .toast {
            position: fixed;
            right: 30px;
            min-width: 320px;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            transition: all 0.3s ease;
            z-index: 1050; /* Đảm bảo toast nằm trên các phần tử khác */
        }

        /* Điều chỉnh vị trí động cho từng toast */
        .toast-success {
            bottom: 30px; /* Toast đầu tiên ở dưới cùng */
        }

        .toast-login {
            bottom: 130px; /* Toast thứ hai cách toast đầu 100px */
        }

        /* Toast Header */
        .toast-header {
            padding: 15px 20px;
            border-bottom: none;
            color: white;
            display: flex;
            align-items: center;
        }

        .toast-header i {
            font-size: 1.5rem;
            margin-right: 10px;
        }

        .toast-header strong {
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* Toast Body */
        .toast-body {
            padding: 20px;
            background: #fff;
            color: #444;
            font-size: 1rem;
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        /* Success Register Toast */
        .toast-success .toast-header {
            background: linear-gradient(135deg, #34c759, #28a745);
        }

        /* Success Login Toast */
        .toast-login .toast-header {
            background: linear-gradient(135deg, #00c6ff, #0072ff);
        }

        /* Close Button */
        .close {
            color: white;
            opacity: 0.9;
            font-size: 1.2rem;
            margin-left: auto;
            transition: opacity 0.3s ease;
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
        }

        .close:hover {
            opacity: 0.6;
        }

        /* Animation */
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .toast {
            animation: slideIn 0.5s ease forwards;
        }
    </style>
</head>

<body>
    <%-- Toast Notification cho Đăng ký --%>
    <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
    %>
    <div class="toast toast-success" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="fas fa-check-circle"></i>
            <strong class="mr-auto">Đăng ký thành công</strong>
            <button type="button" class="close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>
        <div class="toast-body">
            <span>🎉 Chúc mừng bạn đã đăng ký thành công! Vui lòng đăng nhập để tiếp tục.</span>
        </div>
    </div>
    <% } %>

    <%-- Toast Notification cho Đăng nhập --%>
    <%
        String loginSuccess = request.getParameter("loginSuccess");
        if ("1".equals(loginSuccess)) {
    %>
    <div class="toast toast-login" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="fas fa-sign-in-alt"></i>
            <strong class="mr-auto">Đăng nhập thành công</strong>
            <button type="button" class="close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>
        <div class="toast-body">
            <span>👋 Chào mừng bạn trở lại! Hãy khám phá ngay nào!</span>
        </div>
    </div>
    <% } %>

    <%-- Header --%>
    <jsp:include page="Includes/header.jsp" />

    <%-- Banner --%>
    <jsp:include page="Includes/banner.jsp" />

    <%-- List Product --%>
    <jsp:include page="Includes/list_product.jsp" />

    <%-- Footer --%>
    <jsp:include page="Includes/footer.jsp" />

    <%-- Scripts --%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <%-- Custom JavaScript --%>
    <script>
        $(document).ready(function() {
            // Khởi tạo toast với tự động ẩn sau 3 giây
            $('.toast').each(function() {
                $(this).toast({
                    autohide: true,
                    delay: 3000
                });
                $(this).toast('show');
            });

            // Đảm bảo nút "×" hoạt động
            $('.close').click(function() {
                $(this).closest('.toast').toast('hide');
            });

            // Xử lý cuộn khi trang được tải với hash (ví dụ: sau khi đăng nhập)
            const hash = window.location.hash.substring(1); // Lấy phần hash (bỏ #)
            if (hash) {
                const targetElement = document.getElementById(hash);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop,
                        behavior: 'smooth'
                    });
                }
            }
        });
    </script>
</body>
</html>