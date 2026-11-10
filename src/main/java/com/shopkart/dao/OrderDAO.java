
package com.shopkart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopkart.model.Order;
import com.shopkart.util.DBConnection;

public class OrderDAO {

    public List<Order> getOrdersByUserEmail(String email) {

        List<Order> orders = new ArrayList<>();

        String sql =
            "SELECT o.order_id, o.order_number, o.ordered_at, " +
            "o.total_amount, o.order_status, o.payment_method, " +
            "COUNT(oi.order_item_id) AS item_count " +
            "FROM orders o " +
            "LEFT JOIN order_items oi ON o.order_id = oi.order_id " +
            "JOIN users u ON o.user_id = u.user_id " +
            "WHERE u.email = ? " +
            "GROUP BY o.order_id, o.order_number, o.ordered_at, " +
            "o.total_amount, o.order_status, o.payment_method " +
            "ORDER BY o.ordered_at DESC";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                return orders;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, email);

                try (ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {

                        Order order = new Order();

                        order.setOrderId(rs.getInt("order_id"));
                        order.setOrderNumber(
                            rs.getString("order_number"));
                        order.setOrderedAt(
                            rs.getTimestamp("ordered_at"));
                        order.setTotalAmount(
                            rs.getBigDecimal("total_amount"));
                        order.setOrderStatus(
                            rs.getString("order_status"));
                        order.setPaymentMethod(
                            rs.getString("payment_method"));
                        order.setItemCount(
                            rs.getInt("item_count"));

                        orders.add(order);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
