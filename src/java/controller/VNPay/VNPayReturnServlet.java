package controller.VNPay;

import utils.VNPayConfig;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAO;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Logger;

@WebServlet("/VNPayReturn")
public class VNPayReturnServlet extends HttpServlet {
    private DAO dao;
    private static final Logger LOGGER = Logger.getLogger(VNPayReturnServlet.class.getName());

    @Override
    public void init() throws ServletException {
        dao = new DAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");

        if (user == null) {
            LOGGER.warning("Người dùng chưa đăng nhập khi xử lý kết quả VNPay.");
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy tất cả tham số từ request
        Map<String, String> fields = new TreeMap<>();
        for (String key : request.getParameterMap().keySet()) {
            String value = request.getParameter(key);
            if (value != null && !value.isEmpty()) {
                fields.put(key, value);
            }
        }

        // Tách chữ ký bảo mật
        String vnp_SecureHash = fields.remove("vnp_SecureHash");
        String vnp_TxnRef = fields.get("vnp_TxnRef");
        String vnp_ResponseCode = fields.get("vnp_ResponseCode");

        // Tạo chuỗi hash data để kiểm tra chữ ký
        StringBuilder hashData = new StringBuilder();
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            hashData.append(entry.getKey()).append("=")
                    .append(URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8)).append("&");
        }
        hashData.setLength(hashData.length() - 1); // Xóa ký tự "&" cuối cùng

        try {
            // Kiểm tra chữ ký bảo mật
            String calculatedHash = VNPayConfig.hmacSHA512(VNPayConfig.VNP_HASH_SECRET, hashData.toString());
            if (!calculatedHash.equalsIgnoreCase(vnp_SecureHash)) {
                LOGGER.warning("Chữ ký không hợp lệ cho giao dịch: " + vnp_TxnRef);
                session.setAttribute("error", "Chữ ký không hợp lệ! Giao dịch không được xác thực.");
                response.sendRedirect("checkout.jsp");
                return;
            }

            // Kiểm tra mã phản hồi và mã đơn hàng
            if ("00".equals(vnp_ResponseCode) && vnp_TxnRef != null) {
                int orderId = Integer.parseInt(vnp_TxnRef);
                dao.updateOrderStatus(orderId, "Đã thanh toán"); // Cập nhật trạng thái đơn hàng
                dao.clearCart(user.getUserId()); // Xóa giỏ hàng sau khi thanh toán thành công
                LOGGER.info("Thanh toán thành công cho đơn hàng: " + orderId);
                session.setAttribute("checkoutMessage", "Thanh toán thành công! Mã đơn hàng: " + orderId);
                response.sendRedirect("home.jsp");
            } else {
                LOGGER.warning("Thanh toán thất bại cho đơn hàng: " + vnp_TxnRef + ". Mã lỗi: " + vnp_ResponseCode);
                session.setAttribute("error", "Thanh toán thất bại! Mã lỗi: " + vnp_ResponseCode);
                response.sendRedirect("checkout.jsp");
            }
        } catch (NumberFormatException e) {
            LOGGER.severe("Lỗi định dạng mã đơn hàng: " + vnp_TxnRef);
            session.setAttribute("error", "Lỗi: Mã đơn hàng không hợp lệ!");
            response.sendRedirect("checkout.jsp");
        } catch (Exception e) {
            LOGGER.log(java.util.logging.Level.SEVERE, "Lỗi xử lý kết quả VNPay", e);
            session.setAttribute("error", "Lỗi xử lý kết quả thanh toán VNPay.");
            response.sendRedirect("checkout.jsp");
        }
    }

    @Override
    public void destroy() {
        dao = null;
    }
}