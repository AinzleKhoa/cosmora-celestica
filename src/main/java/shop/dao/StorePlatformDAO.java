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
import shop.model.StorePlatform;

/**
 *
 * @author HoangSang
 */
public class StorePlatformDAO extends DBContext{

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<StorePlatform> getAllPlatforms() throws SQLException {
        List<StorePlatform> list = new ArrayList<>();
        String query = "SELECT DISTINCT platform_id, store_OS_name FROM store_platform"; 
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new StorePlatform(rs.getInt("platform_id"), rs.getString("store_OS_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    public List<StorePlatform> findByGameDetailsId(int gameDetailsId) throws SQLException {
        List<StorePlatform> list = new ArrayList<>();
        String query = "SELECT platform_id, store_OS_name, game_details_id FROM store_platform WHERE game_details_id = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            rs = ps.executeQuery();
            while (rs.next()) {
                StorePlatform sp = new StorePlatform();
                sp.setPlatformId(rs.getInt("platform_id"));
                sp.setStoreOSName(rs.getString("store_OS_name"));
                sp.setGameDetailsId(rs.getInt("game_details_id"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return list;
    }

    public void deleteByGameDetailsId(int gameDetailsId) throws SQLException {
        String query = "DELETE FROM store_platform WHERE game_details_id = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    public void add(int gameDetailsId, int platformId) throws SQLException {
        
        String query = "INSERT INTO store_platform (game_details_id, platform_id, store_OS_name) VALUES (?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            ps.setInt(2, platformId);
            ps.setString(3, "Platform " + platformId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
}
