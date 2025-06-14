/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import shop.db.DBContext;
import shop.model.Customer;
import shop.model.Order;
import shop.model.OrderDetails;
import shop.model.Product;

/**
 *
 * @author ADMIN
 */
public class OrderDAO extends DBContext {

    public ArrayList<Order> getallOrder() throws SQLException {
        ArrayList<Order> order = new ArrayList<>();
        String query = "SELECT * FROM [order];";
        ResultSet rs = execSelectQuery(query);
        while (rs.next()) {
            order.add(new Order(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getBigDecimal(4), rs.getString(5), rs.getString(6), rs.getObject("order_date", LocalDateTime.class),
                    rs.getString(8), rs.getInt(9)));
        }
        return order;

    }

    public Customer getCustomerById(int id) throws SQLException {
        Customer temp = new Customer();
        String query = "SELECT * FROM customer WHERE customer_id = ?;";
        Object[] params = {id};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.setCustomerId(rs.getInt(1));
            temp.setEmail(rs.getString(3));
            temp.setFullName(rs.getString(5));
            temp.setFullName(rs.getString(5));
            temp.setAddress(rs.getString(7));
        }
        return temp;

    }

    public ArrayList<OrderDetails> getOrderDetail(int orderId) throws SQLException {
        ArrayList<OrderDetails> temp = new ArrayList<>();
        String query = "select * from order_detail where order_id=?;";
        Object[] params = {orderId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.add(new OrderDetails(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getBigDecimal(5)));
        }
        return temp;

    }

    public Product getProductInOrder(int productId) throws SQLException {
        Product temp = new Product();
        String query = "select * from product where product_id =?;";
        Object[] params = {productId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.setName(rs.getString(2));
        }
        return temp;

    }

    public Order getOneOrder(int orderId) throws SQLException {
        Order temp = new Order();
        String query = "select * from [order] where order_id = ?;";
        Object[] params = {orderId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.setOrderId(rs.getInt(1));
            temp.setTotalAmount(rs.getBigDecimal(4));
            temp.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
            temp.setStatus(rs.getString(8));
            temp.setShippingAddress(rs.getString(6));
        }
        return temp;
    }

    public int updateOrderStatus(String status, int orderId) throws SQLException {
        String query = "UPDATE [order]\n"
                + "SET status = ?\n"
                + "WHERE order_id = ?;";
        Object[] params = {status, orderId};
        return execQuery(query, params);
    }

    public ArrayList<Order> searchOrders(String customer_name) throws SQLException {
        ArrayList<Order> temp = new ArrayList<>();
        String query = "SELECT o.*\n"
                + "FROM [Order] o\n"
                + "JOIN Customer c ON o.customer_id = c.customer_id\n"
                + "WHERE c.full_name LIKE ?;";
        Object [] params = {"%"+customer_name+"%"};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {            
            temp.add(new Order(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getBigDecimal(4), rs.getString(5), rs.getString(6), rs.getObject("order_date", LocalDateTime.class),
                    rs.getString(8), rs.getInt(9)));
        }return temp;
        
    }
}
