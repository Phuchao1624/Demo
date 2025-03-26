package controller_cart;

import entity.Game;
import entity.User;
import model.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

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

        int gameId;
        int quantity;

        try {
            gameId = Integer.parseInt(request.getParameter("gameId"));
            String quantityParam = request.getParameter("quantity");
            quantity = (quantityParam != null && !quantityParam.isEmpty()) ? Integer.parseInt(quantityParam) : 1;

            if (quantity <= 0) {
                throw new NumberFormatException("Quantity must be positive.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("cartMessage", "Số lượng không hợp lệ!");
            response.sendRedirect("gameDetails.jsp?id=" + request.getParameter("gameId") + "&error=Invalid input");
            return;
        }

        // Lấy thông tin game từ DAO
        Game game = DAO.getGameById(gameId);
        if (game == null) {
            session.setAttribute("cartMessage", "Game không tồn tại!");
            response.sendRedirect("gameDetails.jsp?id=" + gameId + "&error=Game not found");
            return;
        }

        // Kiểm tra số lượng tồn kho
        if (game.getStock() < quantity) {
            session.setAttribute("cartMessage", "Số lượng trong kho không đủ! Chỉ còn " + game.getStock() + " sản phẩm.");
            response.sendRedirect("gameDetails.jsp?id=" + gameId + "&error=Insufficient stock");
            return;
        }

        // Kiểm tra nếu là "Mua ngay"
        String buyNow = request.getParameter("buyNow");
        boolean isBuyNow = "true".equals(buyNow);

        // Nếu là "Mua ngay", xóa giỏ hàng trước khi thêm sản phẩm
        if (isBuyNow) {
            DAO.clearCart(user.getUserId());  // Xóa toàn bộ giỏ hàng
        }

        // Thêm sản phẩm vào giỏ hàng
        boolean success = DAO.addToCart(user.getUserId(), gameId, quantity);

        if (success) {
            session.setAttribute("cartMessage", isBuyNow ? "Đang chuyển đến thanh toán..." : "Đã thêm " + game.getTitle() + " vào giỏ hàng!");

            // Chuyển hướng
            response.sendRedirect(isBuyNow ? "checkout.jsp" : "cart.jsp");
        } else {
            session.setAttribute("cartMessage", "Thêm vào giỏ hàng thất bại!");
            response.sendRedirect("gameDetails.jsp?id=" + gameId + "&error=Add failed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to add games to the cart";
    }
}
