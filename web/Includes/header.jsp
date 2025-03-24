<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="acc" value="${sessionScope.acc}" />

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand text-warning fw-bold" href="Home">
            <i class="fas fa-gamepad"></i> GameStore
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu content -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${acc.role == 'customer'}">
                    <li class="nav-item">
                        <a class="nav-link" href="wishlist.jsp"><i class="fas fa-heart"></i> Game yêu thích</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orderDetails.jsp"><i class="fas fa-history"></i> Lịch sử mua</a>
                    </li>
                    <!-- Nút giỏ hàng -->
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">
                            <i class="fas fa-shopping-cart"></i> Giỏ hàng 
                            <span class="badge bg-warning text-dark rounded-pill">${sessionScope.cartSize}</span>
                        </a>
                    </li>
                </c:if>
                <c:if test="${acc.role == 'admin'}">
                    <li class="nav-item">
                        <a class="nav-link" href="managerGames.jsp"><i class="fas fa-cogs"></i> Quản lý Games</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manageAccounts.jsp"><i class="fas fa-users-cog"></i> Quản lý tài khoản</a>
                    </li>
                </c:if>
            </ul>

            <!-- Search bar -->
            <form class="d-flex my-2 my-lg-0" action="search.jsp" method="GET">
                <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm game..." aria-label="Search">
                <button class="btn btn-outline-warning" type="submit" aria-label="Search">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <!-- User dropdown -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty acc}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-light" href="#" id="userDropdown" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user"></i> ${acc.username}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user-circle"></i> Hồ sơ</a></li>
                                <li><a class="dropdown-item" href="orderDetails.jsp"><i class="fas fa-shopping-bag"></i> Đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-light me-2" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-warning" href="register.jsp"><i class="fas fa-user-plus"></i> Đăng ký</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Bao gồm CSS và JS -->
<link rel="stylesheet" href="CSS/header.css">
<script src="JS/header.js"></script>