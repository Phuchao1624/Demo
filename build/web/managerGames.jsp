<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.DAO, entity.Game" %>
<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("acc") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy danh sách game từ database
    List<Game> games = DAO.getAllGames();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Games</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
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
                    <% for (Game game : games) {%>
                    <tr>
                        <td><%= game.getGameId()%></td>
                        <td><%= game.getTitle()%></td>
                        <td><%= game.getGenre()%></td>
                        <td><%= game.getPrice()%> VND</td>
                        <td><%= game.getReleaseDate()%></td>
                        <td><%= game.getDeveloper()%></td>
                        <td><%= game.getPublisher()%></td>
                        <td><%= game.getPlatform()%></td>
                        <td><%= game.getStock()%></td>
                        <td class="text-center">
                            <!-- Button sửa -->
                            <button class="btn btn-warning btn-sm" onclick="editGame('<%= game.getGameId() %>', '<%= game.getTitle() %>', '<%= game.getGenre() %>', '<%= game.getPrice() %>', '<%= game.getReleaseDate() %>', '<%= game.getDeveloper() %>', '<%= game.getPublisher() %>', '<%= game.getPlatform() %>', '<%= game.getStock() %>', '<%= game.getImageUrl() %>', '<%= game.getDescription() %>')">
                                Sửa
                            </button>

                            <!-- Form xóa -->
                            <form action="DeleteGames" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa game này?');">
                                <input type="hidden" name="gameId" value="<%= game.getGameId()%>">
                                <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

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
                            <label class="form-label">Giá ($):</label>
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

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
