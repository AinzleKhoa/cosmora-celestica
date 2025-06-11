/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
                        rs.getString(5), // full_name
                        rs.getString(6), // phone
                        rs.getString(7), // role
                        rs.getDate(8), // date_of_birth
                        rs.getString(9) // avatar_url
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return staffs;
    }
}
