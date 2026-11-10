
package com.shopkart.controller;

import java.io.IOException;

import com.shopkart.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty()
                || password.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=empty");
            return;
        }

        boolean valid = userDAO.loginUser(email.trim(), password);

        if (valid) {

            HttpSession session = request.getSession();

            session.setAttribute("userEmail", email.trim());

            response.sendRedirect(
                    request.getContextPath() + "/index.jsp");

        } else {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=invalid");
        }
    }
}
