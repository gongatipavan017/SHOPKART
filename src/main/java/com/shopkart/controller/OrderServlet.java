
package com.shopkart.controller;

import java.io.IOException;
import java.util.List;

import com.shopkart.dao.OrderDAO;
import com.shopkart.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userEmail") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        String email =
            (String) session.getAttribute("userEmail");

        List<Order> orders =
            orderDAO.getOrdersByUserEmail(email);

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/my-orders.jsp")
               .forward(request, response);
    }
}
