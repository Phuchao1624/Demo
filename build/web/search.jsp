<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, model.DAO, java.util.List" %>
        <jsp:include page="Includes/header.jsp" />


<%
    // Lấy từ khóa tìm kiếm từ request
    String keyword = request.getParameter("keyword");
    List<Game> searchResults = (keyword != null && !keyword.trim().isEmpty()) ? DAO.searchGames(keyword) : null;
    request.setAttribute("searchResults", searchResults);
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
    <h2 class="text-center text-primary">🔍 Tìm Kiếm Game</h2>

    <!-- Form tìm kiếm -->
    <form action="search.jsp" method="GET" class="d-flex justify-content-center mt-3">
        <input type="text" name="keyword" class="form-control w-50" placeholder="Nhập tên game, thể loại, nền tảng..." value="${param.keyword}" required>
        <button type="submit" class="btn btn-primary ms-2">Tìm kiếm</button>
    </form>

    <div class="row mt-4">
        <c:choose>
            <c:when test="${not empty searchResults}">
                <c:forEach var="game" items="${searchResults}">
                    <div class="col-md-4 mb-4">
                        <div class="card game-card">
                            <img src="${game.imageUrl}" class="card-img-top game-img" alt="Hình ảnh game">
                            <div class="card-body">
                                <h5 class="card-title text-dark">${game.title}</h5>
                                <p class="card-text text-muted">${game.genre} | ${game.platform}</p>
                                <p class="card-text text-success fw-bold">💰 $${game.price}</p>
                                <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-primary btn-custom">🔍 Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-center text-danger fw-bold">🚫 Không tìm thấy kết quả nào!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
