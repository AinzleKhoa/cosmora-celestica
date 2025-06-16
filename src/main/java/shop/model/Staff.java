/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.sql.Date;

/**
 *
 * @author Victus
 */
public class Staff {

    private int Id;
    private String username;
    private String email;
    private String passwordHash;

    private String phone;
    private String role;
    private Date dateOfBirth;
    private String avatarUrl;

    public Staff(int Id, String username, String email, String passwordHash, String phone, String role, Date dateOfBirth, String avatarUrl) {
        this.Id = Id;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
      
        this.phone = phone;
        this.role = role;
        this.dateOfBirth = dateOfBirth;
        this.avatarUrl = avatarUrl;
    }

    public Staff(String username, String email, String passwordHash, String phone, String role, Date dateOfBirth, String avatarUrl) {
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.role = role;
        this.dateOfBirth = dateOfBirth;
        this.avatarUrl = avatarUrl;
    }



    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }



    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    @Override
    public String toString() {
        return "Staff{" + "Id=" + Id + ", username=" + username + ", email=" + email + ", passwordHash=" + passwordHash + ", phone=" + phone + ", role=" + role + ", dateOfBirth=" + dateOfBirth + ", avatarUrl=" + avatarUrl + '}';
    }

}
