<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, entity.Order, entity.User, model.DAO, java.sql.Timestamp, java.time.Duration, java.time.Instant" %>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>

<!-- Bootstrap 4.6 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng - Game Store</title>

    <!-- Bootstrap 5.3.0 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/orderHistory.css">
</head>
<body>
    <%-- Header --%>
    <jsp:include page="Includes/header.jsp" />

    <%
        User user = (User) session.getAttribute("acc");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Integer sessionUserId = user.getUserId();
        if (sessionUserId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Order> orders = DAO.getOrdersByUserId(sessionUserId);
        
        Instant now = Instant.now();
        for (Order order : orders) {
            if ("pending".equals(order.getStatus())) {
                Instant createdInstant = order.getCreatedAt().toInstant();
                if (Duration.between(createdInstant, now).toMinutes() >= 5) {
                    order.setStatus("canceled");
                    DAO.updateOrderStatus(order.getOrderId(), "canceled");
                }
            }
        }
        
        request.setAttribute("orders", orders);
    %>

    <div class="main-content">
        <div class="container">
            <h2 class="order-title">📜 Lịch Sử Đơn Hàng</h2>

            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mt-3">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>#${order.orderId}</td>
                                        <td>${order.createdAt}</td>
                                        <td><i class="fas fa-coins me-1"></i> ${order.totalAmount} đ</td>
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
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>🚫 Bạn chưa có đơn hàng nào!
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="text-center mt-4">
                <a href="home.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i> Quay lại trang chủ</a>
            </div>
        </div>
    </div>

    <%-- Footer --%>
    <jsp:include page="Includes/footer.jsp" />

    <!-- Bootstrap 5.3.0 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- JavaScript for header hide/show on scroll -->
    <script>
        let lastScrollTop = 0;
        const header = document.querySelector('header');

        window.addEventListener('scroll', () => {
            let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

            if (scrollTop > lastScrollTop) {
                // Scrolling down
                header.classList.add('hidden');
            } else {
                // Scrolling up
                header.classList.remove('hidden');
            }
            lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // For Mobile or negative scrolling
        });
    </script>
</body>
</html>