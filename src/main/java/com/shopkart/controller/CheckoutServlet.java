
package com.shopkart.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

import com.shopkart.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String email = (String) session.getAttribute("userEmail");

        String sql =
            "SELECT COUNT(*) AS item_count, " +
            "COALESCE(SUM(ci.quantity * p.price), 0) AS total " +
            "FROM carts c " +
            "JOIN cart_items ci ON c.cart_id = ci.cart_id " +
            "JOIN products p ON ci.product_id = p.product_id " +
            "WHERE c.user_id = (SELECT user_id FROM users WHERE email = ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    if (rs.getInt("item_count") == 0) {
                        response.sendRedirect(
                            request.getContextPath() + "/products");
                        return;
                    }

                    request.setAttribute("cartTotal",
                        rs.getBigDecimal("total"));

                    request.setAttribute("itemCount",
                        rs.getInt("item_count"));
                }
            }

            request.getRequestDispatcher("/checkout.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Unable to open checkout");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String email = (String) session.getAttribute("userEmail");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String addressLine = request.getParameter("addressLine");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String addressType = request.getParameter("addressType");

        if (isBlank(fullName) || isBlank(phone) ||
            isBlank(addressLine) || isBlank(city) ||
            isBlank(state) || isBlank(pincode)) {

            redirectError(request, response, "missing");
            return;
        }

        if (!phone.matches("[0-9]{10}") ||
            !pincode.matches("[0-9]{6}")) {

            redirectError(request, response, "invalid");
            return;
        }

        if (!"HOME".equals(addressType) &&
            !"OFFICE".equals(addressType) &&
            !"OTHER".equals(addressType)) {
            addressType = "HOME";
        }

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                throw new Exception("Database connection failed");
            }

            con.setAutoCommit(false);

            try {
                int userId;

                String userSql =
                    "SELECT user_id FROM users WHERE email = ?";

                try (PreparedStatement ps =
                     con.prepareStatement(userSql)) {

                    ps.setString(1, email);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new Exception("User not found");
                        }
                        userId = rs.getInt("user_id");
                    }
                }

                int cartId;
                BigDecimal totalAmount;

                String cartSql =
                    "SELECT c.cart_id, SUM(ci.quantity * p.price) AS total " +
                    "FROM carts c " +
                    "JOIN cart_items ci ON c.cart_id = ci.cart_id " +
                    "JOIN products p ON ci.product_id = p.product_id " +
                    "WHERE c.user_id = ? GROUP BY c.cart_id";

                try (PreparedStatement ps =
                     con.prepareStatement(cartSql)) {

                    ps.setInt(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new Exception("Cart is empty");
                        }

                        cartId = rs.getInt("cart_id");
                        totalAmount = rs.getBigDecimal("total");
                    }
                }

                int addressId;

                String addressSql =
                    "INSERT INTO addresses " +
                    "(user_id, full_name, phone, address_line, city, " +
                    "state, pincode, address_type, is_default) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";

                try (PreparedStatement ps = con.prepareStatement(
                        addressSql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);
                    ps.setString(2, fullName.trim());
                    ps.setString(3, phone.trim());
                    ps.setString(4, addressLine.trim());
                    ps.setString(5, city.trim());
                    ps.setString(6, state.trim());
                    ps.setString(7, pincode.trim());
                    ps.setString(8, addressType);

                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new Exception("Address save failed");
                        }
                        addressId = rs.getInt(1);
                    }
                }

                String orderNumber = "SK" +
                    UUID.randomUUID().toString()
                    .replace("-", "").substring(0, 12).toUpperCase();

                int orderId;

                String orderSql =
                    "INSERT INTO orders " +
                    "(user_id, address_id, order_number, total_amount, " +
                    "order_status, payment_method) " +
                    "VALUES (?, ?, ?, ?, 'PENDING', 'COD')";

                try (PreparedStatement ps = con.prepareStatement(
                        orderSql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, addressId);
                    ps.setString(3, orderNumber);
                    ps.setBigDecimal(4, totalAmount);

                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new Exception("Order creation failed");
                        }
                        orderId = rs.getInt(1);
                    }
                }

                String itemSql =
                    "INSERT INTO order_items " +
                    "(order_id, product_id, quantity, price) " +
                    "SELECT ?, ci.product_id, ci.quantity, p.price " +
                    "FROM cart_items ci " +
                    "JOIN products p ON ci.product_id = p.product_id " +
                    "WHERE ci.cart_id = ?";

                try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, cartId);

                    if (ps.executeUpdate() == 0) {
                        throw new Exception("Order items not saved");
                    }
                }

                try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM cart_items WHERE cart_id = ?")) {

                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                }

                con.commit();

                response.sendRedirect(
                    request.getContextPath() +
                    "/order-success.jsp?orderNumber=" + orderNumber);

            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectError(request, response, "failed");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void redirectError(HttpServletRequest request,
                               HttpServletResponse response,
                               String error) throws IOException {

        response.sendRedirect(
            request.getContextPath() + "/checkout?error=" + error);
    }
}
