
package com.shopkart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shopkart.model.CartItem;
import com.shopkart.util.DBConnection;

public class CartDAO {

    // Add product to cart
    public boolean addToCart(int userId, int productId) {

        String cartSql =
            "INSERT INTO carts (user_id) VALUES (?) " +
            "ON DUPLICATE KEY UPDATE cart_id = LAST_INSERT_ID(cart_id)";

        String itemSql =
            "INSERT INTO cart_items (cart_id, product_id, quantity) " +
            "VALUES (?, ?, 1) " +
            "ON DUPLICATE KEY UPDATE quantity = quantity + 1";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                return false;
            }

            con.setAutoCommit(false);

            try {
                int cartId;

                try (PreparedStatement ps =
                     con.prepareStatement(
                         cartSql,
                         PreparedStatement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            cartId = rs.getInt(1);
                        } else {
                            throw new SQLException("Cart ID not found");
                        }
                    }
                }

                try (PreparedStatement ps =
                     con.prepareStatement(itemSql)) {

                    ps.setInt(1, cartId);
                    ps.setInt(2, productId);
                    ps.executeUpdate();
                }

                con.commit();
                return true;

            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get cart items
    public List<CartItem> getCartItems(int userId) {

        List<CartItem> items = new ArrayList<>();

        String sql =
            "SELECT ci.cart_item_id, ci.product_id, " +
            "p.product_name, p.price, ci.quantity, " +
            "(p.price * ci.quantity) AS subtotal, p.image_url " +
            "FROM carts c " +
            "JOIN cart_items ci ON c.cart_id = ci.cart_id " +
            "JOIN products p ON ci.product_id = p.product_id " +
            "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                return items;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {

                        CartItem item = new CartItem();

                        item.setCartItemId(
                            rs.getInt("cart_item_id"));

                        item.setProductId(
                            rs.getInt("product_id"));

                        item.setProductName(
                            rs.getString("product_name"));

                        item.setPrice(
                            rs.getDouble("price"));

                        item.setQuantity(
                            rs.getInt("quantity"));

                        item.setSubtotal(
                            rs.getDouble("subtotal"));

                        item.setImageUrl(
                            rs.getString("image_url"));

                        items.add(item);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }

    // Remove product from cart
    public boolean removeCartItem(int cartItemId) {

        String sql =
            "DELETE FROM cart_items WHERE cart_item_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                return false;
            }

            try (PreparedStatement ps =
                 con.prepareStatement(sql)) {

                ps.setInt(1, cartItemId);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
