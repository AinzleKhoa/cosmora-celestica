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
import java.util.List;
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
        String query = "SELECT \n"
                + "    o.*, \n"
                + "    c.full_name\n"
                + "FROM \n"
                + "    [order] o\n"
                + "JOIN \n"
                + "    customer c ON o.customer_id = c.customer_id;";
        ResultSet rs = execSelectQuery(query);
        while (rs.next()) {
            order.add(new Order(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getBigDecimal(4), rs.getString(5), rs.getString(6), rs.getObject("order_date", LocalDateTime.class),
                    rs.getString(8), rs.getInt(9), rs.getString(10)));
        }
        return order;

    }

    public ArrayList<OrderDetails> getOrderDetail(int orderId) throws SQLException {
        ArrayList<OrderDetails> temp = new ArrayList<>();
        String query = "SELECT \n"
                + "    od.*, \n"
                + "    p.name AS product_name\n"
                + "FROM \n"
                + "    Order_Detail od\n"
                + "JOIN \n"
                + "    Product p ON od.product_id = p.product_id\n"
                + "WHERE \n"
                + "    od.order_id = ?;";
        Object[] params = {orderId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.add(new OrderDetails(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getBigDecimal(5), rs.getString(6)));
        }
        return temp;

    }

    public ArrayList<OrderDetails> getOrderDetailForCus(int orderId) throws SQLException {
        ArrayList<OrderDetails> temp = new ArrayList<>();
        String query = "SELECT \n"
                + "    od.product_id,\n"
                + "    od.quantity,\n"
                + "    od.price,\n"
                + "    p.name AS product_name,\n"
                + "    img.image_URL,\n"
                + "    c.name AS category_name\n"
                + "FROM order_detail od\n"
                + "JOIN product p ON od.product_id = p.product_id\n"
                + "OUTER APPLY (\n"
                + "    SELECT TOP 1 image_URL\n"
                + "    FROM image\n"
                + "    WHERE image.product_id = p.product_id\n"
                + "    ORDER BY image_id -- hoặc created_at nếu có\n"
                + ") AS img\n"
                + "LEFT JOIN category c ON p.category_id = c.category_id\n"
                + "WHERE od.order_id = ?;";
        Object[] params = {orderId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.add(new OrderDetails(rs.getInt(1), rs.getInt(2), rs.getBigDecimal(3), rs.getString(4), rs.getString(5), rs.getString(6)));
        }
        return temp;

    }

    public Order getOneOrder(int orderId) throws SQLException {
        Order temp = new Order();
        String query = "SELECT \n"
                + "    o.*, \n"
                + "    c.full_name, \n"
                + "    c.email\n"
                + "FROM \n"
                + "    [Order] o\n"
                + "JOIN \n"
                + "    Customer c ON o.customer_id = c.customer_id\n"
                + "WHERE \n"
                + "    o.order_id = ?;";
        Object[] params = {orderId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.setOrderId(rs.getInt(1));
            temp.setTotalAmount(rs.getBigDecimal(4));
            temp.setOrderDate(rs.getObject("order_date", LocalDateTime.class));
            temp.setStatus(rs.getString(8));
            temp.setShippingAddress(rs.getString(6));
            temp.setCustomerName(rs.getString(10));
            temp.setCustomerEmail(rs.getString(11));
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
        String query = "SELECT o.*, c.full_name\n"
                + "FROM [Order] o\n"
                + "JOIN Customer c ON o.customer_id = c.customer_id\n"
                + "WHERE c.full_name LIKE ?;";
        Object[] params = {"%" + customer_name + "%"};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            temp.add(new Order(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getBigDecimal(4), rs.getString(5), rs.getString(6), rs.getObject("order_date", LocalDateTime.class),
                    rs.getString(8), rs.getInt(9), rs.getString(10)));
        }
        return temp;

    }

    public ArrayList<Order> getOrderById(int customerId) throws SQLException {
        ArrayList<Order> order = new ArrayList<>();
        String query = "SELECT \n"
                + "    o.*, \n"
                + "    c.full_name\n"
                + "FROM \n"
                + "    [order] o\n"
                + "JOIN \n"
                + "    customer c ON o.customer_id = c.customer_id \n" // thêm khoảng trắng hoặc xuống dòng
                + "WHERE o.customer_id = ?;";

        Object[] params = {customerId};
        ResultSet rs = execSelectQuery(query, params);
        while (rs.next()) {
            order.add(new Order(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getBigDecimal(4), rs.getString(5), rs.getString(6), rs.getObject("order_date", LocalDateTime.class),
                    rs.getString(8), rs.getInt(9), rs.getString(10)));
        }
        return order;

    }

    public int[] getProIdByOrderId(int orderid) throws SQLException {
        List<Integer> tempList = new ArrayList<>();

        String query = "SELECT product_id FROM order_detail WHERE order_id = ?";
        Object[] params = {orderid};
        ResultSet rs = execSelectQuery(query, params);

        while (rs.next()) {
            tempList.add(rs.getInt("product_id"));
        }

        int[] proId = new int[tempList.size()];
        for (int i = 0; i < tempList.size(); i++) {
            proId[i] = tempList.get(i);
        }

        return proId;
    }

}
