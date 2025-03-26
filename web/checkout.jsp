<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map, entity.User, entity.CartItem, model.DAO, java.math.BigDecimal" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra user đăng nhập
    User user = (User) session.getAttribute("acc");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy giỏ hàng từ DB
    Map<Integer, CartItem> cartItems = DAO.getCartByUserId(user.getUserId());
    request.setAttribute("cartItems", cartItems);

    // Tính tổng tiền đơn hàng
    BigDecimal total = BigDecimal.ZERO;
    if (cartItems != null && !cartItems.isEmpty()) {
        for (CartItem item : cartItems.values()) {
            total = total.add(item.getTotalPrice());
        }
    }
    request.setAttribute("total", total);

    // Kiểm tra và tạo orderId nếu chưa có
    Integer orderId = (Integer) session.getAttribute("orderId");
    if (orderId == null || orderId == -1) {
        DAO dao = new DAO();
        orderId = dao.createNewOrder(user.getUserId(), total);
        session.setAttribute("orderId", orderId);
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Game Store</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/checkout.css">
</head>
<body>
    <main class="container checkout-container">
        <h2 class="section-title">THANH TOÁN</h2>
        <div class="row">
            <!-- Form Thanh Toán -->
            <div class="col-md-6">
                <div class="checkout-form neon-box">
                    <h3 class="neon-text">THÔNG TIN THANH TOÁN</h3>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger neon-alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        </div>
                    </c:if>

                    <form action="AddTransaction" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="username" class="form-label neon-label">Username:</label>
                            <input type="text" class="form-control neon-input" id="username" value="${acc.username}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label neon-label">Email:</label>
                            <input type="email" class="form-control neon-input" id="email" value="${acc.email}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label neon-label">Số điện thoại:</label>
                            <input type="tel" class="form-control neon-input" name="phone" id="phone" placeholder="Nhập số điện thoại" pattern="[0-9]{10}" required>
                            <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10 chữ số).</div>
                        </div>

                        <div class="mb-3">
                            <label for="paymentMethod" class="form-label neon-label">Phương thức thanh toán:</label>
                            <select name="paymentMethod" id="paymentMethod" class="form-control neon-input" required>
                                <option value="VNPay" selected>VNPay</option>
                                <option value="cod">Thanh toán khi nhận hàng</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn phương thức thanh toán.</div>
                        </div>

                        <input type="hidden" name="userId" value="${acc.userId}">
                        <input type="hidden" name="amount" id="finalAmount" value="${total}">

                        <button type="submit" class="btn btn-order neon-btn" <%= (orderId == -1) ? "disabled" : ""%>>
                            <i class="fas fa-shopping-cart me-2"></i>ĐẶT HÀNG
                        </button>
                    </form>
                </div>
            </div>

            <!-- Tổng Quan Đơn Hàng -->
            <div class="col-md-6">
                <div class="order-summary neon-box">
                    <h3 class="neon-text">ĐƠN HÀNG CỦA BẠN</h3>
                    <div class="order-items">
                        <c:choose>
                            <c:when test="${empty cartItems}">
                                <p class="text-muted">Giỏ hàng của bạn đang trống.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="entry" items="${cartItems}">
                                    <div class="order-item">
                                        <span class="item-name">${entry.value.game.title}</span>
                                        <span class="item-price">${entry.value.totalPrice} ₫</span>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <hr class="neon-divider">
                    <h4 class="total-text">Tổng: <span id="finalTotal">${total} ₫</span></h4>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="Includes/footer.jsp" />

    <!-- Bootstrap JS (cho validation) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validation form
        (function () {
            'use strict';
            var forms = document.querySelectorAll('.needs-validation');
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>