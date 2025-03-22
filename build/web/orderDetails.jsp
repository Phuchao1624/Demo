<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, entity.Order, entity.User, model.DAO, java.sql.Timestamp, java.time.Duration, java.time.Instant" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    if (session.getAttribute("acc") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy đối tượng User từ session
    User user = (User) session.getAttribute("acc");
    Integer sessionUserId = user.getUserId();

    // Kiểm tra nếu sessionUserId null thì điều hướng về trang login
    if (sessionUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy danh sách đơn hàng của người dùng
    List<Order> orders = DAO.getOrdersByUserId(sessionUserId);

    // Kiểm tra và hủy đơn hàng nếu quá 5 phút mà chưa thanh toán
    for (Order order : orders) {
        if ("pending".equals(order.getStatus())) {
            Timestamp createdAt = order.getCreatedAt();
            Instant createdInstant = createdAt.toInstant();
            Instant now = Instant.now();
            long minutesElapsed = Duration.between(createdInstant, now).toMinutes();

            if (minutesElapsed >= 5) {
                // Cập nhật trạng thái đơn hàng thành "canceled"
                order.setStatus("canceled");
                DAO.updateOrderStatus(order.getOrderId(), "canceled");
            }
        }
    }

    request.setAttribute("orders", orders);
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<div class="container mt-5">
    <h2 class="text-center text-primary">📜 Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <table class="table table-bordered table-hover mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>${order.createdAt}</td>
                            <td>$${order.totalAmount}</td>
                            <td>
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
                            </td>
                            <td>
                                <a href="orderDetails.jsp?id=${order.orderId}" class="btn btn-sm btn-primary">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="text-center text-danger fw-bold mt-4">🚫 Bạn chưa có đơn hàng nào!</p>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-4">
        <a href="home.jsp" class="btn btn-secondary">🔙 Quay lại trang chủ</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="Includes/footer.jsp" />