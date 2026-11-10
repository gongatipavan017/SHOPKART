
package com.shopkart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopkart.model.Product;
import com.shopkart.util.DBConnection;

public class ProductDAO {

    // Get all active products
    public List<Product> getAllProducts() {
        return getFilteredProducts("", "", "default");
    }

    // Get products by category
    public List<Product> getProductsByCategory(String category) {
        return getFilteredProducts("", category, "default");
    }

    // Search, category filter and sorting
    public List<Product> getFilteredProducts(
            String search,
            String category,
            String sort) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT p.* FROM products p " +
            "LEFT JOIN categories c ON p.category_id = c.category_id " +
            "WHERE p.status = 'ACTIVE' "
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append(
                "AND (LOWER(p.product_name) LIKE ? " +
                "OR LOWER(p.description) LIKE ?) "
            );
        }

        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND c.category_name = ? ");
        }

        // Only allow predefined sorting options
        if ("low".equals(sort)) {
            sql.append("ORDER BY p.price ASC");
        } else if ("high".equals(sort)) {
            sql.append("ORDER BY p.price DESC");
        } else if ("newest".equals(sort)) {
            sql.append("ORDER BY p.created_at DESC");
        } else {
            sql.append("ORDER BY p.product_id DESC");
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.trim().isEmpty()) {
                String keyword = "%" + search.trim().toLowerCase() + "%";
                ps.setString(index++, keyword);
                ps.setString(index++, keyword);
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    // Convert database row into Product object
    private Product mapProduct(ResultSet rs) throws Exception {

        Product product = new Product();

        product.setProductId(rs.getInt("product_id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setProductName(rs.getString("product_name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setImageUrl(rs.getString("image_url"));
        product.setStatus(rs.getString("status"));

        return product;
    }
}
