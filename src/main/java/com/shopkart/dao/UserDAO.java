
package com.shopkart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.shopkart.util.DBConnection;
import com.shopkart.util.PasswordUtil;

public class UserDAO {

    // Register a new customer
    public boolean registerUser(
            String fullName,
            String email,
            String password) {

        String checkSql =
                "SELECT user_id FROM users WHERE email = ?";

        String insertSql =
                "INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                System.out.println("Database connection failed!");
                return false;
            }

            // Check whether email already exists
            try (PreparedStatement checkPs =
                    con.prepareStatement(checkSql)) {

                checkPs.setString(1, email);

                try (ResultSet rs = checkPs.executeQuery()) {

                    if (rs.next()) {
                        System.out.println("Email already registered!");
                        return false;
                    }
                }
            }

            // Hash password before storing
            String hashedPassword =
                    PasswordUtil.hashPassword(password);

            // Insert customer into database
            try (PreparedStatement insertPs =
                    con.prepareStatement(insertSql)) {

                insertPs.setString(1, fullName);
                insertPs.setString(2, email);
                insertPs.setString(3, hashedPassword);

                int rows = insertPs.executeUpdate();

                if (rows > 0) {
                    System.out.println("User registered successfully!");
                    return true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Login user verification
    public boolean loginUser(
            String email,
            String password) {

        String sql =
                "SELECT password FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                System.out.println("Database connection failed!");
                return false;
            }

            try (PreparedStatement ps =
                    con.prepareStatement(sql)) {

                ps.setString(1, email);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        String storedPassword =
                                rs.getString("password");

                        boolean valid =
                                PasswordUtil.verifyPassword(
                                        password,
                                        storedPassword
                                );

                        System.out.println(
                                valid ? "Login successful!"
                                      : "Invalid password!"
                        );

                        return valid;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("User not found!");
        return false;
    }


    // Get user details by email
    public ResultSet getUserByEmail(String email)
            throws Exception {

        Connection con = DBConnection.getConnection();

        String sql =
                "SELECT user_id, full_name, email, role FROM users WHERE email = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, email);

        return ps.executeQuery();
    }

}
