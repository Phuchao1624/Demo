package utils;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;

public class VNPayConfig {

    public static final String VNP_TMN_CODE = "4M9XM15R";
    public static final String VNP_HASH_SECRET = "LQ9VH1TGQTLZ9Y1N4PK13NZ1WRPA9LLN";
    public static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static final String VNP_RETURN_URL = "http://localhost:8080/ProjectGame/VNPayReturn";

    public static String generatePaymentUrl(int orderId, String ipAddress, long amount) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("vnp_Version", "2.1.0");
            params.put("vnp_Command", "pay");
            params.put("vnp_TmnCode", VNP_TMN_CODE);
            params.put("vnp_Amount", String.valueOf(amount));
            params.put("vnp_CurrCode", "VND");
            params.put("vnp_TxnRef", String.valueOf(orderId));
            params.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
            params.put("vnp_OrderType", "other");
            params.put("vnp_Locale", "vn");
            params.put("vnp_ReturnUrl", VNP_RETURN_URL);
            params.put("vnp_IpAddr", ipAddress);
            params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

            // Tạo chuỗi hash data (encode tất cả giá trị)
            String hashData = params.entrySet().stream()
                    .sorted(Map.Entry.comparingByKey())
                    .map(entry -> entry.getKey() + "=" + URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8))
                    .collect(Collectors.joining("&"));

            // Tạo chữ ký bảo mật
            String secureHash = hmacSHA512(VNP_HASH_SECRET, hashData);

            // Tạo URL thanh toán
            String query = hashData + "&vnp_SecureHash=" + secureHash;
            return VNP_URL + "?" + query;

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo URL thanh toán VNPay", e);
        }
    }

    public static String hmacSHA512(String key, String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            mac.init(secretKeySpec);
            byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hash);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi tạo chữ ký HMAC SHA512", e);
        }
    }

    private static String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}