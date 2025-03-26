package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;
public class Order {

    private int orderId;
    private int userId;
    private BigDecimal totalAmount;
    private String status;
    private Timestamp createdAt;

    public Order() {}

    public Order(int orderId, int userId, BigDecimal totalAmount, String status, Timestamp createdAt) {
        this.orderId = orderId;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", userId=" + userId + ", totalAmount=" + totalAmount + ", status=" + status + ", createdAt=" + createdAt + '}';
    }

   

    

    
    
    
}
