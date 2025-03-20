<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap 4.6 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Bootstrap 4.6 JS + jQuery + Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<c:set var="acc" value="${sessionScope.acc}" />

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-3">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand text-warning fw-bold" href="home.jsp">
            <i class="fas fa-gamepad"></i> GameStore
        </a>

        <!-- Nút toggle cho mobile -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Nội dung menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${acc.role == 'customer'}">
                    <li class="nav-item">
                        <a class="nav-link" href="wishlist.jsp"><i class="fas fa-heart"></i> Game yêu thích</a>
                    </li>

                    <!-- Nếu tài khoản là admin, hiển thị các menu quản lý -->
                
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

            <!-- Thanh tìm kiếm -->
            <form class="form-inline my-2 my-lg-0" action="search.jsp" method="GET">
                <input class="form-control mr-sm-2" type="search" name="query" placeholder="Tìm kiếm game..." aria-label="Search">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit"><i class="fas fa-search"></i></button>
            </form>

            <!-- Dropdown user -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty acc}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-light" href="#" id="userDropdown" role="button" data-toggle="dropdown">
                                <i class="fas fa-user"></i> ${acc.username}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="profile.jsp"><i class="fas fa-user-circle"></i> Hồ sơ</a>
                                <a class="dropdown-item" href="orders.jsp"><i class="fas fa-shopping-bag"></i> Đơn hàng</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
                            </div>
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

<!-- Font Awesome cho icon -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
