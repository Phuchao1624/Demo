<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.User, entity.CartItem, model.DAO, java.util.Map" %>

<%
    User user = (User) session.getAttribute("acc");
    if (user != null) {
        Map<Integer, CartItem> cartItems = DAO.getCartByUserId(user.getUserId());
        request.setAttribute("cartItems", cartItems);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Giỏ hàng của bạn</h2>
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
                <p>Giỏ hàng trống!</p>
            </c:when>
            <c:otherwise>
                <table class="table table-bordered">
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
                                <td>${entry.value.game.title}</td>
                                <td>${entry.value.game.price}</td>
                                <td>${entry.value.quantity}</td>
                                <td>${entry.value.totalPrice}</td>
                                <td>
                                    <form action="UpdateCart" method="POST" style="display:inline;">
                                        <input type="hidden" name="gameId" value="${entry.key}">
                                        <input type="number" name="quantity" value="${entry.value.quantity}" min="0">
                                        <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                                    </form>
                                    <form action="RemoveFromCart" method="POST" style="display:inline;">
                                        <input type="hidden" name="gameId" value="${entry.key}">
                                        <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <h4>Tổng tiền: ${cartItems.values().stream().map(item -> item.totalPrice).reduce(BigDecimal.ZERO, (a, b) -> a.add(b))}</h4>
                <form action="Checkout" method="POST">
                    <button type="submit" class="btn btn-success">Thanh toán</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>