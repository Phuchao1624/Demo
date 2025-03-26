<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, model.DAO, java.util.*" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Lấy gameId từ URL
    String gameIdParam = request.getParameter("id");
    int gameId = -1;

    try {
        if (gameIdParam != null && gameIdParam.matches("\\d+")) {
            gameId = Integer.parseInt(gameIdParam);
        } else {
            System.out.println("DEBUG - gameId không hợp lệ: " + gameIdParam);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    Game game = (gameId != -1) ? DAO.getGameById(gameId) : null;
    request.setAttribute("game", game);
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<style>
    /* Global resets */
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    html, body {
        width: 100%;
        height: 100vh;
        overflow-x: hidden;
        overflow-y: auto;
    }

    /* Custom scrollbar styling */
    body::-webkit-scrollbar {
        width: 8px;
    }

    body::-webkit-scrollbar-track {
        background: transparent;
    }

    body::-webkit-scrollbar-thumb {
        background: rgba(0, 234, 255, 0.5);
        border-radius: 10px;
    }

    body::-webkit-scrollbar-thumb:hover {
        background: rgba(0, 234, 255, 0.8);
    }

    html {
        scrollbar-width: thin;
        scrollbar-color: rgba(0, 234, 255, 0.5) transparent;
    }

    body {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        color: #e0e0e0;
        font-family: 'Roboto', sans-serif;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* Header styling */
    header {
        position: fixed; /* Use fixed to ensure it stays at the top */
        top: 0;
        left: 0;
        width: 100%;
        background: #1a1a2e; /* Match the background gradient start */
        z-index: 1000;
        transition: transform 0.3s ease; /* Smooth transition for hiding/showing */
    }

    header.hidden {
        transform: translateY(-100%); /* Hide the header by moving it up */
    }

    /* Main content */
    .main-content {
        flex: 1 0 auto;
        padding-top: 60px; /* Match the header height */
        padding-bottom: 20px;
    }

    /* Background blur */
    .background-blur {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-size: cover;
        background-position: center;
        filter: blur(20px);
        opacity: 0.2;
        z-index: -1;
    }

    /* Bootstrap container */
    .container {
        max-width: 100%;
        padding: 0 15px;
    }

    .game-container {
        max-width: 900px;
        margin: 15px auto;
        padding: 15px;
        background: rgba(40, 40, 70, 0.95);
        border: 2px solid rgba(0, 255, 255, 0.4);
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0, 255, 255, 0.5);
    }

    /* Game image */
    .game-img-container {
        width: 100%;
        border-radius: 12px;
        overflow: hidden;
    }

    .game-img {
        width: 100%;
        height: auto;
        object-fit: cover; /* Ensure the image fills the container */
        border-radius: 12px;
        transition: transform 0.3s ease;
    }

    .game-img:hover {
        transform: scale(1.03);
    }

    .game-title {
        font-family: 'Orbitron', sans-serif;
        color: #00eaff;
        text-shadow: 0 0 8px rgba(0, 234, 255, 0.8);
        font-size: 1.8rem;
        text-align: center;
        margin: 0.5rem 0;
        letter-spacing: 1.5px;
        animation: glow 2s ease-in-out infinite alternate;
    }

    @keyframes glow {
        from {
            text-shadow: 0 0 4px rgba(0, 234, 255, 0.5), 0 0 8px rgba(0, 234, 255, 0.3);
        }
        to {
            text-shadow: 0 0 12px rgba(0, 234, 255, 0.8), 0 0 25px rgba(0, 234, 255, 0.6);
        }
    }

    .game-meta {
        font-family: 'Orbitron', sans-serif;
        color: #b0b0b0;
        text-align: center;
        font-size: 0.9rem;
        margin-bottom: 0.75rem;
    }

    .game-info {
        font-size: 0.9rem;
        line-height: 1.4;
        color: #e0e0e0;
        margin: 0.5rem 0;
    }

    .game-info p {
        margin-bottom: 0.3rem;
    }

    .game-info strong {
        color: #00eaff;
        text-shadow: 0 0 4px rgba(0, 234, 255, 0.5);
    }

    .price {
        font-family: 'Orbitron', sans-serif;
        color: #ffca28;
        font-size: 1.3rem;
        text-align: center;
        text-shadow: 0 0 4px rgba(255, 202, 40, 0.5);
        margin: 0.75rem 0;
    }

    .btn-custom {
        width: 100%;
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        border-radius: 20px;
        padding: 0.5rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 0.9rem;
        text-transform: uppercase;
        color: #fff;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        box-shadow: 0 3px 12px rgba(0, 255, 255, 0.4);
    }

    .btn-custom:hover {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 5px 15px rgba(255, 0, 255, 0.6);
        transform: translateY(-2px);
    }

    .btn-custom:disabled {
        background: #555;
        cursor: not-allowed;
        box-shadow: none;
    }

    .btn-add-to-cart {
        width: 100%;
        background: linear-gradient(90deg, #ffca28, #ff6200);
        border: none;
        border-radius: 20px;
        padding: 0.5rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 0.9rem;
        text-transform: uppercase;
        color: #fff;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        box-shadow: 0 3px 12px rgba(255, 202, 40, 0.4);
        margin-bottom: 5px;
    }

    .btn-add-to-cart:hover {
        background: linear-gradient(90deg, #ff6200, #ffca28);
        box-shadow: 0 5px 15px rgba(255, 98, 0, 0.6);
        transform: translateY(-2px);
    }

    .rating {
        text-align: center;
        margin: 0.75rem 0;
        font-family: 'Orbitron', sans-serif;
        color: #ffca28;
        font-size: 1rem;
        text-shadow: 0 0 4px rgba(255, 202, 40, 0.5);
    }

    .rating i {
        color: #ffca28;
        margin-right: 4px;
    }

    .system-requirements {
        margin: 0.75rem 0;
    }

    .system-requirements h4 {
        font-family: 'Orbitron', sans-serif;
        color: #00eaff;
        text-shadow: 0 0 4px rgba(0, 234, 255, 0.5);
        margin-bottom: 0.5rem;
        font-size: 1.1rem;
    }

    .system-requirements ul {
        list-style: none;
        padding: 0;
    }

    .system-requirements li {
        margin-bottom: 0.2rem;
        color: #b0b0b0;
        font-size: 0.9rem;
    }

    .system-requirements li strong {
        color: #e0e0e0;
    }

    .share-buttons {
        text-align: center;
        margin: 0.75rem 0;
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 12px;
    }

    .share-buttons h4 {
        color: #00eaff;
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        margin-bottom: 0.3rem;
    }

    .share-buttons a {
        font-size: 1.1rem;
        color: #00eaff;
        transition: color 0.3s ease;
    }

    .share-buttons a:hover {
        color: #ff00ff;
    }

    .alert {
        font-family: 'Orbitron', sans-serif;
        color: #ff3333;
        text-shadow: 0 0 4px rgba(255, 51, 51, 0.5);
        font-size: 1.2rem;
        text-align: center;
        margin: 1.5rem 0;
        animation: shake 0.5s ease;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-8px); }
        75% { transform: translateX(8px); }
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .game-container {
            margin: 10px auto;
            padding: 10px;
        }

        .game-title {
            font-size: 1.5rem;
        }

        .price {
            font-size: 1.1rem;
        }

        .btn-custom, .btn-add-to-cart {
            font-size: 0.8rem;
            padding: 0.4rem;
        }
    }
</style>

<!-- Hình nền mờ -->
<c:if test="${not empty game}">
    <div class="background-blur" style="background-image: url('${game.imageUrl}');"></div>
</c:if>

<div class="main-content">
    <div class="container">
        <c:choose>
            <c:when test="${not empty game}">
                <div class="game-container">
                    <!-- Hình ảnh game -->
                    <div class="game-img-container">
                        <img src="${game.imageUrl}" alt="${game.title}" class="game-img">
                    </div>

                    <!-- Tiêu đề -->
                    <h2 class="game-title mt-3">${game.title}</h2>
                    <p class="game-meta">${game.genre} | ${game.platform}</p>

                    <!-- Đánh giá -->
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span>4.5/5 (123 đánh giá)</span>
                    </div>

                    <!-- Thông tin chi tiết -->
                    <div class="game-info mt-3">
                        <p><strong>📅 Ngày phát hành:</strong> ${game.releaseDate}</p>
                        <p><strong>🏢 Nhà phát triển:</strong> ${game.developer}</p>
                        <p><strong>📢 Nhà phát hành:</strong> ${game.publisher}</p>
                        <p><strong>📦 Kho hàng:</strong> ${game.stock} sản phẩm</p>
                        <p><strong>📖 Mô tả:</strong> ${game.description}</p>
                    </div>

                    <!-- Yêu cầu hệ thống -->
                    <div class="system-requirements">
                        <h4>Yêu cầu hệ thống</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <h5 style="color: #ffca28;">Tối thiểu</h5>
                                <ul>
                                    <li><strong>Hệ điều hành:</strong> Windows 10</li>
                                    <li><strong>CPU:</strong> Intel Core i5-4460</li>
                                    <li><strong>RAM:</strong> 8GB</li>
                                    <li><strong>GPU:</strong> NVIDIA GTX 970</li>
                                    <li><strong>Dung lượng:</strong> 50GB</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h5 style="color: #ffca28;">Đề nghị</h5>
                                <ul>
                                    <li><strong>Hệ điều hành:</strong> Windows 11</li>
                                    <li><strong>CPU:</strong> Intel Core i7-9700</li>
                                    <li><strong>RAM:</strong> 16GB</li>
                                    <li><strong>GPU:</strong> NVIDIA RTX 3060</li>
                                    <li><strong>Dung lượng:</strong> 50GB (SSD)</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Giá -->
                    <h4 class="price">💰 Giá: ${game.price} đ</h4>

                    <!-- Kiểm tra người dùng đã đăng nhập chưa -->
                    <c:choose>
                        <c:when test="${empty sessionScope.acc}">
                            <a href="login.jsp" class="btn btn-custom"><i class="fas fa-sign-in-alt me-2"></i>🔑 Đăng nhập để mua</a>
                        </c:when>
                        <c:otherwise>
                            <!-- Nút Thêm vào giỏ hàng -->
                            <form action="AddToCart" method="POST">
                                <input type="hidden" name="gameId" value="${game.gameId}">
                                <input type="hidden" name="quantity" value="1">
                                <c:choose>
                                    <c:when test="${game.stock > 0}">
                                        <button type="submit" class="btn btn-add-to-cart"><i class="fas fa-cart-plus me-2"></i>THÊM VÀO GIỎ HÀNG</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn btn-custom" disabled><i class="fas fa-exclamation-triangle me-2"></i>⛔ Hết hàng</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                            <!-- Nút Mua ngay -->
                            <form action="AddToCart" method="POST">
                                <input type="hidden" name="gameId" value="${game.gameId}">
                                <input type="hidden" name="quantity" value="1">
                                <input type="hidden" name="buyNow" value="true">
                                <c:choose>
                                    <c:when test="${game.stock > 0}">
                                        <button type="submit" class="btn btn-custom"><i class="fas fa-cart-plus me-2"></i>🛒 MUA NGAY</button>
                                    </c:when>
                                    
                                </c:choose>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <!-- Chia sẻ lên mạng xã hội -->
                    <div class="share-buttons">
                        <h4>Chia sẻ</h4>
                        <a href="https://www.facebook.com/sharer/sharer.php?u=${pageContext.request.requestURL}" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://twitter.com/intent/tweet?url=${pageContext.request.requestURL}&text=Check out this awesome game: ${game.title}" target="_blank"><i class="fab fa-twitter"></i></a>
                        <a href="https://www.linkedin.com/shareArticle?mini=true&url=${pageContext.request.requestURL}" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>🚫 Game không tồn tại hoặc ID không hợp lệ!
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
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