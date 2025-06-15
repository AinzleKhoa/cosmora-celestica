/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import shop.db.DBContext;
import shop.model.Voucher;

/**
 *
 * @author PC
 */
public class VouchersDAO extends DBContext {

    public ArrayList<Voucher> getList() {
        ArrayList<Voucher> codes = new ArrayList<>();
        try {
            String query = "SELECT *,\n"
                    + "       CASE\n"
                    + "           WHEN GETDATE() < start_date THEN 2\n"
                    + "           WHEN GETDATE() > end_date THEN 0\n"
                    + "           ELSE 1\n"
                    + "       END AS is_active\n"
                    + "FROM voucher;";
            ResultSet rs = execSelectQuery(query);
            while (rs.next()) {
                Voucher voucher = new Voucher(
                        rs.getInt(1), // voucher_id
                        rs.getString(2), // code
                        rs.getBigDecimal(3), // value
                        rs.getInt(4), // usage_limit
                        rs.getDate(5).toLocalDate(), // start_date
                        rs.getDate(6).toLocalDate(), // end_date
                        rs.getInt(10), // active
                        rs.getString(8), // description
                        rs.getBigDecimal(9) // min_order_value
                );
                codes.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return codes;
    }

    public Voucher getOne(int id) {
        try {
            String query = "SELECT * FROM voucher WHERE voucher_id = ?;";
            Object[] params = {id};
            ResultSet rs = execSelectQuery(query, params);

            if (rs.next()) {
                return new Voucher(
                        rs.getInt("voucher_id"),
                        rs.getString("code"),
                        rs.getBigDecimal("value"),
                        rs.getInt("usage_limit"),
                        rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getInt("active"),
                        rs.getString("description"),
                        rs.getBigDecimal("min_order_value")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean isDuplicateCodeForOtherVoucher(String code, int id) {
        try {
            String query = "SELECT COUNT(*) FROM voucher WHERE code = ? AND voucher_id != ?";
            Object[] params = {code, id};
            ResultSet rs = execSelectQuery(query, params);
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean isDuplicateCodeForOtherVoucherOfTheCreate(String code) {
        try {
            String query = "SELECT COUNT(*) FROM voucher WHERE code = ?";
            Object[] params = {code};
            ResultSet rs = execSelectQuery(query, params);
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int editVoucherCode(Voucher code) {
        try {
            String query
                    = "UPDATE voucher\n"
                    + "SET code = ?,\n"
                    + "    value = ?,\n"
                    + "    usage_limit = ?,\n"
                    + "    start_date = ?,\n"
                    + "    end_date = ?,\n"
                    + "    active = ?,\n"
                    + "    description = ?,\n"
                    + "    min_order_value = ?\n"
                    + "WHERE voucher_id = ?;";
            Object[] params = {code.getCode(), code.getValue(), code.getUsageLimit(), code.getStartDate(), code.getEndDate(), code.getActive(), code.getDescription(), code.getMinOrderValue(), code.getVoucherId()};
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int createVoucherCode(Voucher code) {
        try {
            String query = "INSERT INTO voucher (code, value, usage_limit, start_date, end_date, active, description, min_order_value) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            Object[] params = {
                code.getCode(),
                code.getValue(),
                code.getUsageLimit(),
                code.getStartDate(),
                code.getEndDate(),
                code.getActive(),
                code.getDescription(),
                code.getMinOrderValue()
            };
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Voucher> searchVoucherByCode(String keyword) {
        ArrayList<Voucher> vouchers = new ArrayList<>();
        String query = "SELECT * FROM voucher WHERE LOWER(code) LIKE LOWER(?)";

        try ( PreparedStatement stmt = this.getConnection().prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Voucher v = new Voucher(
                        rs.getInt("voucher_id"),
                        rs.getString("code"),
                        rs.getBigDecimal("value"),
                        rs.getInt("usage_limit"),
                        rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getInt("active"),
                        rs.getString("description"),
                        rs.getBigDecimal("min_order_value")
                );
                vouchers.add(v);
            }
        } catch (SQLException e) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return vouchers;
    }

    public int deleteVoucher(int id) {
        try {
            String query = "DELETE FROM voucher WHERE voucher_id = ?";
            Object[] params = {id};
            return execQuery(query, params);
        } catch (SQLException ex) {
            Logger.getLogger(VouchersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
