/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import shop.db.DBContext;
import shop.model.Cart;

/**
 *
 * @author VICTUS
 */
public class CartDAO extends DBContext {

    // Tìm cart item theo customer_id và product_id
    public Cart findCartItem(int customerId, int productId) {
        String sql = "SELECT * FROM cart WHERE customer_id = ? AND product_id = ?";
        Object[] params = { customerId, productId };

        try (ResultSet rs = execSelectQuery(sql, params)) {
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setCustomerId(rs.getInt("customer_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                return cart;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm sản phẩm mới vào giỏ
    public void insertCart(Cart cart) {
        String sql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?, ?, ?)";
        Object[] params = { cart.getCustomerId(), cart.getProductId(), cart.getQuantity() };

        try {
            execQuery(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ
    public void updateCart(Cart cart) {
        String sql = "UPDATE cart SET quantity = ? WHERE customer_id = ? AND product_id = ?";
        Object[] params = { cart.getQuantity(), cart.getCustomerId(), cart.getProductId() };

        try {
            execQuery(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
