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

/**
 *
 * @author VICTUS
 */
public class StaffDAO extends DBContext {

    public ArrayList<Staff> getList() {
        ArrayList<Staff> staffs = new ArrayList<>();
        String query = "SELECT * FROM staff";
        try ( ResultSet rs = execSelectQuery(query)) {
            while (rs.next()) {
                staffs.add(new Staff(
                        rs.getInt(1), // staff_id
                        rs.getString(2), // username
                        rs.getString(3), // email
                        rs.getString(4), // password_hash
                        rs.getString(5), // phone
                        rs.getString(6), // role
                        rs.getDate(7), // date_of_birth
                        rs.getString(8) // avatar_url
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
                staff.getUserName(),
                staff.getEmail(),
                staff.getPassword(),
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
                        rs.getInt(1), // staff_id
                        rs.getString(2), // username
                        rs.getString(3), // email
                        rs.getString(4), // password_hash
                        rs.getString(5), // phone
                        rs.getString(6), // role
                        rs.getDate(7), // date_of_birth
                        rs.getString(8) // avatar_url)
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
            staff.getUserName(),
            staff.getEmail(),
            staff.getPassword(),
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

      Object [] params = {"%"+keyword+"%"};
        ResultSet rs = execSelectQuery(query, params);
            while (rs.next()) {
                staffs.add(new Staff(
                        rs.getInt(1), // staff_id
                        rs.getString(2), // username
                        rs.getString(3), // email
                        rs.getString(4), // password_hash
                        rs.getString(5), // phone
                        rs.getString(6), // role
                        rs.getDate(7), // date_of_birth
                        rs.getString(8) // avatar_url
                ));
            }
     

        return staffs;
    }

}
