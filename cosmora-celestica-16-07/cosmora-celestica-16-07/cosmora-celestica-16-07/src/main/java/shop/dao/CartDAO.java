/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import shop.db.DBContext;
import shop.model.Cart;
import shop.model.CartItem;

/**
 *
 * @author VICTUS
 */
public class CartDAO extends DBContext {

    // Tìm cart item theo customer_id và product_id
    public Cart findCartItem(int customerId, int productId) {
        String sql = "SELECT * FROM cart WHERE customer_id = ? AND product_id = ?";
        Object[] params = {customerId, productId};

        try ( ResultSet rs = execSelectQuery(sql, params)) {
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


   public List<CartItem> getCartItemsByCustomerId(int customerId) throws SQLException {
    List<CartItem> cartItems = new ArrayList<>();

    String sql = "SELECT c.cart_id, c.customer_id, c.product_id, c.quantity AS cart_quantity, "
               + "p.name AS product_name, p.price, p.sale_price, p.quantity AS product_quantity, "
               + "i.image_id, i.image_URL AS image_url, "
               + "cat.name AS category_name "
               + "FROM cart c "
               + "JOIN product p ON c.product_id = p.product_id "
               + "LEFT JOIN category cat ON p.category_id = cat.category_id "
               + "LEFT JOIN image i ON i.image_id = ( "
               + "    SELECT MIN(image_id) FROM image WHERE product_id = p.product_id "
               + ") "
               + "WHERE c.customer_id = ?";

    try (ResultSet rs = this.execSelectQuery(sql, new Object[]{customerId})) {
        while (rs.next()) {
            int cartQuantity = rs.getInt("cart_quantity");
            int productQuantity = rs.getInt("product_quantity");
            int cartId = rs.getInt("cart_id");

            // cartQuantity > productQuantity
            if (cartQuantity > productQuantity) {
                cartQuantity = productQuantity;
                String updateSql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                this.execQuery(updateSql, new Object[]{cartQuantity, cartId});
            }

            CartItem item = new CartItem();
            item.setCartId(cartId);
            item.setCustomerId(rs.getInt("customer_id"));
            item.setProductId(rs.getInt("product_id"));
            item.setCartQuantity(cartQuantity);
            item.setProductName(rs.getString("product_name"));
item.setPrice(rs.getDouble("price"));
            item.setSalePrice(rs.getObject("sale_price") != null ? rs.getDouble("sale_price") : null);
            item.setProductQuantity(productQuantity);
            item.setImageUrl(rs.getString("image_url"));
            item.setCategoryName(rs.getString("category_name"));

            cartItems.add(item);
        }
    }

    return cartItems;
}


    // Thêm sản phẩm mới vào giỏ
    public void insertCart(Cart cart) {
        String sql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?, ?, ?)";
        Object[] params = {cart.getCustomerId(), cart.getProductId(), cart.getQuantity()};

        try {
            execQuery(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ
    public void updateCart(Cart cart) {
        String sql = "UPDATE cart SET quantity = ? WHERE customer_id = ? AND product_id = ?";
        Object[] params = {cart.getQuantity(), cart.getCustomerId(), cart.getProductId()};

        try {
            execQuery(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int delete(int productId, int customerId) {
        String sql = "delete from CART where product_id = ? and customer_id =?";
        Object[] params = {productId, customerId};
        try {
            return execQuery(sql, params);
        } catch (SQLException ex) {
            return 0;
        }
    }

    public int countCartItems(int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(cart_id)\n"
                + "FROM cart\n"
                + "WHERE customer_id = ?";
        try {
            ResultSet rs = this.execSelectQuery(sql, new Object[]{customerId});
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int deleteCartAfterBuy(int customerId, String[] productId) throws SQLException {
        StringBuilder sql = new StringBuilder("DELETE FROM cart WHERE customer_id = ? AND product_id IN (");
        Object[] params = new Object[productId.length + 1];
        int index = 1;
        params[0] = customerId;
        for (int i = 0; i < productId.length; i++) {
            sql.append("?");
            if (i < productId.length - 1) {
                sql.append(", ");
            }
            int proId = Integer.parseInt(productId[i]);
            params[index++] = proId;

        }
        sql.append(")");

        return execQuery(sql.toString(), params);
    }

}