package com.shopkart.util;

import java.sql.Connection;
import java.sql.SQLException;

public class DBTest {

    public static void main(String[] args) {

        try (Connection con = DBConnection.getConnection()) {

            if (con != null && !con.isClosed()) {
                System.out.println("Connection Successful!");
                System.out.println("Database: shopkart_db");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}