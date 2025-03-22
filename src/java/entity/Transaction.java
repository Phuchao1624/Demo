package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaction {
    private int id;
    private int userId;
    private String cardNumber;
    private Timestamp transactionDate;
    private BigDecimal amount;
    private String transactionType;

    // Constructor mặc định
    public Transaction() {
    }

    // Constructor đầy đủ
    public Transaction(int id, int userId, String cardNumber, Timestamp transactionDate, BigDecimal amount, String transactionType) {
        this.id = id;
        this.userId = userId;
        this.cardNumber = cardNumber;
        this.transactionDate = transactionDate;
        this.amount = amount;
        this.transactionType = transactionType;
    }

    // Getter và Setter cho id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter và Setter cho userId
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getter và Setter cho cardNumber
    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    // Getter và Setter cho transactionDate
    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }

    // Getter và Setter cho amount
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    // Getter và Setter cho transactionType
    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }
}