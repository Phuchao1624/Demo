<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, model.DAO, java.util.List" %>

<%
    List<Game> games = DAO.getAllGames();
    request.setAttribute("games", games);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game List - Game Store</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/list_product.css">
</head>
<body>
    <!-- List Product Section -->
    <section id="gameList" class="container mt-4">
        <h2>🎮 Danh Sách Game</h2>
        <div class="row mt-4">
            <c:choose>
                <c:when test="${not empty games}">
                    <c:forEach var="game" items="${games}">
                        <div class="col-md-4 mb-4">
                            <div class="card game-card">
                                <img src="${game.imageUrl}" class="card-img-top game-img" alt="${game.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${game.title}</h5>
                                    <p class="card-text">${game.genre} | ${game.platform}</p>
                                    <p class="card-text"><i class="fas fa-calendar-alt me-1"></i> ${game.releaseDate}</p>
                                    <p class="card-text"><i class="fas fa-box me-1"></i> Còn: ${game.stock} bản</p>
                                    <p class="card-text price"><i class="fas fa-coins me-1"></i> ${game.price} đ</p>

                                    <c:choose>
                                        <c:when test="${empty sessionScope.acc}">
                                            <div class="button-group">
                                                <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-details btn-icon" data-tooltip="Xem Chi Tiết"><i class="fas fa-search"></i></a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="button-group">
                                                <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-details btn-icon" data-tooltip="Xem Chi Tiết"><i class="fas fa-search"></i></a>
                                                <form action="AddToCart" method="POST">
                                                    <input type="hidden" name="gameId" value="${game.gameId}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-add-to-cart btn-icon" data-tooltip="Thêm Vào Giỏ Hàng"><i class="fas fa-cart-plus"></i></button>
                                                </form>
                                                <form action="AddToWishlist" method="POST">
                                                    <input type="hidden" name="gameId" value="${game.gameId}">
                                                    <button type="submit" class="btn btn-add-to-wishlist btn-icon" data-tooltip="Thêm Vào Yêu Thích"><i class="fas fa-heart"></i></button>
                                                </form>
                                            </div>
                                            <form action="AddToCart" method="POST">
                                                <input type="hidden" name="gameId" value="${game.gameId}">
                                                <input type="hidden" name="quantity" value="1">
                                                <input type="hidden" name="buyNow" value="true">
                                                <button type="submit" class="btn btn-custom"><i class="fas fa-cart-plus me-2"></i> Mua Ngay</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-games"><i class="fas fa-exclamation-triangle"></i>🚫 Hiện chưa có game nào trong cửa hàng!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>