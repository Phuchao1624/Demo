package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
    System.out.println("Servlet đã nhận request!");

    // Lấy dữ liệu từ form
     String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

   

    DAO dao = new DAO();
    try {
        boolean success = DAO.registerUser(username, email, password);

        if (success) {
            System.out.println("Đăng ký thành công!");
            response.sendRedirect("home.jsp?success=1");
        } else {
            System.out.println("Email đã tồn tại hoặc có lỗi xảy ra.");
            response.getWriter().println("Email đã tồn tại hoặc có lỗi xảy ra.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Lỗi hệ thống: " + e.getMessage());
    }}

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng";
    }
}
