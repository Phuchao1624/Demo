package controller_VNPay;

import utils.VNPayConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/VNPayServlet")
public class VNPayServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(VNPayServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String vnp_IpAddr = request.getRemoteAddr();
            String amountParam = request.getParameter("amount");

            // Kiểm tra số tiền có hợp lệ không
            if (amountParam == null || !amountParam.matches("\\d+")) {
                LOGGER.severe("Số tiền không hợp lệ.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền không hợp lệ.");
                return;
            }

            long amount = Long.parseLong(amountParam);
            if (amount <= 0) {
                LOGGER.severe("Số tiền phải lớn hơn 0.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền phải lớn hơn 0.");
                return;
            }

            // Lấy mã đơn hàng từ hệ thống
            int orderId = (int) (System.currentTimeMillis() % 1000000); // Tạo mã đơn hàng ngẫu nhiên (hoặc lấy từ DB)
            LOGGER.info("Processing payment for Order ID: " + orderId);

            // Tạo URL thanh toán VNPay
            String paymentUrl = VNPayConfig.generatePaymentUrl(orderId, vnp_IpAddr, amount);

            if (paymentUrl == null || paymentUrl.isEmpty()) {
                LOGGER.severe("Lỗi: URL thanh toán VNPay không hợp lệ.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tạo URL thanh toán.");
                return;
            }

            LOGGER.info("Redirecting to VNPay: " + paymentUrl);
            response.sendRedirect(paymentUrl);
        } catch (Exception e) {
            LOGGER.severe("Lỗi xử lý thanh toán VNPay: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý thanh toán VNPay.");
        }
    }
}
