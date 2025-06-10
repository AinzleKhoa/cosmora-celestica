/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.db.DBContext;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
public class CustomerDAO extends DBContext {

    public Customer login(String email, String password) {
        String query = "";
        return null;
    }

    public int register(Customer customer) {
        try {
            String query = "INSERT INTO customer (username, email, password_hash, created_at)\n"
                    + "VALUES (?, ?, ?, CURRENT_TIMESTAMP);";
            Object[] params = {
                customer.getUsername(),
                customer.getEmail(),
                customer.getPasswordHash()
            };
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
