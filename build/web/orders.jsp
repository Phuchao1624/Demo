<%@page import="entity.User"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Order, entity.OrderDetail, model.DAO" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra người dùng đã đăng nhập chưa
    User user = (User) session.getAttribute("acc");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy userId từ đối tượng User
    int userId = user.getUserId(); 

    // Lấy danh sách đơn hàng của người dùng
    List<Order> orders = DAO.getOrdersByUserId(userId);
    request.setAttribute("orders", orders);
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<div class="container mt-5">
    <h2 class="text-center text-primary">🛒 Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <table class="table table-bordered table-hover mt-4">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
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
                                <a href="orderDetails.jsp?id=${order.orderId}" class="btn btn-info btn-sm">📜 Xem chi tiết</a>
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
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
