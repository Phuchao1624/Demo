<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Order,entity.User, entity.OrderDetail, model.DAO" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    if (session.getAttribute("acc") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy đối tượng User từ session
    User user = (User) session.getAttribute("acc"); // ✅ Lấy User đúng cách
    Integer sessionUserId = user.getUserId(); // ✅ Lấy ID từ User

    // Kiểm tra nếu sessionUserId null thì điều hướng về trang login
    if (sessionUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy orderId từ request
    String orderIdParam = request.getParameter("id");
    int orderId = -1;

    try {
        orderId = Integer.parseInt(orderIdParam);
    } catch (NumberFormatException e) {
        orderId = -1; // Nếu không hợp lệ, đặt về -1
    }

    // Kiểm tra orderId hợp lệ và lấy thông tin đơn hàng
    Order order = (orderId != -1) ? DAO.getOrderById(orderId) : null;
    List<OrderDetail> orderDetails = (order != null) ? DAO.getOrderDetailsByOrderId(orderId) : null;

    // Nếu đơn hàng không tồn tại hoặc không thuộc về người dùng hiện tại, điều hướng về lịch sử đơn hàng
    if (order == null || !sessionUserId.equals(order.getUserId())) {
        response.sendRedirect("orders.jsp");
        return;
    }

    request.setAttribute("order", order);
    request.setAttribute("orderDetails", orderDetails);
%>



<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<div class="container mt-5">
    <h2 class="text-center text-primary">📜 Chi tiết đơn hàng #${order.orderId}</h2>

    <div class="card mt-3">
        <div class="card-header bg-dark text-white">
            Thông tin đơn hàng
        </div>
        <div class="card-body">
            <p><strong>📅 Ngày đặt:</strong> ${order.createdAt}</p>
            <p><strong>💵 Tổng tiền:</strong> $${order.totalAmount}</p>
            <p><strong>📦 Trạng thái:</strong> 
                <c:choose>
                    <c:when test="${order.status == 'pending'}">
                        <span class="badge bg-warning">Chờ xử lý</span>
                    </c:when>
                    <c:when test="${order.status == 'completed'}">
                        <span class="badge bg-success">Hoàn thành</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger">Đã hủy</span>
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>

    <h4 class="mt-4 text-center">🛒 Danh sách sản phẩm</h4>

    <c:choose>
        <c:when test="${not empty orderDetails}">
            <table class="table table-bordered table-hover mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Tên game</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Tổng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${orderDetails}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${detail.gameTitle}</td>
                            <td>${detail.quantity}</td>
                            <td>$${detail.price}</td>
                            <td>$${detail.price * detail.quantity}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="text-center text-danger fw-bold mt-4">🚫 Không có sản phẩm nào trong đơn hàng này!</p>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-4">
        <a href="orders.jsp" class="btn btn-secondary">🔙 Quay lại</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
