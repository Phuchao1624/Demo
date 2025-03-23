<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - Game Store</title>

    <!-- Bootstrap 5.3.0 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/wishlist.css">
</head>

<body>
    <%-- Header --%>
    <jsp:include page="Includes/header.jsp" />

    <div class="main-content">
        <div class="container">
            <h2 class="wishlist-title">🎮 Danh Sách Yêu Thích</h2>

            <c:choose>
                <c:when test="${not empty sessionScope.wishlist}">
                    <div class="row">
                        <c:forEach var="game" items="${sessionScope.wishlist}">
                            <div class="col-md-4 col-sm-6 mb-4">
                                <div class="game-card">
                                    <div class="game-img-container">
                                        <img src="${game.imageUrl}" alt="${game.title}" class="game-img">
                                    </div>
                                    <h5 class="game-title">${game.title}</h5>
                                    <p class="game-meta">${game.genre} | ${game.platform}</p>
                                    <p class="price"><i class="fas fa-coins me-1"></i> ${game.price} đ</p>
                                    <div class="game-actions">
                                        <a href="gameDetails.jsp?id=${game.gameId}" class="btn btn-view-details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <form action="RemoveFromWishlist" method="POST" class="d-inline">
                                            <input type="hidden" name="gameId" value="${game.gameId}">
                                            <button type="submit" class="btn btn-remove">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>🚫 Danh sách yêu thích của bạn đang trống!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- Footer --%>
    <jsp:include page="Includes/footer.jsp" />

    <!-- Bootstrap 5.3.0 JS -->
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
</body>
</html>