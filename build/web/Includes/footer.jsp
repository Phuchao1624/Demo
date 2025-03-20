<%-- 
    Document   : footer
    Created on : Dec 13, 2023, 8:45:19 AM
    Author     : Dell
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Footer Section -->
<footer class="bg-dark text-light py-5">
    <div class="container">
        <div class="row">
            <!-- About Us Section -->
            <div class="col-md-3">
                <h5 class="text-warning border-bottom border-warning pb-2">About Us</h5>
                <p class="text-muted">
                    Chúng tôi mang đến cho bạn những thông tin mới nhất về thế giới game. Cập nhật, chia sẻ, review những tựa game hot . Cùng với đó là những hướng dẫn chi tiết bạn cần.
                </p>
                <a href="#" class="btn btn-sm btn-warning">Xem thêm</a>
            </div>

            <!-- Chuyên Mục Section -->
            <div class="col-md-3">
                <h5 class="text-warning border-bottom border-warning pb-2">Chuyên Mục</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted">Game Bắn Súng</a></li>
                    <li><a href="#" class="text-muted">Game Nhập Vai</a></li>
                    <li><a href="#" class="text-muted">Game Chính Thức</a></li>
                    <li><a href="#" class="text-muted">Game Mobile</a></li>
                    <li><a href="#" class="text-muted">Game Đối Kháng</a></li>
                </ul>
            </div>

            <!-- Thể Loại Section -->
            <div class="col-md-3">
                <h5 class="text-warning border-bottom border-warning pb-2">Thể Loại</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted">Game Bắn Súng Hướng Dẫn</a></li>
                    <li><a href="#" class="text-muted">Game Trí Tuệ</a></li>
                    <li><a href="#" class="text-muted">Game Đối Kháng</a></li>
                    <li><a href="#" class="text-muted">Review Game TLBB Khi</a></li>
                    <li><a href="#" class="text-muted">Hình ảnh game</a></li>
                </ul>
            </div>

            <!-- Contact Info Section -->
            <div class="col-md-3">
                <h5 class="text-warning border-bottom border-warning pb-2">Giới Thiệu</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted">Chính Sách Bảo Mật</a></li>
                    <li><a href="#" class="text-muted">Liên Hệ</a></li>
                </ul>
            </div>
        </div>

        <!-- Copyright Section -->
        <div class="row mt-4">
            <div class="col text-center">
                <p class="text-muted mb-0">&copy; 2025 - Thông tin về phát triển Việt Nam.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Custom CSS for Footer -->
<style>
    footer {
        background: linear-gradient(135deg, #1a1a1a, #2d2d2d); /* Gradient background */
        border-top: 2px solid #ffca28; /* Yellow accent border */
        font-family: 'Arial', sans-serif;
    }

    footer h5 {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    footer p, footer a {
        font-size: 0.9rem;
        transition: color 0.3s ease;
    }

    footer .text-muted {
        color: #b0b0b0 !important;
    }

    footer a.text-muted:hover {
        color: #ffca28 !important;
        text-decoration: none;
    }

    footer .btn-warning {
        background: #ffca28;
        border: none;
        color: #1a1a1a;
        font-weight: 600;
        padding: 0.4rem 1rem;
        border-radius: 20px;
        transition: all 0.3s ease;
    }

    footer .btn-warning:hover {
        background: #ffb300;
        box-shadow: 0 4px 12px rgba(255, 202, 40, 0.5);
    }

    footer ul li {
        margin-bottom: 0.5rem;
    }

    footer .border-bottom {
        border-color: #ffca28 !important;
    }
</style>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>