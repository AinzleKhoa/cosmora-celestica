/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author ADMIN
 */
public class Order {

    private int orderId;
    private int customerId; 
    private int voucherId;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String shippingAddress;
    private LocalDateTime orderDate;
    private String status;
    private int staffId;

    public Order(int orderId, int customerId, int voucherId, BigDecimal totalAmount, String paymentMethod, String shippingAddress, LocalDateTime orderDate, String status, int staffId) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.voucherId = voucherId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.orderDate = orderDate;
        this.status = status;
        this.staffId = staffId;
    }

    public Order() {
    }
    

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }
    
}
