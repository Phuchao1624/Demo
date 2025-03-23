<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map, entity.User, entity.CartItem, model.DAO, java.math.BigDecimal" %>

<jsp:include page="Includes/header.jsp" />

<%
    User user = (User) session.getAttribute("acc");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Map<Integer, CartItem> cartItems = DAO.getCartByUserId(user.getUserId());
    request.setAttribute("cartItems", cartItems);

    BigDecimal total = BigDecimal.ZERO;
    if (cartItems != null) {
        for (CartItem item : cartItems.values()) {
            total = total.add(item.getTotalPrice());
        }
    }
    request.setAttribute("total", total);

    // Lấy order_id mới nhất của user từ database
    DAO dao = new DAO();
    int orderId = dao.getLatestOrderId(user.getUserId());

    if (orderId == -1) {
        session.setAttribute("error", "Không tìm thấy đơn hàng hợp lệ!");
        response.sendRedirect("cart.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 40px;
        }
        .checkout-form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
        }
        .order-summary {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #28a745;
        }
        .btn-order {
            background: #f60;
            color: #fff;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 checkout-form">
                <h3>THÔNG TIN THANH TOÁN</h3>
                <form action="AddTransaction" method="post">
                    <label>Username:</label>
                    <input type="text" class="form-control" value="${acc.username}" readonly>
                    <label>Email:</label>
                    <input type="email" class="form-control" value="${acc.email}" readonly>
                    <label>Số điện thoại:</label>
                    <input type="text" class="form-control" name="phone" id="phone" placeholder="Nhập số điện thoại" required>

                    <label>Order ID:</label>
                    <input type="text" class="form-control" name="orderId" value="<%= orderId %>" readonly>

                    <label>Phương thức thanh toán:</label>
                    <select name="paymentMethod" class="form-control" required>
                        <option value="">-- Chọn phương thức --</option>
                        <option value="cod">Thanh toán khi nhận hàng</option>
                        <option value="VNPay">VNPay</option>
                    </select>

                    <input type="hidden" name="userId" value="${acc.userId}">
                    <input type="hidden" name="amount" id="finalAmount" value="${total}">

                    <button type="submit" class="btn btn-order">ĐẶT HÀNG</button>
                </form>
            </div>
            <div class="col-md-6 order-summary">
                <h3>ĐƠN HÀNG CỦA BẠN</h3>
                <c:forEach var="entry" items="${cartItems}">
                    <p>${entry.value.game.title} - ${entry.value.totalPrice} ₫</p>
                </c:forEach>
                <hr>
                <h4>Tổng: <span id="finalTotal">${total} ₫</span></h4>
            </div>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
</body>
</html>

<jsp:include page="Includes/footer.jsp" />
