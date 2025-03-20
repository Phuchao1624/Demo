<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, entity.Transaction, model.DAO" %>

<jsp:include page="Includes/header.jsp" />

<%
    // Kiểm tra nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
    Object acc = session.getAttribute("acc");
    if (acc == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy danh sách giao dịch từ cơ sở dữ liệu
    List<Transaction> transactions = DAO.getAllTransactions();
    request.setAttribute("transactions", transactions);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Giao Dịch</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">📄 Quản lý Giao Dịch</h2>

        <!-- Form thêm giao dịch mới -->
        <form action="AddTransaction" method="post" class="mb-4">
            <div class="row">
                <div class="col-md-3">
                    <label class="form-label">Số thẻ:</label>
                    <input type="text" name="cardNumber" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Số tiền:</label>
                    <input type="number" name="amount" step="0.01" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Loại giao dịch:</label>
                    <select name="transactionType" class="form-control">
                        <option value="withdrawal">Rút tiền</option>
                        <option value="deposit">Nạp tiền</option>
                        <option value="transfer">Chuyển khoản</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary">Thêm Giao Dịch</button>
                </div>
            </div>
        </form>

        <hr>

        <!-- Bảng danh sách giao dịch -->
        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>ID</th>
                    <th>Số thẻ</th>
                    <th>Ngày giao dịch</th>
                    <th>Số tiền</th>
                    <th>Loại giao dịch</th>
                </tr>
            </thead>
            <tbody>
                <% for (Transaction t : transactions) { %>
                <tr>
                    <td><%= t.getId() %></td>
                    <td><%= t.getCardNumber() %></td>
                    <td><%= t.getTransactionDate() %></td>
                    <td><%= t.getAmount() %></td>
                    <td><%= t.getTransactionType() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
