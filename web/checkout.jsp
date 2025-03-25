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
    if (cartItems != null) {
        for (CartItem item : cartItems.values()) {
            total = total.add(item.getTotalPrice());
        }
    }
    request.setAttribute("total", total);

    // Kiểm tra xem orderId đã có trong session chưa
    Integer orderId = (Integer) session.getAttribute("orderId");

    if (orderId == null || orderId == -1) {  // 🛠 Kiểm tra kỹ nếu orderId bị giữ lại
        DAO dao = new DAO();
        orderId = dao.createNewOrder(user.getUserId(), total); // Tạo đơn hàng mới
        session.setAttribute("orderId", orderId);  // Cập nhật session với orderId mới
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
            .checkout-form, .order-summary {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .btn-order {
                background: #f60;
                color: #fff;
                width: 100%;
                font-size: 18px;
                padding: 10px;
            }
            .btn-order:disabled {
                background: #ccc;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <!-- Form Thanh Toán -->
                <div class="col-md-6 checkout-form">
                    <h3>THÔNG TIN THANH TOÁN</h3>

                    <%-- Hiển thị lỗi nếu có --%>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <form action="AddTransaction" method="post">
                        <label>Username:</label>
                        <input type="text" class="form-control" value="${acc.username}" readonly>

                        <label>Email:</label>
                        <input type="email" class="form-control" value="${acc.email}" readonly>

                        <label>Số điện thoại:</label>
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="Nhập số điện thoại" required>



                        <label>Phương thức thanh toán:</label>
                        <select name="paymentMethod" class="form-control" required>
                            <option value="VNPay" selected>VNPay</option>
                            <option value="cod">Thanh toán khi nhận hàng</option>
                        </select>

                        <input type="hidden" name="userId" value="${acc.userId}">
                        <input type="hidden" name="amount" id="finalAmount" value="${total}">

                        <button type="submit" class="btn btn-order" <%= (orderId == -1) ? "disabled" : ""%>>ĐẶT HÀNG</button>
                    </form>
                </div>

                <!-- Tổng Quan Đơn Hàng -->
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
    </body>
</html>

<jsp:include page="Includes/footer.jsp" />
