<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="entity.Game, java.util.*" %>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Popper.js (Bootstrap 4 cần Popper.js để dropdown hoạt động) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>

<!-- Bootstrap 4.6 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"="width=device-width, initial-scale=1.0">
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
        <!-- Toast Notification -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="removeWishlistToast" class="toast toast-remove" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                <div class="toast-header">
                    <strong class="me-auto">Thông Báo</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    <i class="fas fa-trash-alt me-2"></i> Đã xóa game khỏi danh sách yêu thích!
                </div>
            </div>
        </div>

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
                                        <form class="remove-from-wishlist-form d-inline" data-game-id="${game.gameId}">
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

    <!-- JavaScript for RemoveFromWishlist -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Ẩn toast khi trang tải
            const toastElement = document.getElementById('removeWishlistToast');
            const toast = new bootstrap.Toast(toastElement);
            toast.hide();

            // Lấy tất cả các form "RemoveFromWishlist"
            const removeForms = document.querySelectorAll('.remove-from-wishlist-form');

            removeForms.forEach(form => {
                form.addEventListener('submit', function (event) {
                    event.preventDefault(); // Ngăn form gửi yêu cầu thông thường

                    // Lấy gameId từ thuộc tính data
                    const gameId = form.getAttribute('data-game-id');

                    // Tạo FormData để gửi dữ liệu
                    const formData = new FormData();
                    formData.append('gameId', gameId);

                    // Gửi yêu cầu AJAX
                    fetch('RemoveFromWishlist', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Hiển thị toast thông báo
                            const toastElement = document.getElementById('removeWishlistToast');
                            const toast = new bootstrap.Toast(toastElement);
                            toast.show();

                            // Xóa thẻ game khỏi giao diện
                            const gameCard = form.closest('.col-md-4');
                            gameCard.remove();

                            // Kiểm tra nếu wishlist rỗng, hiển thị thông báo "Danh sách trống"
                            const wishlistItems = document.querySelectorAll('.col-md-4');
                            if (wishlistItems.length === 0) {
                                const container = document.querySelector('.container .row');
                                container.outerHTML = `
                                    <div class="alert">
                                        <i class="fas fa-exclamation-triangle me-2"></i>🚫 Danh sách yêu thích của bạn đang trống!
                                    </div>
                                `;
                            }
                        } else {
                            alert('Có lỗi xảy ra khi xóa khỏi wishlist: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi xóa khỏi wishlist.');
                    });
                });
            });
        });
    </script>
</body>
</html>