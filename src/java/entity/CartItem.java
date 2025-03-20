package entity;

import java.math.BigDecimal;

public class CartItem {
    private Game game;
    private int quantity;

    public CartItem(Game game, int quantity) {
        this.game = game;
        this.quantity = quantity;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalPrice() {
        return game.getPrice().multiply(BigDecimal.valueOf(quantity));

    }
}
