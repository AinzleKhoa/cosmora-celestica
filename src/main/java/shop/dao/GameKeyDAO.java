/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import shop.db.DBContext;
import shop.model.GameKey;

/**
 *
 * @author HoangSang
 */
public class GameKeyDAO extends DBContext{



    public List<GameKey> findByGameDetailsId(int gameDetailsId) {
        List<GameKey> list = new ArrayList<>();
        String sql = "SELECT game_key_id, key_code FROM game_key WHERE game_details_id = ?";
        
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, gameDetailsId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int keyId = rs.getInt("game_key_id");
                    String keyCode = rs.getString("key_code");
                    list.add(new GameKey(keyId, gameDetailsId, keyCode)); 
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm game key theo ID chi tiết: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public void add(int gameDetailsId, String keyCode) throws SQLException {
        PreparedStatement ps = null;
        String query = "INSERT INTO game_key (game_details_id, key_code) VALUES (?, ?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            ps.setString(2, keyCode);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
}
