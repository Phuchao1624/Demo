package controller_game;

import entity.Game;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GameCategoryServlet", urlPatterns = {"/category"})
public class GameCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryIdStr = request.getParameter("categoryId");
        System.out.println("Received categoryId: " + categoryIdStr);

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            System.out.println("categoryId is null or empty, redirecting to home.jsp");
                response.sendRedirect("home.jsp");
            return;
        }

        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid categoryId format: " + categoryIdStr);
            response.sendRedirect("home.jsp");
            return;
        }

        DAO dao = new DAO();
        List<Game> gamesByCategory = dao.getGamesByCategory(categoryId);
        System.out.println("Games retrieved: " + (gamesByCategory != null ? gamesByCategory.size() : "null"));

        if (gamesByCategory == null || gamesByCategory.isEmpty()) {
            System.out.println("No games found for categoryId: " + categoryId);
            request.setAttribute("message", "Không tìm thấy game nào trong danh mục này.");
        } else {
            System.out.println("Setting games attribute with " + gamesByCategory.size() + " games");
            request.setAttribute("games", gamesByCategory);
        }
        request.setAttribute("selectedCategoryId", categoryId);

        request.getRequestDispatcher("category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Gọi lại doGet nếu cần xử lý POST
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display games by category";
    }
}