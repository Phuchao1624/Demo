/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;

/**
 *
 * @author ADMIN
 */
public class OrderDetail {

     private int orderDetailId;
    private int orderId;
    private int gameId;
    private int quantity;
    private BigDecimal price;
    private String gameTitle; 

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, int gameId, int quantity, BigDecimal price, String gameTitle) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.gameId = gameId;
        this.quantity = quantity;
        this.price = price;
        this.gameTitle = gameTitle;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getGameTitle() {
        return gameTitle;
    }

    public void setGameTitle(String gameTitle) {
        this.gameTitle = gameTitle;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderDetailId=" + orderDetailId + ", orderId=" + orderId + ", gameId=" + gameId + ", quantity=" + quantity + ", price=" + price + ", gameTitle=" + gameTitle + '}';
    }

    
    

}
