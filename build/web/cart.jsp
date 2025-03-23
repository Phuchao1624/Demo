<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.User, entity.CartItem, model.DAO, java.util.Map, java.math.BigDecimal" %>

<%
    User user = (User) session.getAttribute("acc");
    if (user != null) {
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
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/cart.css">
</head>
<body>
    <jsp:include page="Includes/header.jsp" />

    <div class="container mt-5">
        <h2><i class="fas fa-shopping-cart me-2"></i>Giỏ Hàng Của Bạn</h2>

        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.checkoutMessage}">
            <div class="alert alert-info">${sessionScope.checkoutMessage}</div>
            <% session.removeAttribute("checkoutMessage"); %>
        </c:if>
        <c:if test="${not empty sessionScope.cartMessage}">
            <div class="alert alert-info">${sessionScope.cartMessage}</div>
            <% session.removeAttribute("cartMessage"); %>
        </c:if>

        <c:choose>
            <c:when test="${empty cartItems}">
                <p class="empty-cart"><i class="fas fa-exclamation-triangle"></i>🚫 Giỏ hàng trống!</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-dark table-hover">
                        <thead>
                            <tr>
                                <th>Game</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${cartItems}">
                                <tr>
                                    <td>
                                        <img src="${entry.value.game.imageUrl}" class="game-img" alt="${entry.value.game.title}">
                                        ${entry.value.game.title}
                                    </td>
                                    <td>${entry.value.game.price} VND</td>
                                    <td>${entry.value.quantity}</td>
                                    <td>${entry.value.totalPrice} VND</td>
                                    <td>
                                        <form action="UpdateCart" method="POST" style="display:inline;">
                                            <input type="hidden" name="gameId" value="${entry.key}">
                                            <input type="number" name="quantity" value="${entry.value.quantity}" min="0">
                                            <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                                        </form>
                                        <form action="RemoveFromCart" method="POST" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                            <input type="hidden" name="gameId" value="${entry.key}">
                                            <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <h4>Tổng tiền: ${total} VND</h4>
                <div class="action-buttons">
                    <a href="home.jsp" class="btn btn-secondary">Tiếp tục mua sắm</a>
                    <form action="checkout.jsp" method="GET">
                        <input type="hidden" name="total" value="${total}">
                        <button type="submit" class="btn btn-success">Thanh toán</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="Includes/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>