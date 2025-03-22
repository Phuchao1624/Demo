package controller;

import entity.Transaction;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO;


import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

@WebServlet("/AddTransaction")
public class TransactionController extends HttpServlet {
    private DAO dao;

    @Override
    public void init() throws ServletException {
        dao = new DAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy thông tin từ form
        String cardNumber = request.getParameter("cardNumber");
        String transactionType = request.getParameter("transactionType");
        String amountStr = request.getParameter("amount");
        BigDecimal amount = new BigDecimal(amountStr);

        // Tạo giao dịch mới
        Transaction transaction = new Transaction();
        transaction.setUserId(user.getUserId());
        transaction.setCardNumber(cardNumber);
        transaction.setAmount(amount);
        transaction.setTransactionType(transactionType);
        transaction.setTransactionDate(new Timestamp(System.currentTimeMillis()));

        // Lưu giao dịch vào cơ sở dữ liệu
        dao.addTransaction(transaction);

        // Xóa giỏ hàng của người dùng
        dao.clearCart(user.getUserId());

        // Đặt thông báo thành công
        session.setAttribute("checkoutMessage", "Thanh toán thành công! Cảm ơn bạn đã mua hàng.");

        // Chuyển hướng về trang chính
        response.sendRedirect("home.jsp");
    }

    @Override
    public void destroy() {
        dao.close();
    }
}