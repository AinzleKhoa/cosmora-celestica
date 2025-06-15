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
import shop.model.OperatingSystem;

/**
 *
 * @author HoangSang
 */
public class OperatingSystemDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<OperatingSystem> getAllOperatingSystems() throws SQLException {
        List<OperatingSystem> list = new ArrayList<>();
        String query = "SELECT DISTINCT os_id, os_name FROM operating_system";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OperatingSystem(rs.getInt("os_id"), rs.getString("os_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<OperatingSystem> findByGameDetailsId(int gameDetailsId) throws SQLException {
        List<OperatingSystem> list = new ArrayList<>();
        String query = "SELECT os_id, os_name, game_details_id FROM operating_system WHERE game_details_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OperatingSystem os = new OperatingSystem();
                os.setOsId(rs.getInt("os_id"));
                os.setOsName(rs.getString("os_name"));
                os.setGameDetailsId(rs.getInt("game_details_id"));
                list.add(os);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public void deleteByGameDetailsId(int gameDetailsId) throws SQLException {
        String query = "DELETE FROM operating_system WHERE game_details_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void add(int gameDetailsId, int osId) throws SQLException {
        String query = "INSERT INTO operating_system (game_details_id, os_id, os_name) VALUES (?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, gameDetailsId);
            ps.setInt(2, osId);
            ps.setString(3, "OS " + osId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
