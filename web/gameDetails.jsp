<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, model.DAO" %>

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

<style>
    body {
        background-color: #f8f9fa;
        position: relative;
    }

    /* Hình nền mờ */
    .background-blur {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        background-position: center;
        filter: blur(20px);
        opacity: 0.3;
        z-index: -1;
    }

    .game-container {
        max-width: 900px;
        margin: 30px auto;
        padding: 20px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .game-img {
        width: 100%;
        height: 400px;
        object-fit: cover;
        border-radius: 10px;
    }

    .game-info {
        font-size: 18px;
        line-height: 1.6;
    }

    .btn-custom {
        width: 100%;
        font-weight: bold;
        border-radius: 25px;
    }
</style>

<!-- Hình nền mờ -->
<c:if test="${not empty game}">
    <div class="background-blur" style="background-image: url('${game.imageUrl}');"></div>
</c:if>

<div class="container">
    <c:choose>
        <c:when test="${not empty game}">
            <div class="game-container">
                <!-- Hình ảnh game -->
                <img src="${game.imageUrl}" alt="Game Image" class="game-img">
                
                <!-- Tiêu đề -->
                <h2 class="mt-3 text-center text-primary">${game.title}</h2>
                <p class="text-muted text-center">${game.genre} | ${game.platform}</p>

                <!-- Thông tin chi tiết -->
                <div class="game-info mt-3">
                    <p><strong>📅 Ngày phát hành:</strong> ${game.releaseDate}</p>
                    <p><strong>🏢 Nhà phát triển:</strong> ${game.developer}</p>
                    <p><strong>📢 Nhà phát hành:</strong> ${game.publisher}</p>
                    <p><strong>📦 Kho hàng:</strong> ${game.stock} sản phẩm</p>
                    <p><strong>📖 Mô tả:</strong> ${game.description}</p>
                </div>

                <h4 class="text-success text-center">💰 Giá: $${game.price}</h4>

                <!-- Kiểm tra người dùng đã đăng nhập chưa -->
                <c:choose>
                    <c:when test="${empty acc.username  }">
                        <a href="login.jsp" class="btn btn-warning btn-custom mt-3">🔑 Đăng nhập để mua</a>
                    </c:when>
                    <c:otherwise>
                        <form action="addToCartServlet" method="POST" class="mt-3">
                            <input type="hidden" name="gameId" value="${game.gameId}">
                            <button type="submit" class="btn btn-success btn-custom">🛒 Thêm vào giỏ hàng</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger text-center fw-bold mt-5">
                🚫 Game không tồn tại hoặc ID không hợp lệ!
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
