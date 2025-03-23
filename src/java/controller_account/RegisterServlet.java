package controller_account;

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

        // Lưu dữ liệu người dùng nhập vào request để hiển thị lại trên form
        request.setAttribute("username", username);
        request.setAttribute("email", email);

        DAO dao = new DAO();
        try {
            String result = dao.registerUser(username, email, password);

            if (result.equals("success")) {
                System.out.println("Đăng ký thành công!");
                // Nếu đăng ký thành công, chuyển hướng đến trang chủ với thông báo thành công
                response.sendRedirect("home.jsp?success=1");
            } else if (result.equals("username_exists")) {
                System.out.println("Tên đăng nhập đã tồn tại.");
                // Nếu username đã tồn tại, đặt thông báo lỗi và forward về trang đăng ký
                request.setAttribute("error", "Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (result.equals("email_exists")) {
                System.out.println("Email đã tồn tại.");
                // Nếu email đã tồn tại, đặt thông báo lỗi và forward về trang đăng ký
                request.setAttribute("error", "Email đã đăng ký. Vui lòng sử dụng email khác.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                System.out.println("Có lỗi xảy ra khi đăng ký.");
                // Nếu có lỗi khác, đặt thông báo lỗi và forward về trang đăng ký
                request.setAttribute("error", "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi hệ thống, đặt thông báo lỗi và forward về trang đăng ký
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng";
    }
}