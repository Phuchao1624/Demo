package controller_VNPay;

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
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Logger;

@WebServlet("/AddTransaction")
public class TransactionController extends HttpServlet {

    private DAO dao;
    private static final Logger LOGGER = Logger.getLogger(TransactionController.class.getName());

    @Override
    public void init() throws ServletException {
        dao = new DAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");

        if (user == null) {
            LOGGER.warning("Người dùng chưa đăng nhập. Chuyển hướng đến trang đăng nhập.");
            response.sendRedirect("login.jsp");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        String amountStr = request.getParameter("amount");

        LOGGER.info("Phương thức thanh toán: " + paymentMethod);
        LOGGER.info("Số tiền: " + amountStr);

        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                LOGGER.warning("Số tiền không hợp lệ: " + amountStr);
                session.setAttribute("error", "Số tiền không hợp lệ!");
                response.sendRedirect("checkout.jsp");
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.severe("Lỗi định dạng số tiền: " + amountStr);
            session.setAttribute("error", "Số tiền không hợp lệ!");
            response.sendRedirect("checkout.jsp");
            return;
        }

        int orderId = dao.getLatestOrderId(user.getUserId());
        if (orderId <= 0) {
            LOGGER.severe("Không tìm thấy đơn hàng hợp lệ cho userID: " + user.getUserId());
            session.setAttribute("error", "Không tìm thấy đơn hàng hợp lệ!");
            response.sendRedirect("checkout.jsp");
            return;
        }

        LOGGER.info("Bắt đầu xử lý thanh toán cho Order ID: " + orderId);

        if ("VNPay".equalsIgnoreCase(paymentMethod)) {
            try {
                // Nhân với 1000: 10 lần để chuyển đơn vị + 100 lần cho VNPay
                long amountInVND = amount.multiply(BigDecimal.valueOf(100000)).longValue();

                // Các tham số VNPay
                String vnp_Version = "2.1.0";
                String vnp_Command = "pay";
                String vnp_TmnCode = VNPayConfig.VNP_TMN_CODE;
                String vnp_CurrCode = "VND";
                String vnp_TxnRef = String.valueOf(orderId);
                String vnp_OrderInfo = "Thanh toan don hang " + orderId;
                String vnp_OrderType = "other";
                String vnp_Locale = "vn";
                String vnp_ReturnUrl = VNPayConfig.VNP_RETURN_URL;
                String vnp_IpAddr = request.getRemoteAddr();
                String vnp_CreateDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

                // Tạo map chứa các tham số
                Map<String, String> vnp_Params = new TreeMap<>();
                vnp_Params.put("vnp_Version", vnp_Version);
                vnp_Params.put("vnp_Command", vnp_Command);
                vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(amountInVND));
                vnp_Params.put("vnp_CurrCode", vnp_CurrCode);
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
                vnp_Params.put("vnp_OrderType", vnp_OrderType);
                vnp_Params.put("vnp_Locale", vnp_Locale);
                vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
                vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
                vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                // Tạo chuỗi hash data
                StringBuilder hashData = new StringBuilder();
                for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
                    hashData.append(entry.getKey()).append("=")
                            .append(URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8)).append("&");
                }
                hashData.setLength(hashData.length() - 1);

                // Tạo chữ ký bảo mật (Secure Hash)
                String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.VNP_HASH_SECRET, hashData.toString());
                vnp_Params.put("vnp_SecureHash", vnp_SecureHash);

                // Tạo URL thanh toán
                StringBuilder paymentUrl = new StringBuilder(VNPayConfig.VNP_URL);
                paymentUrl.append("?");
                for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
                    paymentUrl.append(entry.getKey()).append("=")
                            .append(URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8)).append("&");
                }
                paymentUrl.setLength(paymentUrl.length() - 1);

                LOGGER.info("Chuyển hướng đến VNPay: " + paymentUrl.toString());
                response.sendRedirect(paymentUrl.toString());

            } catch (Exception e) {
                LOGGER.log(java.util.logging.Level.SEVERE, "Lỗi xử lý thanh toán VNPay", e);
                session.setAttribute("error", "Lỗi xử lý thanh toán VNPay.");
                response.sendRedirect("checkout.jsp");
            }
        } else {
            dao.updateOrderStatus(orderId, "completed");
            dao.clearCart(user.getUserId());
            session.removeAttribute("orderId");
            session.setAttribute("orderId", null);
            session.setAttribute("checkoutMessage", "Thanh toán thành công!");

            response.sendRedirect("cart.jsp");

        }
    }

    @Override
    public void destroy() {
        dao = null;
    }
}
