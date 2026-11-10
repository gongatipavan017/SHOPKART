package com.shopkart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/shopkart_db";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "Pavan@017";

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    URL, USERNAME, PASSWORD);

            System.out.println("SHOPKART Database Connected Successfully!");

            return con;

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace();
            return null;
        }
    }
}