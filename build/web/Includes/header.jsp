<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap 4.6 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Bootstrap 4.6 JS + jQuery + Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<c:set var="acc" value="${sessionScope.acc}" />

<!-- Custom CSS -->
<style>
    /* Modern Navbar Styling */
    .navbar {
        background: linear-gradient(135deg, #1a1a1a, #2d2d2d); /* Gradient background */
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); /* Subtle shadow */
        padding: 1rem 2rem; /* Increased padding */
        border-bottom: 2px solid #ffca28; /* Accent border */
    }

    .navbar-brand {
        font-size: 1.8rem; /* Larger logo text */
        font-family: 'Arial', sans-serif;
        letter-spacing: 1px;
        transition: transform 0.3s ease; /* Smooth hover effect */
    }

    .navbar-brand:hover {
        transform: scale(1.05); /* Slight scale on hover */
    }

    .nav-link {
        color: #ffffff !important; /* White text */
        font-weight: 500;
        padding: 0.5rem 1rem;
        transition: color 0.3s ease, background 0.3s ease; /* Smooth transitions */
    }

    .nav-link:hover {
        color: #ffca28 !important; /* Yellow hover effect */
        background: rgba(255, 202, 40, 0.1); /* Subtle background on hover */
        border-radius: 5px;
    }

    /* Search Bar Styling */
    .form-control {
        border: none;
        border-radius: 25px 0 0 25px; /* Rounded left side */
        background: #ffffff;
        padding: 0.6rem 1.2rem;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .form-control:focus {
        box-shadow: 0 0 8px rgba(255, 202, 40, 0.5); /* Glow effect on focus */
        border-color: #ffca28;
    }

    .btn-outline-warning {
        border-radius: 0 25px 25px 0; /* Rounded right side */
        border: 2px solid #ffca28;
        color: #ffca28;
        padding: 0.5rem 1rem;
        transition: all 0.3s ease;
    }

    .btn-outline-warning:hover {
        background: #ffca28;
        color: #1a1a1a;
        box-shadow: 0 4px 12px rgba(255, 202, 40, 0.4); /* Hover shadow */
    }

    /* Dropdown Styling */
    .dropdown-menu {
        background: #2d2d2d; /* Dark background */
        border: none;
        border-radius: 8px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4); /* Elevated shadow */
    }

    .dropdown-item {
        color: #ffffff;
        padding: 0.5rem 1.5rem;
        transition: background 0.3s ease, color 0.3s ease;
    }

    .dropdown-item:hover {
        background: #ffca28;
        color: #1a1a1a;
    }

    .dropdown-divider {
        border-color: rgba(255, 255, 255, 0.2); /* Subtle divider */
    }

    /* Login/Register Buttons */
    .btn-outline-light {
        border: 2px solid #ffffff;
        color: #ffffff;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        transition: all 0.3s ease;
    }

    .btn-outline-light:hover {
        background: #ffffff;
        color: #1a1a1a;
        box-shadow: 0 4px 12px rgba(255, 255, 255, 0.3);
    }

    .btn-warning {
        background: #ffca28;
        border: none;
        color: #1a1a1a;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-warning:hover {
        background: #ffb300;
        box-shadow: 0 4px 12px rgba(255, 202, 40, 0.5);
        color: #1a1a1a;
    }

    /* Mobile Toggle */
    .navbar-toggler {
        border: 2px solid #ffca28;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 202, 40, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }
</style>

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