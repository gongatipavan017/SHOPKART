
package com.shopkart.controller;

import java.io.IOException;
import java.util.List;

import com.shopkart.dao.ProductDAO;
import com.shopkart.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String category = request.getParameter("category");

            List<Product> products;

            if (category == null || category.trim().isEmpty()) {
                products = productDAO.getAllProducts();
            } else {
                products = productDAO.getProductsByCategory(
                        category.trim()
                );
            }

            request.setAttribute("products", products);
            request.setAttribute("selectedCategory", category);

            // Search and sorting parameters for the JSP
            String searchKeyword = request.getParameter("search");
            String sort = request.getParameter("sort");

            request.setAttribute("searchKeyword",
                    searchKeyword == null ? "" : searchKeyword);

            request.setAttribute("selectedSort",
                    sort == null ? "default" : sort);

            request.getRequestDispatcher("/product-listing.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load products. Please check the server console."
            );
        }
    }
}
