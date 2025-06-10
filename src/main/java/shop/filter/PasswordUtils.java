/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.filter;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for hashing passwords and checking password validity. This
 * class provides methods to hash passwords using BCrypt and to check if a plain
 * password matches a hashed one.
 *
 * @author Le Anh Khoa - CE190449
 */
public class PasswordUtils {

    /**
     * Hashes the given password using BCrypt with a salt factor of 12.
     *
     * @param password the password to be hashed
     * @return the hashed password
     */
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    /**
     * Checks if the given plain password matches the hashed password using
     * BCrypt.
     *
     * @param plainPassword the plain password to check
     * @param hashedPassword the hashed password to compare against
     * @return true if the plain password matches the hashed password, false
     * otherwise
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
