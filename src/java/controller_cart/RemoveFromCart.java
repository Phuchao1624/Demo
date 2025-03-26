package controller_cart;

import entity.User;
import model.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RemoveFromCart", urlPatterns = {"/RemoveFromCart"})
public class RemoveFromCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int gameId = Integer.parseInt(request.getParameter("gameId"));

        boolean success = DAO.removeFromCart(user.getUserId(), gameId);
        if (success) {
            session.setAttribute("cartMessage", "Xóa sản phẩm khỏi giỏ hàng thành công!");
        } else {
            session.setAttribute("cartMessage", "Xóa sản phẩm khỏi giỏ hàng thất bại!");
        }
        response.sendRedirect("cart.jsp");
    }
}