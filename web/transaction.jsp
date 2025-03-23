<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, java.util.Map, entity.Transaction, entity.User, entity.CartItem, model.DAO, java.math.BigDecimal" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
    User user = (User) session.getAttribute("acc");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy giỏ hàng của người dùng
    Map<Integer, CartItem> cartItems = DAO.getCartByUserId(user.getUserId());
    request.setAttribute("cartItems", cartItems);

    // Tính tổng tiền
    BigDecimal total = BigDecimal.ZERO;
    if (cartItems != null) {
        for (CartItem item : cartItems.values()) {
            total = total.add(item.getTotalPrice());
        }
    }
    request.setAttribute("total", total);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f5f6fa;
                font-family: 'Roboto', sans-serif;
            }
            .container {
                margin-top: 30px;
                margin-bottom: 30px;
            }
            .payment-container {
                display: flex;
                gap: 20px;
            }
            .payment-info, .order-summary {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .payment-info {
                flex: 1;
            }
            .order-summary {
                flex: 1;
                border: 2px solid #28a745;
            }
            .payment-info h3, .order-summary h3 {
                font-family: 'Orbitron', sans-serif;
                color: #333;
                margin-bottom: 20px;
            }
            .form-label {
                font-weight: bold;
            }
            .order-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            .order-total {
                display: flex;
                justify-content: space-between;
                font-weight: bold;
                font-size: 1.2rem;
                margin-top: 20px;
            }
            .bank-info {
                margin-top: 20px;
                font-size: 0.9rem;
                color: #555;
            }
            .btn-order {
                background-color: #f60;
                color: #fff;
                font-weight: bold;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                width: 100%;
                margin-top: 20px;
            }
            .btn-order:hover {
                background-color: #e55;
            }
            .invalid-feedback {
                display: none;
                color: #dc3545;
                font-size: 0.875rem;
            }
            .is-invalid ~ .invalid-feedback {
                display: block;
            }
            .discount-feedback {
                display: none;
                color: #28a745;
                font-size: 0.875rem;
            }
            .discount-applied ~ .discount-feedback {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="payment-container">
                <!-- Thông tin thanh toán -->
                <div class="payment-info">
                    <h3>THÔNG TIN THANH TOÁN</h3>
                    <div class="mb-3">
                        <label class="form-label">Username *</label>
                        <input type="text" class="form-control" value="${acc.username}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại (tùy chọn)</label>
                        <input type="text" class="form-control" name="phone" id="phone" value="${acc.phone != null ? acc.phone : ''}" placeholder="Nhập số điện thoại">
                        <div class="invalid-feedback">
                            Vui lòng nhập số điện thoại hợp lệ (chỉ chứa số, 10-11 chữ số).
                        </div>
                    </div>
                        
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ email *</label>
                        <input type="email" class="form-control" value="${acc.email}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mã giảm giá</label>
                        <input type="text" class="form-control" id="discountCode" placeholder="Nhập mã giảm giá">
                        <div class="discount-feedback">
                            Mã giảm giá hợp lệ! Đã giảm 30,000 ₫.
                        </div>
                        <div class="invalid-feedback">
                            Mã giảm giá không hợp lệ.
                        </div>
                    </div>
                </div>

                <!-- Đơn hàng của bạn -->
                <div class="order-summary">
                    <h3>ĐƠN HÀNG CỦA BẠN</h3>
                    <div class="order-header">
                        <strong>SẢN PHẨM</strong>
                        <strong>TẠM TÍNH</strong>
                    </div>
                    <hr>
                    <c:forEach var="entry" items="${cartItems}">
                        <div class="order-item">
                            <span>${entry.value.game.title}</span>
                            <span>${entry.value.totalPrice} ₫</span>
                        </div>
                    </c:forEach>
                    <hr>
                    <div class="order-total">
                        <strong>Tổng</strong>
                        <strong id="finalTotal">${total} ₫</strong>
                    </div>
                    <div class="bank-info">
                        <p><strong>Chuyển khoản ngân hàng 24/7</strong></p>
                        <p>Đơn hàng của bạn sẽ được xác nhận tự động ngay sau khi thanh toán.</p>
                        <p><strong>Ngân hàng:</strong> ACB</p>
                        <p><strong>Chủ tài khoản:</strong> PRJ SHOP</p>
                        <p><strong>Số tài khoản:</strong> 123456789</p>
                    </div>
                    <form action="AddTransaction" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="orderId" id="orderId" value=""> <!-- ID đơn hàng -->
                        <input type="hidden" name="userId" value="${acc.userId}">
                        <input type="hidden" name="amount" id="finalAmount" value="${total}">
                        <input type="hidden" name="cardNumber" value="123456789"> <!-- Số tài khoản ngân hàng của shop -->
                        <input type="hidden" name="transactionType" value="transfer">
                        <input type="hidden" name="phone" id="phoneHidden">
                        <input type="hidden" name="discountCode" id="discountCodeHidden">
                        <input type="hidden" name="paymentMethod" id="paymentMethodHidden"> <!-- Phương thức thanh toán -->

                        <button type="submit" class="btn-order">ĐẶT HÀNG</button>
                    </form>

                </div>
            </div>
        </div>

        <jsp:include page="Includes/footer.jsp" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Custom JS for Validation and Discount -->
        <script>
                    const originalTotal = parseFloat('${total}'); // Tổng ban đầu
                    const discountCodeInput = document.getElementById('discountCode');
                    const finalTotalElement = document.getElementById('finalTotal');
                    const finalAmountInput = document.getElementById('finalAmount');
                    const discountCodeHidden = document.getElementById('discountCodeHidden');
                    const discountFeedback = discountCodeInput.nextElementSibling;
                    const invalidFeedback = discountFeedback.nextElementSibling;

                    // Xử lý mã giảm giá
                    discountCodeInput.addEventListener('input', function () {
                        const code = this.value.trim().toLowerCase();
                        let newTotal = originalTotal;

                        // Kiểm tra mã giảm giá
                        if (code === 'saleok') {
                            newTotal = originalTotal - 30000; // Giảm 30,000
                            this.classList.remove('is-invalid');
                            this.classList.add('discount-applied');
                            discountFeedback.style.display = 'block';
                            invalidFeedback.style.display = 'none';
                        } else if (code === '') {
                            this.classList.remove('is-invalid');
                            this.classList.remove('discount-applied');
                            discountFeedback.style.display = 'none';
                            invalidFeedback.style.display = 'none';
                        } else {
                            this.classList.add('is-invalid');
                            this.classList.remove('discount-applied');
                            discountFeedback.style.display = 'none';
                            invalidFeedback.style.display = 'block';
                        }

                        // Cập nhật tổng tiền hiển thị
                        finalTotalElement.textContent = newTotal.toLocaleString('vi-VN') + ' ₫';
                        finalAmountInput.value = newTotal;
                    });

                    // Xử lý form khi submit
                    function validateForm() {
                        const phoneInput = document.getElementById('phone');
                        const phoneHidden = document.getElementById('phoneHidden');
                        const phoneValue = phoneInput.value.trim();
                        const phonePattern = /^[0-9]{10,11}$/; // Chỉ cho phép số, 10-11 chữ số

                        // Kiểm tra số điện thoại
                        if (phoneValue && !phonePattern.test(phoneValue)) {
                            phoneInput.classList.add('is-invalid');
                            return false;
                        }

                        // Gán giá trị vào input hidden
                        phoneInput.classList.remove('is-invalid');
                        phoneHidden.value = phoneValue;

                        document.getElementById('discountCodeHidden').value = document.getElementById('discountCode').value.trim();

                        // Lấy phương thức thanh toán
                        const paymentMethod = document.querySelector('select[name="paymentMethod"]').value;
                        if (!paymentMethod) {
                            alert("Vui lòng chọn phương thức thanh toán!");
                            return false;
                        }
                        document.getElementById('paymentMethodHidden').value = paymentMethod;

                        // Tạo orderId ngẫu nhiên (Giả lập, có thể thay bằng server-side logic)
                        document.getElementById('orderId').value = "ORD" + Math.floor(Math.random() * 1000000);

                        return true;
                    }

        </script>
    </body>
</html>