package entity;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class Transaction {

    private int transactionId;
    private Integer orderId;  // Đổi từ int → Integer để hỗ trợ NULL
    private int userId;
    private double amount;
    private String paymentStatus;
    private String paymentMethod;
    private String transactionCode;
    private Date transactionDate;

    // Constructor không tham số
    public Transaction() {
    }

    // Constructor đầy đủ tham số
    public Transaction(int transactionId, Integer orderId, int userId, double amount,
            String paymentStatus, String paymentMethod, String transactionCode,
            Date transactionDate) {
        this.transactionId = transactionId;
        this.orderId = orderId;
        this.userId = userId;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
        this.transactionCode = transactionCode;
        this.transactionDate = transactionDate;
    }

    // Getter và Setter
    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public Integer getOrderId() {
        return (this.orderId != null) ? this.orderId : 0;
    }

    public void setOrderId(Integer orderId) {  // Hỗ trợ giá trị NULL
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Số tiền không được âm!");
        }
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        if (!paymentStatus.matches("pending|completed|failed|refunded")) {
            throw new IllegalArgumentException("Trạng thái thanh toán không hợp lệ!");
        }
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        List<String> validMethods = Arrays.asList("VNPay", "Momo", "Bank Transfer", "Credit Card");

        if (paymentMethod == null || !validMethods.contains(paymentMethod)) {
            throw new IllegalArgumentException("Phương thức thanh toán không hợp lệ!");
        }

        this.paymentMethod = paymentMethod;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    // Phương thức hiển thị thông tin giao dịch
    @Override
    public String toString() {
        return "Transaction{"
                + "transactionId=" + transactionId
                + ", orderId=" + orderId
                + ", userId=" + userId
                + ", amount=" + amount
                + ", paymentStatus='" + paymentStatus + '\''
                + ", paymentMethod='" + paymentMethod + '\''
                + ", transactionCode='" + transactionCode + '\''
                + ", transactionDate=" + transactionDate
                + '}';
    }
}
