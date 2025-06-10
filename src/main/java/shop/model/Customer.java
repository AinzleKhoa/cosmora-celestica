/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author CE190449 - Le Anh Khoa
 */
public class Customer {

    private int customerId;
    private String username;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phone;
    private String gender;
    private String address;
    private String avatarUri;
    private Date dateOfBirth;
    private boolean isDeactivated;
    private Timestamp lastLogin;
    private String googleId;
    private String rememberMeToken;
    private String resetToken;
    private Timestamp resetTokenExpiry;
    private boolean emailVerified;
    private String emailVerificationToken;
    private Timestamp emailVerificationExpiry;
    private Timestamp updatedAt;
    private Timestamp createdAt;

    public Customer(int customerId, String username, String email, String passwordHash, String fullName, String phone, String gender, String address, String avatarUri, Date dateOfBirth, boolean isDeactivated, Timestamp lastLogin, String googleId, String rememberMeToken, String resetToken, Timestamp resetTokenExpiry, boolean emailVerified, String emailVerificationToken, Timestamp emailVerificationExpiry, Timestamp updatedAt, Timestamp createdAt) {
        this.customerId = customerId;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.avatarUri = avatarUri;
        this.dateOfBirth = dateOfBirth;
        this.isDeactivated = isDeactivated;
        this.lastLogin = lastLogin;
        this.googleId = googleId;
        this.rememberMeToken = rememberMeToken;
        this.resetToken = resetToken;
        this.resetTokenExpiry = resetTokenExpiry;
        this.emailVerified = emailVerified;
        this.emailVerificationToken = emailVerificationToken;
        this.emailVerificationExpiry = emailVerificationExpiry;
        this.updatedAt = updatedAt;
        this.createdAt = createdAt;
    }

    public Customer(String username, String email, String passwordHash) {
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
    }

    public Customer(int customerId, String email, String passwordHash, boolean isDeactivated) {
        this.customerId = customerId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.isDeactivated = isDeactivated;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public String getPhone() {
        return phone;
    }

    public String getGender() {
        return gender;
    }

    public String getAddress() {
        return address;
    }

    public String getAvatarUri() {
        return avatarUri;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public boolean isIsDeactivated() {
        return isDeactivated;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public String getGoogleId() {
        return googleId;
    }

    public String getRememberMeToken() {
        return rememberMeToken;
    }

    public String getResetToken() {
        return resetToken;
    }

    public Timestamp getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    public boolean isEmailVerified() {
        return emailVerified;
    }

    public String getEmailVerificationToken() {
        return emailVerificationToken;
    }

    public Timestamp getEmailVerificationExpiry() {
        return emailVerificationExpiry;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

}
