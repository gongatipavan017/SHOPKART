
package com.shopkart.controller;

import java.io.IOException;

import com.shopkart.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (fullName == null || email == null ||
            password == null || confirmPassword == null ||
            fullName.trim().isEmpty() || email.trim().isEmpty() ||
            password.isEmpty() || confirmPassword.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error",
                    "Password must contain at least 8 characters.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        boolean registered = userDAO.registerUser(
                fullName.trim(),
                email.trim().toLowerCase(),
                password
        );

        if (registered) {
            response.sendRedirect("login.jsp?registered=success");
        } else {
            request.setAttribute("error",
                    "Registration failed. Email may already be registered.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }
}
