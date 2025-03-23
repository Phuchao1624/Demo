package controller_wishlish;

import entity.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddToWishlist", urlPatterns = {"/AddToWishlist"})
public class AddToWishlist extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String gameIdParam = request.getParameter("gameId");
        int gameId = Integer.parseInt(gameIdParam);

        // Lấy game từ DAO
        Game game = DAO.getGameById(gameId);
        if (game == null) {
            response.sendRedirect("index.jsp?error=GameNotFound");
            return;
        }

        // Lấy wishlist từ session, nếu chưa có thì tạo mới
        List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        // Kiểm tra xem game đã có trong wishlist chưa
        boolean alreadyInWishlist = wishlist.stream().anyMatch(g -> g.getGameId() == gameId);
        if (!alreadyInWishlist) {
            wishlist.add(game);
            session.setAttribute("wishlist", wishlist);
        }

        // Chuyển hướng đến wishlist.jsp
        response.sendRedirect("wishlist.jsp");
    }
}