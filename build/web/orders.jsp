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

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        color: #e0e0e0;
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 0;
        overflow-x: hidden;
    }

    .container {
        padding-top: 50px;
        padding-bottom: 50px;
    }

    h2 {
        font-family: 'Orbitron', sans-serif;
        color: #00eaff;
        text-shadow: 0 0 10px rgba(0, 234, 255, 0.8);
        font-size: 2.5rem;
        text-align: center;
        margin-bottom: 2rem;
        letter-spacing: 2px;
        animation: glow 2s ease-in-out infinite alternate;
    }

    @keyframes glow {
        from {
            text-shadow: 0 0 5px rgba(0, 234, 255, 0.5), 0 0 10px rgba(0, 234, 255, 0.3);
        }
        to {
            text-shadow: 0 0 15px rgba(0, 234, 255, 0.8), 0 0 30px rgba(0, 234, 255, 0.6);
        }
    }

    .table {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 15px;
        overflow: hidden;
    }

    .table thead {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        color: #fff;
        font-family: 'Orbitron', sans-serif;
        text-transform: uppercase;
        letter-spacing: 1.5px;
    }

    .table tbody tr {
        transition: background 0.3s ease;
    }

    .table tbody tr:hover {
        background: rgba(0, 234, 255, 0.1);
    }

    .table th, .table td {
        vertical-align: middle;
        text-align: center;
        color: #e0e0e0;
        border-color: rgba(0, 255, 255, 0.2);
    }

    .table td {
        font-size: 1.1rem;
    }

    .badge {
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        text-transform: uppercase;
    }

    .badge.bg-warning {
        background: #ffca28 !important;
        color: #1a1a2e;
        text-shadow: 0 0 5px rgba(255, 202, 40, 0.5);
    }

    .badge.bg-success {
        background: #00eaff !important;
        color: #1a1a2e;
        text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
    }

    .badge.bg-danger {
        background: #ff3333 !important;
        color: #fff;
        text-shadow: 0 0 5px rgba(255, 51, 51, 0.5);
    }

    .btn-info {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        border-radius: 25px;
        padding: 0.5rem 1rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        text-transform: uppercase;
        color: #fff;
        letter-spacing: 1.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    .btn-info:hover {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-3px);
    }

    .no-orders {
        text-align: center;
        padding: 50px 0;
        color: #ff3333;
        font-family: 'Orbitron', sans-serif;
        font-size: 1.5rem;
        text-shadow: 0 0 5px rgba(255, 51, 51, 0.5);
        animation: shake 0.5s ease;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-10px); }
        75% { transform: translateX(10px); }
    }

    .no-orders i {
        font-size: 2rem;
        margin-right: 10px;
    }
</style>

<div class="container">
    <h2>🛒 Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <table class="table table-bordered table-hover mt-4">
                <thead>
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
                            <td>${order.totalAmount} đ</td>
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
            <p class="no-orders"><i class="fas fa-exclamation-triangle"></i>🚫 Bạn chưa có đơn hàng nào!</p>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>