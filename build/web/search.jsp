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

<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        color: #e0e0e0;
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 0;
        overflow-x: hidden;
    }

    .container {
        padding-top: 50px;
        padding-bottom: 50px;
    }

    /* Tiêu đề */
    h2 {
        font-family: 'Orbitron', sans-serif;
        color: #00eaff;
        text-shadow: 0 0 10px rgba(0, 234, 255, 0.8);
        font-size: 2.5rem;
        text-align: center;
        margin-bottom: 2rem;
        letter-spacing: 2px;
        animation: glow 2s ease-in-out infinite alternate;
    }

    @keyframes glow {
        from {
            text-shadow: 0 0 5px rgba(0, 234, 255, 0.5), 0 0 10px rgba(0, 234, 255, 0.3);
        }
        to {
            text-shadow: 0 0 15px rgba(0, 234, 255, 0.8), 0 0 30px rgba(0, 234, 255, 0.6);
        }
    }

    /* Form tìm kiếm */
    .search-form {
        max-width: 600px;
        margin: 0 auto;
        position: relative;
    }

    .search-form .form-control {
        background: rgba(20, 20, 40, 0.85);
        border: 2px solid #00eaff;
        color: #fff;
        border-radius: 25px;
        padding: 0.75rem 1.5rem;
        font-size: 1.1rem;
        transition: all 0.3s ease;
    }

    .search-form .form-control:focus {
        border-color: #ff00ff;
        box-shadow: 0 0 12px rgba(255, 0, 255, 0.6);
        background: rgba(20, 20, 40, 1);
        transform: scale(1.02);
    }

    .search-form .btn-primary {
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        border-radius: 25px;
        padding: 0.75rem 2rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 1.1rem;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    .search-form .btn-primary:hover {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-3px);
    }

    /* Card game */
    .game-card {
        background: rgba(40, 40, 70, 0.95);
        border: 1px solid rgba(0, 255, 255, 0.4);
        border-radius: 15px;
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        position: relative;
    }

    .game-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 10px 30px rgba(0, 255, 255, 0.5), 0 0 20px rgba(255, 0, 255, 0.3);
    }

    .game-img {
        height: 250px;
        object-fit: cover;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        transition: transform 0.3s ease;
    }

    .game-card:hover .game-img {
        transform: scale(1.1);
    }

    .card-body {
        padding: 20px;
        text-align: center;
    }

    .card-title {
        font-family: 'Orbitron', sans-serif;
        color: #00eaff;
        font-size: 1.5rem;
        margin-bottom: 10px;
        text-shadow: 0 0 5px rgba(0, 234, 255, 0.5);
    }

    .card-text {
        font-size: 0.95rem;
        color: #b0b0b0;
        margin-bottom: 8px;
    }

    .card-text.price {
        color: #ffca28;
        font-weight: bold;
        font-size: 1.2rem;
        text-shadow: 0 0 5px rgba(255, 202, 40, 0.5);
    }

    .btn-custom {
        width: 100%;
        background: linear-gradient(90deg, #ff00ff, #00eaff);
        border: none;
        border-radius: 25px;
        padding: 0.75rem;
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        text-transform: uppercase;
        color: #fff;
        letter-spacing: 1.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 255, 255, 0.4);
    }

    .btn-custom:hover {
        background: linear-gradient(90deg, #00eaff, #ff00ff);
        box-shadow: 0 6px 20px rgba(255, 0, 255, 0.6);
        transform: translateY(-3px);
    }

    /* Thông báo không tìm thấy */
    .no-results {
        text-align: center;
        padding: 50px 0;
        color: #ff3333;
        font-family: 'Orbitron', sans-serif;
        font-size: 1.5rem;
        text-shadow: 0 0 5px rgba(255, 51, 51, 0.5);
        animation: shake 0.5s ease;
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-10px); }
        75% { transform: translateX(10px); }
    }

    .no-results i {
        font-size: 2rem;
        margin-right: 10px;
    }
</style>

<div class="container mt-4">
    <h2>🔍 Tìm Kiếm Game</h2>

    <!-- Form tìm kiếm -->
    <form action="search.jsp" method="GET" class="d-flex justify-content-center mt-3 search-form">
        <input type="text" name="keyword" class="form-control" placeholder="Nhập tên game, thể loại, nền tảng..." value="${param.keyword}" required>
        <button type="submit" class="btn btn-primary ms-2"><i class="fas fa-search me-2"></i>Tìm kiếm</button>
    </form>

    <div class="row mt-4">
        <c:choose>
            <c:when test="${not empty searchResults}">
                <c:forEach var="game" items="${searchResults}">
                    <div class="col-md-4 mb-4">
                        <div class="card game-card">
                            <img src="${game.imageUrl}" class="card-img-top game-img" alt="${game.title}">
                            <div class="card-body">
                                <h5 class="card-title">${game.title}</h5>
                                <p class="card-text">${game.genre} | ${game.platform}</p>
                                <p class="card-text">📅 Ngày phát hành: ${game.releaseDate}</p>
                                <p class="card-text">📦 Còn: ${game.stock} bản</p>
                                <p class="card-text price">💰 $${game.price}</p>
                                <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-custom">🔍 Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="no-results"><i class="fas fa-exclamation-triangle"></i>🚫 Không tìm thấy kết quả nào!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>