/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import shop.db.DBContext;

/**
 *
 * @author HoangSang
 */
public class GameDetailsDAO extends DBContext {

     /**
     * [PHƯƠNG THỨC QUAN TRỌNG]
     * Lấy thông tin chi tiết của một game bằng ID, sử dụng một Connection đã có sẵn.
     * Method này rất quan trọng để sử dụng bên trong một transaction của DAO khác (như ProductDAO).
     * @param gameDetailsId ID của chi tiết game cần tìm.
     * @param conn Connection đã được thiết lập để sử dụng.
     * @return Đối tượng GameDetails hoặc null nếu không tìm thấy.
     * @throws SQLException
     */
    public GameDetails getGameDetailsById(int gameDetailsId, Connection conn) throws SQLException {
        GameDetails details = null;
        String sql = "SELECT * FROM game_details WHERE game_details_id = ?";
        
        // Không dùng try-with-resources cho Connection ở đây vì nó được truyền vào và quản lý từ bên ngoài.
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, gameDetailsId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    details = new GameDetails();
                    details.setGameDetailsId(rs.getInt("game_details_id"));
                    details.setDeveloper(rs.getString("developer"));
                    details.setGenre(rs.getString("genre"));
                    details.setReleaseDate(rs.getDate("release_date"));
                }
            }
        }
        return details;
    }
    
    /**
     * [PHƯƠ-NG THỨC PHỤ]
     * Lấy thông tin chi tiết của một game bằng ID (tự tạo và đóng connection).
     * Dùng khi bạn chỉ muốn lấy thông tin game details một cách độc lập.
     * @param gameDetailsId ID của chi tiết game cần tìm.
     * @return Đối tượng GameDetails hoặc null nếu không tìm thấy.
     */
    public GameDetails getGameDetailsById(int gameDetailsId) {
        GameDetails details = null;
        String sql = "SELECT * FROM game_details WHERE game_details_id = ?";
        
        try(Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, gameDetailsId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    details = new GameDetails();
                    details.setGameDetailsId(rs.getInt("game_details_id"));
                    details.setDeveloper(rs.getString("developer"));
                    details.setGenre(rs.getString("genre"));
                    details.setReleaseDate(rs.getDate("release_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }

}
