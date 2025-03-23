package controller_wishlish;

import entity.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "RemoveFromWishlist", urlPatterns = {"/RemoveFromWishlist"})
public class RemoveFromWishlist extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gameIdParam = request.getParameter("gameId");
        int gameId = Integer.parseInt(gameIdParam);

        // Lấy wishlist từ session
        List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
        if (wishlist != null) {
            // Xóa game khỏi wishlist
            wishlist.removeIf(game -> game.getGameId() == gameId);
            session.setAttribute("wishlist", wishlist);
        }

        // Chuyển hướng lại wishlist.jsp
        response.sendRedirect("wishlist.jsp");
    }
}