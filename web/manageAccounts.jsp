<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.DAO, entity.User" %>
<jsp:include page="Includes/header.jsp" />

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

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tài Khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>
