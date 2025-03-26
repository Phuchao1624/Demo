<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.DAO, entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tài Khoản</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Roboto&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/manageraccount.css">
    <link rel="stylesheet" href="CSS/header.css">
</head>
<body>
    <%
        // Kiểm tra đăng nhập
        if (session.getAttribute("acc") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Tạo đối tượng DAO và lấy danh sách tài khoản
        DAO userDAO = new DAO();
        List<User> users = userDAO.getAllUsers();
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
        <h2 class="text-center">👤 Quản lý Tài Khoản</h2>
        <hr>

        <!-- Bảng danh sách tài khoản -->
        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>ID</th>
                    <th>Tên tài khoản</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Vai trò</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhone() %></td>
                    <td><%= user.getAddress() %></td>
                    <td><%= user.getRole().equals("admin") ? "Quản trị viên" : "Người dùng" %></td>
                    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(user.getCreatedAt()) %></td>
                    <td class="text-center">
                        <!-- Button sửa -->
                        <button class="btn btn-warning btn-sm" onclick="editUser('<%= user.getUserId() %>', '<%= user.getUsername() %>', '<%= user.getEmail() %>', '<%= user.getPhone() %>', '<%= user.getAddress() %>', '<%= user.getRole() %>')">
                            ✏️ Sửa
                        </button>

                        <!-- Form xóa -->
                        <form action="DeleteUser" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?');">
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">🗑 Xóa</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Form chỉnh sửa tài khoản -->
        <div id="editForm" class="border p-3 rounded mt-4 d-none">
            <h4>✏️ Chỉnh Sửa Tài Khoản</h4>
            <form action="UpdateUser" method="post">
                <input type="hidden" id="editUserId" name="userId">
                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label">Tên tài khoản:</label>
                        <input type="text" id="editUsername" name="username" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Email:</label>
                        <input type="email" id="editEmail" name="email" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="text" id="editPhone" name="phone" class="form-control" required>
                    </div>
                </div>

                <div class="row mt-2">
                    <div class="col-md-6">
                        <label class="form-label">Địa chỉ:</label>
                        <input type="text" id="editAddress" name="address" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Vai trò:</label>
                        <select id="editRole" name="role" class="form-select">
                            <option value="user">Người dùng</option>
                            <option value="admin">Quản trị viên</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn btn-success mt-3">✅ Cập Nhật</button>
                <button type="button" class="btn btn-secondary mt-3" onclick="hideEditForm()">❌ Hủy</button>
            </form>
        </div>

        <script>
            function editUser(id, username, email, phone, address, role) {
                document.getElementById("editUserId").value = id;
                document.getElementById("editUsername").value = username;
                document.getElementById("editEmail").value = email;
                document.getElementById("editPhone").value = phone;
                document.getElementById("editAddress").value = address;
                document.getElementById("editRole").value = role;
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