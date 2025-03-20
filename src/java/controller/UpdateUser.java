package controller;

import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAO;

@WebServlet(name = "UpdateUser", urlPatterns = {"/UpdateUser"})
public class UpdateUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận dữ liệu tiếng Việt đúng
        response.setContentType("text/html;charset=UTF-8");

        try {
            // 🔹 1. Lấy `userId` và kiểm tra lỗi
            int userId;
            try {
                userId = Integer.parseInt(request.getParameter("userId"));
            } catch (NumberFormatException ex) {
                response.sendRedirect("manageAccounts.jsp?error=invalid_userId");
                return;
            }

            // 🔹 2. Lấy thông tin người dùng từ database
            DAO userDAO = new DAO();
            User existingUser = userDAO.getUserById(userId);

            if (existingUser == null) {
                response.sendRedirect("manageAccounts.jsp?error=user_not_found");
                return;
            }

            // 🔹 3. Nhận thông tin từ request
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // Mật khẩu mới (nếu có)
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            System.out.println("🔍 User ID nhận được từ form: " + request.getParameter("userId"));

            // 🔹 4. Nếu mật khẩu trống, giữ nguyên mật khẩu cũ
            if (password == null || password.isEmpty()) {
                password = existingUser.getPassword();
            } else {
                // TODO: Hash mật khẩu nếu cần
            }

            // 🔹 5. Tạo đối tượng `User` với dữ liệu mới
            User user = new User(userId, username, email, password, phone, address, role, null);

            // 🔹 6. Gọi `updateUser()` để cập nhật database
            boolean success = userDAO.updateUser(user);

            if (success) {
                response.sendRedirect("manageAccounts.jsp?success=update");
            } else {
                response.sendRedirect("manageAccounts.jsp?error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageAccounts.jsp?error=exception&message=" + e.getMessage());
        }
    }
}
