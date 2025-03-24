<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game Store</title>

    <!-- Bootstrap 5.3.0 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Header CSS -->
    <link rel="stylesheet" href="CSS/header.css"/>
</head>
<body>
    <%-- Toast Notification cho Đăng ký --%>
    <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
    %>
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast toast-success" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Đăng ký thành công</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                <span>🎉 Chúc mừng bạn đã đăng ký thành công! Vui lòng đăng nhập để tiếp tục.</span>
            </div>
        </div>
    </div>
    <% } %>

    <%-- Toast Notification cho Đăng nhập --%>
    <%
        String loginSuccess = request.getParameter("loginSuccess");
        if ("1".equals(loginSuccess)) {
    %>
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast toast-login" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-sign-in-alt me-2"></i>
                <strong class="me-auto">Đăng nhập thành công</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                <span>👋 Chào mừng bạn trở lại! Hãy khám phá ngay nào!</span>
            </div>
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

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap 5.3.0 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <%-- Custom JavaScript --%>
    <script>
        $(document).ready(function() {
            // Khởi tạo toast cho đăng ký và đăng nhập
            $('.toast-success, .toast-login').each(function() {
                var toast = new bootstrap.Toast(this, {
                    autohide: true,
                    delay: 3000
                });
                toast.show();
            });

            // Xử lý cuộn khi trang được tải với hash
            const hash = window.location.hash.substring(1);
            if (hash) {
                const targetElement = document.getElementById(hash);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop,
                        behavior: 'smooth'
                    });
                }
            }

            // JavaScript for header hide/show on scroll
            let lastScrollTop = 0;
            const header = document.querySelector('header');

            window.addEventListener('scroll', () => {
                let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

                if (scrollTop > lastScrollTop) {
                    // Scrolling down
                    header.classList.add('hidden');
                } else {
                    // Scrolling up
                    header.classList.remove('hidden');
                }
                lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // For Mobile or negative scrolling
            });
        });
    </script>
</body>
</html>