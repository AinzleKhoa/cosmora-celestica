/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import shop.db.DBContext;
import shop.model.Staff;
import java.util.logging.Logger;
import shop.controller.StaffServlet;

/**
 *
 * @author VICTUS
 */
public class StaffDAO extends DBContext {

    public ArrayList<Staff> getList(int currentPage) {
        ArrayList<Staff> staffs = new ArrayList<>();
        String query = "SELECT * FROM staff "
                + "ORDER BY staff_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        Object[] params = {
            (currentPage - 1) * StaffServlet.PAGE_SIZE,
            StaffServlet.PAGE_SIZE
        };

        try ( ResultSet rs = execSelectQuery(query, params)) {
            while (rs.next()) {
                staffs.add(new Staff(
                        rs.getInt("staff_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("phone"),
                        rs.getString("role"),
                        rs.getDate("date_of_birth"),
                        rs.getString("avatar_url")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return staffs;
    }

    public int create(Staff staff) {
        try {
            String sql
                    = "INSERT INTO staff (\n"
                    + "    username,\n"
                    + "    email,\n"
                    + "    password_hash,\n"
                    + "    phone,\n"
                    + "    role,\n"
                    + "    date_of_birth,\n"
                    + "    avatar_url\n"
                    + ") VALUES (?, ?, ?, ?, ?, ?, ?)";
            Object[] params = {
                staff.getUsername(),
                staff.getEmail(),
                staff.getPasswordHash(),
                staff.getPhone(),
                staff.getRole(),
                staff.getDateOfBirth(),
                staff.getAvatarUrl()};
            return execQuery(sql, params);
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Staff getOneById(int id) {
        try {
            String query = "SELECT * FROM staff \n"
                    + "WHERE staff_id=  ?";
            Object params[] = {id};
            ResultSet rs = execSelectQuery(query, params);

            if (rs.next()) {

                return new Staff(
                        rs.getInt("staff_id"), // staff_id
                        rs.getString("username"), // username
                        rs.getString("email"), // email
                        rs.getString("password_hash"), // password_hash
                        rs.getString("phone"), // phone
                        rs.getString("role"), // role
                        rs.getDate("date_of_birth"), // date_of_birth
                        rs.getString("avatar_url") // avatar_url
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Staff getOneByEmail(String email) {
        try {
            String query = "SELECT * FROM staff \n"
                    + "WHERE email=  ?";
            Object params[] = {email};
            ResultSet rs = execSelectQuery(query, params);
            if (rs.next()) {
                return new Staff(
                        rs.getInt("staff_id"), // staff_id
                        rs.getString("username"), // username
                        rs.getString("email"), // email
                        rs.getString("password_hash"), // password_hash
                        rs.getString("phone"), // phone
                        rs.getString("role"), // role
                        rs.getDate("date_of_birth"), // date_of_birth
                        rs.getString("avatar_url") // avatar_url
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // 3. Update
    public int update(Staff staff) {
        String sql = "UPDATE Staff SET username=?, email=?, password_hash=?, phone=?, role=?, date_of_birth=?, avatar_url=? WHERE staff_id = ?";
        Object[] params = {
            staff.getUsername(),
            staff.getEmail(),
            staff.getPasswordHash(),
            staff.getPhone(),
            staff.getRole(),
            staff.getDateOfBirth(),
            staff.getAvatarUrl(),
            staff.getId()};
        try {
            return execQuery(sql, params);
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    // 4. Delete
    public int delete(int id) {
        String sql = "delete from staff where staff_id = ?";
        Object[] params = {id};
        try {
            return execQuery(sql, params);
        } catch (SQLException ex) {
            return 0;
        }
    }

    //
    public ArrayList<Staff> searchByName(String keyword) throws SQLException {
        ArrayList<Staff> staffs = new ArrayList<>();
        String query = "SELECT * FROM staff WHERE username LIKE ?";

        Object[] params = {"%" + keyword + "%"};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            staffs.add(new Staff(
                    rs.getInt("staff_id"), // staff_id
                    rs.getString("username"), // username
                    rs.getString("email"), // email
                    rs.getString("password_hash"), // password_hash
                    rs.getString("phone"), // phone
                    rs.getString("role"), // role
                    rs.getDate("date_of_birth"), // date_of_birth
                    rs.getString("avatar_url") // avatar_url
            ));
        }

        return staffs;
    }

    //row count
    public int countStaffs() {
        try {
            String query = "SELECT COUNT(*) FROM Staff";
            ResultSet rs = execSelectQuery(query);
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;

    }

}
