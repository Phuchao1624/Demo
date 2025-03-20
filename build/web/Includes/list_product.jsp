<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, model.DAO, java.util.List" %>

<%
    // Lấy danh sách game từ database và đặt vào request scope
    List<Game> games = DAO.getAllGames();
    request.setAttribute("games", games);
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>
    .game-card {
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
        overflow: hidden;
    }
    .game-card:hover {
        transform: scale(1.05);
    }
    .game-img {
        height: 250px;
        object-fit: cover;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
    }
    .card-body {
        text-align: center;
        padding: 15px;
    }
    .btn-custom {
        width: 100%;
        font-weight: bold;
        border-radius: 25px;
    }
</style>

<div class="container mt-4">
    <h2 class="text-center text-primary">🎮 Danh Sách Game</h2>
    <div class="row mt-4">
        <!-- Kiểm tra danh sách game có dữ liệu không -->
        <c:choose>
            <c:when test="${not empty games}">
                <c:forEach var="game" items="${games}">
                    <div class="col-md-4 mb-4">
                        <div class="card game-card">
                            <!-- Hiển thị hình ảnh -->
                            <img src="${game.imageUrl}" class="card-img-top game-img" alt="Hình ảnh game">
                            <div class="card-body">
                                <h5 class="card-title text-dark">${game.title}</h5>
                                <p class="card-text text-muted">${game.description}</p>
                                <p class="card-text text-success fw-bold">Price: $${game.price}</p>

                                <!-- Kiểm tra đăng nhập -->
                                <c:choose>
                                    <c:when test="${empty acc.username}">
                                        
                                        <form action="addToCartServlet" method="POST" class="mt-2">
                                            <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-primary btn-custom"> Thông tin chi tiết</a>
                                        </form>
                                        
                                        
                                    </c:when>
                                    <c:otherwise>
                                        <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-primary btn-custom"> Thông tin chi tiết</a>
                                        <form action="AddToCart" method="POST" class="mt-2">
                                            <input type="hidden" name="gameId" value="${game.gameId}">
                                            <button type="submit" class="btn btn-success btn-custom">🛒 Mua ngay</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-center text-danger fw-bold">🚫 Hiện chưa có game nào trong cửa hàng!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
