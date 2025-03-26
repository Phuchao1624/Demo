<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Footer Section -->
<footer class="text-light py-5">
    <div class="container">
        <div class="row">
            <!-- About Us Section -->
            <div class="col-md-3">
                <h5 class="text-cyan border-bottom border-cyan pb-2">Về Chúng Tôi</h5>
                <p class="text-muted">
                    Chúng tôi mang đến cho bạn những thông tin mới nhất về thế giới game. Cập nhật, chia sẻ, review những tựa game hot. Cùng với đó là những hướng dẫn chi tiết bạn cần.
                </p>
                <a href="#" class="btn btn-sm btn-custom">Xem thêm</a>
            </div>

            <!-- Chuyên Mục Section -->
            <div class="col-md-3">
                <h5 class="text-cyan border-bottom border-cyan pb-2">Chuyên Mục</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/category?categoryId=1" class="text-muted">Game Bắn Súng</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?categoryId=2" class="text-muted">Game Nhập Vai</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?categoryId=3" class="text-muted">Game Mobile</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?categoryId=4" class="text-muted">Game Đối Kháng</a></li>
                </ul>
            </div>

<!--             Thể Loại Section 
            <div class="col-md-3">
                <h5 class="text-cyan border-bottom border-cyan pb-2">Thể Loại</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted">Game Bắn Súng</a></li>
                    <li><a href="#" class="text-muted">Game Trí Tuệ</a></li>
                    <li><a href="#" class="text-muted">Game Đối Kháng</a></li>
                </ul>
            </div>-->

            <!-- Contact Info Section -->
            <div class="col-md-3">
                <h5 class="text-cyan border-bottom border-cyan pb-2">Giới Thiệu</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-muted">Chính Sách Bảo Mật</a></li>
                    <li><a href="#" class="text-muted">Liên Hệ</a></li>
                </ul>
            </div>
        </div>

        <!-- Payment Methods, Rating, and DMCA Section -->
        <div class="row mt-4">
            <!-- Payment Methods -->
            <div class="col-md-4 text-center">
                <h6 class="text-cyan mb-3">Phương Thức Thanh Toán</h6>
                <div class="payment-methods">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/MoMo_Logo.png/120px-MoMo_Logo.png" alt="Momo" class="payment-icon">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Visa_Logo.png/120px-Visa_Logo.png" alt="Visa" class="payment-icon">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/120px-Mastercard-logo.svg.png" alt="MasterCard" class="payment-icon">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/PayPal_logo.svg/120px-PayPal_logo.svg.png" alt="PayPal" class="payment-icon">
                </div>
            </div>

            <!-- Rating Section -->
            <div class="col-md-4 text-center">
                <h6 class="text-cyan mb-3">Đánh Giá</h6>
                <div class="rating">
                    <span class="text-muted">Reviews 17,762 • Excellent</span><br>
                    <span class="stars">★★★★★ 4.4</span><br>
                    <span class="verified"><i class="fas fa-check-circle"></i> Verified Company</span>
                </div>
            </div>

            <!-- DMCA Protected -->
            <div class="col-md-4 text-center">
                <h6 class="text-cyan mb-3">Bảo Vệ</h6>
                <div class="dmca">
                    <span class="dmca-label">DMCA PROTECTED</span>
                </div>
            </div>
        </div>

        <!-- Copyright Section -->
        <div class="row mt-4">
            <div class="col text-center">
                <p class="text-muted mb-0">© 2025 - Thông tin về phát triển Việt Nam.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Custom CSS for Footer -->
<style>
    footer {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        border-top: 2px solid #00eaff;
        font-family: 'Roboto', sans-serif;
    }

    footer h5, footer h6 {
        font-family: 'Orbitron', sans-serif;
        font-size: 1.2rem;
        font-weight: 600;
        color: #00eaff;
        text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
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
        color: #00eaff !important;
        text-decoration: none;
        text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
    }

    footer .btn-custom {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        color: #fff;
        font-family: 'Orbitron', sans-serif;
        font-weight: 600;
        padding: 0.4rem 1rem;
        border-radius: 20px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    footer .btn-custom:hover {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-2px);
    }

    footer ul li {
        margin-bottom: 0.5rem;
    }

    footer .border-bottom {
        border-color: #00eaff !important;
    }

    /* Payment Methods */
    .payment-methods {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 10px;
        padding: 10px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .payment-icon {
        width: 40px;
        height: 40px;
        margin: 0 5px;
        transition: transform 0.3s ease;
    }

    .payment-icon:hover {
        transform: scale(1.1);
    }

    /* Rating Section */
    .rating {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 10px;
        padding: 10px;
    }

    .stars {
        color: #ffca28;
        font-size: 1.2rem;
        text-shadow: 0 0 5px rgba(255, 202, 40, 0.5);
    }

    .verified {
        color: #00eaff;
        font-size: 0.9rem;
        text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
    }

    .verified i {
        color: #00eaff;
        margin-right: 5px;
    }

    /* DMCA Protected */
    .dmca {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 10px;
        padding: 10px;
    }

    .dmca-label {
        background: #ffca28;
        color: #1a1a2e;
        font-family: 'Orbitron', sans-serif;
        font-weight: 600;
        padding: 5px 15px;
        border-radius: 5px;
        text-transform: uppercase;
        box-shadow: 0 4px 15px rgba(255, 202, 40, 0.4);
    }

    /* Responsive */
    @media (max-width: 768px) {
        .row > div {
            margin-bottom: 2rem;
        }
        .payment-methods, .rating, .dmca {
            margin: 0 auto;
            max-width: 300px;
        }
    }
</style>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>