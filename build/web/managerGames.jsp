<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.DAO, entity.Game" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Games</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/managergames.css">
    <link rel="stylesheet" href="CSS/header.css">
</head>
<body>
    <%
        // Kiểm tra đăng nhập
        if (session.getAttribute("acc") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Lấy danh sách game từ database
        List<Game> games = DAO.getAllGames();
    %>

    <!-- Navbar từ header.jsp -->
    <c:set var="acc" value="${sessionScope.acc}" />
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container-fluid">
            <!-- Logo -->
            <a class="navbar-brand text-warning fw-bold" href="Home">
                <i class="fas fa-gamepad"></i> GameStore
            </a>

            <!-- Toggle button for mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
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
                            <a class="nav-link" href="orderDetails.jsp"><i class="fas fa-history"></i> Lịch sử mua</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">
                                <i class="fas fa-shopping-cart"></i> Giỏ hàng 
                                <span class="badge bg-warning text-dark rounded-pill">${sessionScope.cartSize}</span>
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
                <form class="d-flex my-2 my-lg-0" action="search.jsp" method="GET">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm game..." aria-label="Search">
                    <button class="btn btn-outline-warning" type="submit" aria-label="Search">
                        <i class="fas fa-search"></i>
                    </button>
                </form>

                <!-- User dropdown -->
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty acc}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-light" href="#" id="userDropdown" role="button" 
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-user"></i> ${acc.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user-circle"></i> Hồ sơ</a></li>
                                    <li><a class="dropdown-item" href="orderDetails.jsp"><i class="fas fa-shopping-bag"></i> Đơn hàng</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                                </ul>
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

    <!-- Nội dung chính -->
    <div class="container mt-4">
        <h2 class="text-center">🎮 Quản lý Games</h2>

        <!-- Form thêm game -->
        <form action="AddGames" method="post" class="mb-4 p-3 border rounded">
            <h4>📌 Thêm Game</h4>
            <div class="row">
                <div class="col-md-4">
                    <label class="form-label">Tên game:</label>
                    <input type="text" name="title" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Thể loại:</label>
                    <input type="text" name="genre" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Giá (VND):</label>
                    <input type="number" name="price" class="form-control" required>
                </div>
            </div>

            <div class="row mt-2">
                <div class="col-md-4">
                    <label class="form-label">Ngày phát hành:</label>
                    <input type="date" name="releaseDate" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Nhà phát triển:</label>
                    <input type="text" name="developer" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Tồn kho:</label>
                    <input type="number" name="stock" class="form-control" required>
                </div>
            </div>

            <div class="row mt-2">
                <div class="col-md-6">
                    <label class="form-label">Hình ảnh (URL):</label>
                    <input type="text" name="imageUrl" class="form-control" id="imageUrlInput" required oninput="previewImage()">
                </div>
                <div class="col-md-6 text-center">
                    <label class="form-label">Xem trước:</label>
                    <img id="imagePreview" src="" alt="Ảnh game" class="img-thumbnail d-none" style="max-width: 150px; max-height: 150px;">
                </div>
            </div>

            <button type="submit" class="btn btn-primary mt-3">Thêm Game</button>
        </form>

        <script>
            function previewImage() {
                let imageUrl = document.getElementById("imageUrlInput").value;
                let preview = document.getElementById("imagePreview");

                if (imageUrl) {
                    preview.src = imageUrl;
                    preview.classList.remove("d-none");
                } else {
                    preview.classList.add("d-none");
                }
            }
        </script>

        <hr>

        <!-- Bảng danh sách game -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Tên game</th>
                        <th>Thể loại</th>
                        <th>Giá (VND)</th>
                        <th>Ngày phát hành</th>
                        <th>Nhà phát triển</th>
                        <th>Nhà phát hành</th>
                        <th>Nền tảng</th>
                        <th>Tồn kho</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Game game : games) { %>
                    <tr>
                        <td><%= game.getGameId() %></td>
                        <td><%= game.getTitle() %></td>
                        <td><%= game.getGenre() %></td>
                        <td><%= game.getPrice() %> VND</td>
                        <td><%= game.getReleaseDate() %></td>
                        <td><%= game.getDeveloper() %></td>
                        <td><%= game.getPublisher() %></td>
                        <td><%= game.getPlatform() %></td>
                        <td><%= game.getStock() %></td>
                        <td class="text-center">
                            <button class="btn btn-warning btn-sm" onclick="editGame('<%= game.getGameId() %>', '<%= game.getTitle() %>', '<%= game.getGenre() %>', '<%= game.getPrice() %>', '<%= game.getReleaseDate() %>', '<%= game.getDeveloper() %>', '<%= game.getPublisher() %>', '<%= game.getPlatform() %>', '<%= game.getStock() %>', '<%= game.getImageUrl() %>', '<%= game.getDescription() %>')">
                                Sửa
                            </button>
                            <form action="DeleteGames" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa game này?');">
                                <input type="hidden" name="gameId" value="<%= game.getGameId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Form chỉnh sửa game -->
        <div id="editForm" class="border p-3 rounded mt-4 d-none">
            <h4>✏️ Chỉnh Sửa Game</h4>
            <form action="UpdateGame" method="post">
                <input type="hidden" id="editGameId" name="gameId">
                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label">Tên game:</label>
                        <input type="text" id="editTitle" name="title" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Thể loại:</label>
                        <input type="text" id="editGenre" name="genre" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Giá (VND):</label>
                        <input type="number" id="editPrice" name="price" class="form-control" step="0.01" required>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-4">
                        <label class="form-label">Ngày phát hành:</label>
                        <input type="date" id="editReleaseDate" name="releaseDate" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Nhà phát triển:</label>
                        <input type="text" id="editDeveloper" name="developer" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Nhà phát hành:</label>
                        <input type="text" id="editPublisher" name="publisher" class="form-control" required>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-4">
                        <label class="form-label">Nền tảng:</label>
                        <input type="text" id="editPlatform" name="platform" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tồn kho:</label>
                        <input type="number" id="editStock" name="stock" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">URL hình ảnh:</label>
                        <input type="text" id="editImageUrl" name="imageUrl" class="form-control">
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-12">
                        <label class="form-label">Mô tả:</label>
                        <textarea id="editDescription" name="description" class="form-control" rows="3" required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-success mt-3">Cập Nhật</button>
                <button type="button" class="btn btn-secondary mt-3" onclick="hideEditForm()">Hủy</button>
            </form>
        </div>

        <script>
            function editGame(id, title, genre, price, releaseDate, developer, publisher, platform, stock, imageUrl, description) {
                document.getElementById("editGameId").value = id;
                document.getElementById("editTitle").value = title;
                document.getElementById("editGenre").value = genre;
                document.getElementById("editPrice").value = price;
                document.getElementById("editReleaseDate").value = releaseDate;
                document.getElementById("editDeveloper").value = developer;
                document.getElementById("editPublisher").value = publisher;
                document.getElementById("editPlatform").value = platform;
                document.getElementById("editStock").value = stock;
                document.getElementById("editImageUrl").value = imageUrl;
                document.getElementById("editDescription").value = description;
                document.getElementById("editForm").classList.remove("d-none");
            }

            function hideEditForm() {
                document.getElementById("editForm").classList.add("d-none");
            }
        </script>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="JS/header.js"></script>
</body>
</html>