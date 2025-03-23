<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap 4.6 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<!-- Bootstrap 4.6 JS + jQuery + Popper.js -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<c:set var="acc" value="${sessionScope.acc}" />

<!-- Custom CSS -->
<style>
    /* Modern Navbar Styling */
    .navbar {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        padding: 1rem 2rem;
        border-bottom: 2px solid #00eaff;
        transition: transform 0.3s ease; /* Smooth transition for hiding/showing */
    }

    .navbar.hide {
        transform: translateY(-100%); /* Hide navbar by moving it up */
    }

    .navbar-brand {
        font-family: 'Orbitron', sans-serif;
        font-size: 1.8rem;
        color: #00eaff !important;
        text-shadow: 0 0 10px rgba(0, 234, 255, 0.8);
        letter-spacing: 1px;
        transition: transform 0.3s ease;
    }

    .navbar-brand:hover {
        transform: scale(1.05);
    }

    .nav-link {
        color: #ffffff !important;
        font-family: 'Roboto', sans-serif;
        font-weight: 500;
        padding: 0.5rem 1rem;
        transition: color 0.3s ease, background 0.3s ease;
    }

    .nav-link:hover, .nav-link:focus {
        color: #00eaff !important;
        background: rgba(0, 234, 255, 0.1);
        border-radius: 5px;
        outline: none;
    }

    .nav-link:focus {
        box-shadow: 0 0 0 2px rgba(0, 234, 255, 0.5);
    }

    /* Search Bar Styling */
    .form-inline {
        display: flex;
        align-items: center;
    }

    .form-control {
        background: rgba(20, 20, 40, 0.85);
        border: 2px solid #00eaff;
        color: #fff;
        border-radius: 25px 0 0 25px;
        padding: 0.6rem 1.2rem;
        font-family: 'Roboto', sans-serif;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        border-color: #ff00ff;
        box-shadow: 0 0 8px rgba(255, 0, 255, 0.6);
        background: rgba(20, 20, 40, 1);
        transform: scale(1.02);
    }

    .btn-outline-warning {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        border-radius: 0 25px 25px 0;
        padding: 0.6rem 1rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #fff;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    .btn-outline-warning:hover, .btn-outline-warning:focus {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-2px);
        outline: none;
    }

    /* Dropdown Styling */
    .dropdown-menu {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 8px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
    }

    .dropdown-item {
        color: #ffffff;
        font-family: 'Roboto', sans-serif;
        padding: 0.5rem 1.5rem;
        transition: background 0.3s ease, color 0.3s ease;
    }

    .dropdown-item:hover, .dropdown-item:focus {
        background: #00eaff;
        color: #1a1a2e;
        outline: none;
    }

    .dropdown-divider {
        border-color: rgba(0, 255, 255, 0.2);
    }

    /* Login/Register Buttons */
    .btn-outline-light {
        border: 2px solid #00eaff;
        color: #00eaff;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-family: 'Orbitron', sans-serif;
        text-transform: uppercase;
        transition: all 0.3s ease;
    }

    .btn-outline-light:hover, .btn-outline-light:focus {
        background: #00eaff;
        color: #1a1a2e;
        box-shadow: 0 4px 12px rgba(0, 234, 255, 0.5);
    }

    .btn-warning {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        color: #fff;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-family: 'Orbitron', sans-serif;
        font-weight: 600;
        text-transform: uppercase;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    .btn-warning:hover, .btn-warning:focus {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-2px);
        color: #fff;
    }

    /* Mobile Toggle */
    .navbar-toggler {
        border: 2px solid #00eaff;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(0, 234, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }

    /* Mobile Responsiveness */
    @media (max-width: 576px) {
        .form-control {
            width: 70%;
        }
        .btn-outline-warning {
            width: 25%;
        }
        .navbar-nav {
            text-align: center;
        }
    }

    /* Fix for fixed-top navbar */
    body {
        padding-top: 70px; /* Adjust based on navbar height */
    }
</style>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-3 fixed-top">
    <div class="container-fluid">
        <!-- Logo -->
        <a class="navbar-brand text-warning fw-bold" href="home.jsp">
            <i class="fas fa-gamepad"></i> GameStore
        </a>

        <!-- Toggle button for mobile -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
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
                        <a class="nav-link" href="purchaseHistory.jsp"><i class="fas fa-history"></i> Lịch sử mua</a>
                    </li>
                    <!-- Nút giỏ hàng -->
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">
                            <i class="fas fa-shopping-cart"></i> Giỏ hàng 
                            <span class="badge badge-pill badge-warning">${sessionScope.cartSize}</span>
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
            <form class="form-inline my-2 my-lg-0" action="search.jsp" method="GET">
                <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Tìm kiếm game..." aria-label="Search">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit" aria-label="Search">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <!-- User dropdown -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty acc}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-light" href="#" id="userDropdown" role="button" 
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user"></i> ${acc.username}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
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

<!-- JavaScript for hiding/showing navbar on scroll -->
<script>
    let lastScrollTop = 0;
    const navbar = document.querySelector('.navbar');

    window.addEventListener('scroll', function () {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        if (scrollTop > lastScrollTop) {
            // Cuộn xuống: ẩn navbar
            navbar.classList.add('hide');
        } else {
            // Cuộn lên: hiện navbar
            navbar.classList.remove('hide');
        }
        lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // Đảm bảo không âm
    });
</script>