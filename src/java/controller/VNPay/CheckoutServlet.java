package controller.VNPay;

import entity.User;
import entity.CartItem;
import model.DAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/Checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy giỏ hàng từ database
        Map<Integer, CartItem> cartItems = DAO.getCartByUserId(user.getUserId());
        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("checkoutMessage", "Giỏ hàng trống!");
            response.sendRedirect("cart.jsp");
            return;
        }

        // Tính tổng tiền
        BigDecimal totalAmount = cartItems.values().stream()
                .map(CartItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Kiểm tra số lượng tồn kho trước khi thanh toán
        for (CartItem item : cartItems.values()) {
            if (item.getGame().getStock() < item.getQuantity()) {
                session.setAttribute("checkoutMessage", "Số lượng trong kho không đủ cho " + item.getGame().getTitle() + "! Chỉ còn " + item.getGame().getStock() + " sản phẩm.");
                response.sendRedirect("cart.jsp");
                return;
            }
        }

        // Tạo đơn hàng
        int orderId = DAO.createOrder(user.getUserId(), totalAmount);
        if (orderId == -1) {
            session.setAttribute("checkoutMessage", "Tạo đơn hàng thất bại!");
            response.sendRedirect("cart.jsp");
            return;
        }

        // Thêm chi tiết đơn hàng và cập nhật số lượng tồn kho
        boolean success = true;
        for (CartItem item : cartItems.values()) {
            // Thêm chi tiết đơn hàng
            boolean detailSuccess = DAO.createOrderDetail(orderId, item.getGame().getGameId(), item.getQuantity(), item.getGame().getPrice());
            // Cập nhật số lượng tồn kho
            boolean stockSuccess = DAO.updateGameStock(item.getGame().getGameId(), item.getQuantity());
            if (!detailSuccess || !stockSuccess) {
                success = false;
                break;
            }
        }

        if (success) {
            // Xóa giỏ hàng sau khi thanh toán thành công
            DAO.clearCart(user.getUserId());
            session.setAttribute("checkoutMessage", "Thanh toán thành công! Đơn hàng #" + orderId + " đã được tạo.");
            response.sendRedirect("orders.jsp");
        } else {
            session.setAttribute("checkoutMessage", "Thanh toán thất bại! Vui lòng thử lại.");
            response.sendRedirect("cart.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle checkout process";
    }
}