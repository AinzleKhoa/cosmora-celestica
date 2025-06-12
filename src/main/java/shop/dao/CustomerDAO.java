/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.db.DBContext;
import shop.model.Customer;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
public class CustomerDAO extends DBContext {

    public Customer getAccountByEmail(String email) {
        try {
            String query = "SELECT *\n"
                    + "FROM customer c\n"
                    + "WHERE c.email = ?";
            Object[] params = {email};
            ResultSet rs = execSelectQuery(query, params);
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("full_name"),
                        rs.getString("phone"),
                        rs.getString("gender"),
                        rs.getString("address"),
                        rs.getString("avatar_url"),
                        rs.getDate("date_of_birth"),
                        rs.getBoolean("is_deactivated"),
                        rs.getTimestamp("last_login"),
                        rs.getString("google_id"),
                        rs.getString("remember_me_token"),
                        rs.getString("reset_token"),
                        rs.getTimestamp("reset_token_expiry"),
                        rs.getBoolean("email_verified"),
                        rs.getString("email_verification_token"),
                        rs.getTimestamp("email_verification_expiry"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean isEmailExists(String email) {
        try {
            String query = "SELECT *\n"
                    + "FROM customer c\n"
                    + "WHERE c.email = ?";
            Object[] params = {email};
            ResultSet rs = execSelectQuery(query, params);
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int storeOtpForEmail(String email, String otp, Timestamp expiry) {
        try {
            String query = "UPDATE customer SET email_verification_token = ?, email_verification_expiry = ? WHERE email = ?";
            Object[] params = {otp, expiry, email};
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int register(Customer customer) {
        try {
            String query = "INSERT INTO customer (username, email, password_hash, avatar_url, created_at)\n"
                    + "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP);";
            Object[] params = {
                customer.getUsername(),
                customer.getEmail(),
                customer.getPasswordHash(),
                customer.getAvatarUrl()
            };
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public boolean saveOtp() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
