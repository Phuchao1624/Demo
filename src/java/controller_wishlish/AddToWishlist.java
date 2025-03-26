package controller_wishlish;

import entity.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddToWishlist", urlPatterns = {"/AddToWishlist"})
@MultipartConfig // Thêm annotation này để xử lý multipart/form-data
public class AddToWishlist extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập response trả về dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            String gameIdParam = request.getParameter("gameId"); // Vẫn sử dụng getParameter để lấy gameId
            int gameId = Integer.parseInt(gameIdParam);

            // Lấy game từ DAO
            Game game = DAO.getGameById(gameId);
            if (game == null) {
                out.write("{\"success\": false, \"message\": \"Game không tồn tại.\"}");
                return;
            }

            // Lấy wishlist từ session, nếu chưa có thì tạo mới
            List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
            if (wishlist == null) {
                wishlist = new ArrayList<>();
            }

            // Kiểm tra xem game đã có trong wishlist chưa
            boolean alreadyInWishlist = wishlist.stream().anyMatch(g -> g.getGameId() == gameId);
            if (alreadyInWishlist) {
                out.write("{\"success\": false, \"message\": \"Game đã có trong danh sách yêu thích.\"}");
                return;
            }

            // Thêm game vào wishlist
            wishlist.add(game);
            session.setAttribute("wishlist", wishlist);

            // Trả về phản hồi JSON thành công
            out.write("{\"success\": true, \"message\": \"Đã thêm vào danh sách yêu thích.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }
}