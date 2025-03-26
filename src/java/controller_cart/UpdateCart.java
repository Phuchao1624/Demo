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

@WebServlet(name = "UpdateCart", urlPatterns = {"/UpdateCart"})
public class UpdateCart extends HttpServlet {

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
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean success = DAO.updateCartItem(user.getUserId(), gameId, quantity);
        if (success) {
            session.setAttribute("cartMessage", "Cập nhật giỏ hàng thành công!");
        } else {
            session.setAttribute("cartMessage", "Cập nhật giỏ hàng thất bại!");
        }
        response.sendRedirect("cart.jsp");
    }
}