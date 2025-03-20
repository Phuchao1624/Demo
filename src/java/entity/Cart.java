package entity;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void addItem(Game game, int quantity) {
        items.putIfAbsent(game.getGameId(), new CartItem(game, 0));
        items.get(game.getGameId()).setQuantity(items.get(game.getGameId()).getQuantity() + quantity);
    }

    public void updateItem(int gameId, int quantity) {
        if (items.containsKey(gameId)) {
            if (quantity > 0) {
                items.get(gameId).setQuantity(quantity);
            } else {
                items.remove(gameId);
            }
        }
    }

    public void removeItem(int gameId) {
        items.remove(gameId);
    }

    public BigDecimal getTotalPrice() {
    return items.values().stream()
        .map(CartItem::getTotalPrice) // Lấy giá từng item (BigDecimal)
        .reduce(BigDecimal.ZERO, BigDecimal::add); // Cộng tổng giá
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public void clear() {
        items.clear();
    }
}
