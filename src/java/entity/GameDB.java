//package entity;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import model.DatabaseInfo;
//import entity.Game;
//
//public class GameDB {
//
//    public static Connection getConnect() {
//        try {
//            Class.forName(DatabaseInfo.DRIVERNAME);
//            return DriverManager.getConnection(DatabaseInfo.DBURL, DatabaseInfo.USERDB, DatabaseInfo.PASSDB);
//        } catch (ClassNotFoundException | SQLException e) {
//            System.out.println("Error: " + e);
//        }
//        return null;
//    }
//
//    public static List<Game> getAllGames() {
//        List<Game> games = new ArrayList<>();
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Games");
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                games.add(new Game(
//                    rs.getInt("game_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getBigDecimal("price"),
//                    rs.getInt("category_id"),
//                    rs.getString("image_url")
//                ));
//            }
//        } catch (Exception ex) {
//            Logger.getLogger(GameDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return games;
//    }
//
//    public static Game getGameById(int gameId) {
//        Game game = null;
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement("SELECT * FROM Games WHERE game_id = ?");
//            stmt.setInt(1, gameId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                game = new Game(
//                    rs.getInt("game_id"),
//                    rs.getString("title"),
//                    rs.getString("description"),
//                    rs.getBigDecimal("price"),
//                    rs.getInt("category_id"),
//                    rs.getString("image_url")
//                );
//            }
//        } catch (Exception ex) {
//            Logger.getLogger(GameDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return game;
//    }
//
//    public static boolean addGame(Game game) {
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement(
//                "INSERT INTO Games (title, description, price, category_id, image_url) VALUES (?, ?, ?, ?, ?)"
//            );
//            stmt.setString(1, game.getTitle());
//            stmt.setString(2, game.getDescription());
//            stmt.setBigDecimal(3, game.getPrice());
//            stmt.setInt(4, game.getCategoryId());
//            stmt.setString(5, game.getImageUrl());
//
//            return stmt.executeUpdate() > 0;
//        } catch (Exception ex) {
//            Logger.getLogger(GameDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//
//    public static boolean updateGame(Game game) {
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement(
//                "UPDATE Games SET title=?, description=?, price=?, category_id=?, image_url=? WHERE game_id=?"
//            );
//            stmt.setString(1, game.getTitle());
//            stmt.setString(2, game.getDescription());
//            stmt.setBigDecimal(3, game.getPrice());
//            stmt.setInt(4, game.getCategoryId());
//            stmt.setString(5, game.getImageUrl());
//            stmt.setInt(6, game.getGameId());
//
//            return stmt.executeUpdate() > 0;
//        } catch (Exception ex) {
//            Logger.getLogger(GameDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//
//    public static boolean deleteGame(int gameId) {
//        try (Connection con = getConnect()) {
//            PreparedStatement stmt = con.prepareStatement("DELETE FROM Games WHERE game_id = ?");
//            stmt.setInt(1, gameId);
//            return stmt.executeUpdate() > 0;
//        } catch (Exception ex) {
//            Logger.getLogger(GameDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//}
