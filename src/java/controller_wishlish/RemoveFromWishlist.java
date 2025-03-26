package controller_wishlish;

import entity.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "RemoveFromWishlist", urlPatterns = {"/RemoveFromWishlist"})
@MultipartConfig // Thêm annotation này để xử lý multipart/form-data
public class RemoveFromWishlist extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập response trả về dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            String gameIdParam = request.getParameter("gameId");
            int gameId = Integer.parseInt(gameIdParam);

            // Lấy wishlist từ session
            List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
            if (wishlist == null) {
                out.write("{\"success\": false, \"message\": \"Danh sách yêu thích trống.\"}");
                return;
            }

            // Xóa game khỏi wishlist
            boolean removed = wishlist.removeIf(game -> game.getGameId() == gameId);
            if (!removed) {
                out.write("{\"success\": false, \"message\": \"Game không tồn tại trong danh sách yêu thích.\"}");
                return;
            }

            // Cập nhật wishlist trong session
            session.setAttribute("wishlist", wishlist);

            // Trả về phản hồi JSON thành công
            out.write("{\"success\": true, \"message\": \"Đã xóa khỏi danh sách yêu thích.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }
}