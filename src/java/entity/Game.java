package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class Game {

    private int gameId;
    private String title;
    private String description;
    private BigDecimal price;
    private Date releaseDate;
    private String developer;
    private String publisher;
    private String genre;
    private String platform;
    private int stock;
    private Timestamp createdAt;
    private String imageUrl; // 🖼️ Thêm thuộc tính imageUrl

    public Game(int gameId, String title, String description, BigDecimal price, Date releaseDate,
            String developer, String publisher, String genre, String platform, int stock,
            Timestamp createdAt, String imageUrl) {
        this.gameId = gameId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.releaseDate = releaseDate;
        this.developer = developer;
        this.publisher = publisher;
        this.genre = genre;
        this.platform = platform;
        this.stock = stock;
        this.createdAt = createdAt;
        this.imageUrl = imageUrl; // 🖼️ Gán giá trị imageUrl
    }

    // Getters và Setters
    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getDeveloper() {
        return developer;
    }

    public void setDeveloper(String developer) {
        this.developer = developer;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getImageUrl() { // 🖼️ Getter cho imageUrl
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) { // 🖼️ Setter cho imageUrl
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Game{"
                + "gameId=" + gameId
                + ", title='" + title + '\''
                + ", description='" + description + '\''
                + ", price=" + price
                + ", releaseDate=" + releaseDate
                + ", developer='" + developer + '\''
                + ", publisher='" + publisher + '\''
                + ", genre='" + genre + '\''
                + ", platform='" + platform + '\''
                + ", stock=" + stock
                + ", createdAt=" + createdAt
                + ", imageUrl='" + imageUrl + '\'' // 🖼️ Thêm imageUrl vào toString()
                + '}';
    }
}
