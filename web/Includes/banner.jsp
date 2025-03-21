<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Banner Section -->
<div class="game-banner text-center" id="gameBanner">
    <div class="overlay">
        <h1 class="display-3">Chào mừng đến với Cửa Hàng Game</h1>
        <p class="lead">Game ngon - Giá Rẻ!</p>
        <c:choose>
            <c:when test="${empty sessionScope.acc}">
                <!-- Nếu chưa đăng nhập, chuyển hướng đến trang login.jsp -->
                <a href="login.jsp" class="btn btn-warning btn-lg mt-3">Khám phá ngay</a>
            </c:when>
            <c:otherwise>
                <!-- Nếu đã đăng nhập, cuộn đến danh sách game -->
                <a href="#gameList" class="btn btn-warning btn-lg mt-3 scroll-to-games">Khám phá ngay</a>
                <!-- Mũi tên động -->
                <div class="arrow-down">
                    <i class="fas fa-chevron-down"></i>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Custom CSS for the Banner -->
<style>
    .game-banner {
        position: relative;
        height: 100vh; /* Full màn hình */
        width: 100vw; /* Full chiều rộng */
        background: url('https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center;
        background-size: cover;
        background-attachment: fixed; /* Hiệu ứng parallax nhẹ */
        color: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        overflow: hidden;
    }

    /* Overlay để tăng độ đọc của chữ */
    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6); /* Lớp phủ tối với độ trong suốt */
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 2rem;
    }

    /* Định dạng tiêu đề */
    .game-banner h1 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        font-size: 4rem; /* Tăng kích thước chữ cho full màn hình */
        text-transform: uppercase;
        letter-spacing: 2px;
        text-shadow: 0 0 15px rgba(255, 202, 40, 0.8), 0 0 30px rgba(255, 202, 40, 0.5); /* Hiệu ứng sáng neon */
        color: #ffca28; /* Màu vàng */
        animation: glow 2s ease-in-out infinite alternate; /* Hiệu ứng nhấp nháy */
    }

    /* Định dạng phụ đề */
    .game-banner p {
        font-family: 'Roboto', sans-serif;
        font-size: 1.8rem; /* Tăng kích thước chữ */
        font-weight: 400;
        color: #ffffff;
        text-shadow: 0 0 10px rgba(0, 0, 0, 0.7);
        margin-bottom: 2rem;
    }

    /* Định dạng nút */
    .game-banner .btn-warning {
        background: #ffca28;
        border: none;
        color: #1a1a1a;
        font-weight: 600;
        padding: 1rem 3rem; /* Tăng kích thước nút */
        border-radius: 25px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 202, 40, 0.5);
    }

    .game-banner .btn-warning:hover {
        background: #ffb300;
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(255, 202, 40, 0.8);
    }

    /* Hiệu ứng sáng nhấp nháy */
    @keyframes glow {
        from {
            text-shadow: 0 0 10px rgba(255, 202, 40, 0.5), 0 0 20px rgba(255, 202, 40, 0.3);
        }
        to {
            text-shadow: 0 0 20px rgba(255, 202, 40, 0.8), 0 0 40px rgba(255, 202, 40, 0.6);
        }
    }

    /* Mũi tên động */
    .arrow-down {
        margin-top: 2rem;
        animation: bounce 2s infinite;
    }

    .arrow-down i {
        font-size: 2rem;
        color: #ffca28;
        text-shadow: 0 0 10px rgba(255, 202, 40, 0.8);
    }

    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {
            transform: translateY(0);
        }
        40% {
            transform: translateY(-20px);
        }
        60% {
            transform: translateY(-10px);
        }
    }

    /* Điều chỉnh responsive */
    @media (max-width: 768px) {
        .game-banner {
            height: 100vh; /* Vẫn full màn hình trên mobile */
        }

        .game-banner h1 {
            font-size: 2.5rem;
        }

        .game-banner p {
            font-size: 1.2rem;
        }

        .game-banner .btn-warning {
            padding: 0.75rem 2rem;
        }

        .arrow-down i {
            font-size: 1.5rem;
        }
    }
</style>

<!-- JavaScript để xử lý cuộn mượt mà -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Tìm tất cả các nút có class "scroll-to-games"
        const scrollButtons = document.querySelectorAll('.scroll-to-games');

        scrollButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault(); // Ngăn hành vi mặc định của thẻ <a>
                
                // Lấy phần tử mục tiêu (danh sách game)
                const targetId = this.getAttribute('href').substring(1); // Bỏ dấu # để lấy ID
                const targetElement = document.getElementById(targetId);

                if (targetElement) {
                    // Cuộn mượt mà đến phần tử mục tiêu
                    window.scrollTo({
                        top: targetElement.offsetTop,
                        behavior: 'smooth'
                    });
                }
            });
        });
    });
</script>