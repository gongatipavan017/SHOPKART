
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.shopkart.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    if (orders == null) {
        response.sendRedirect(request.getContextPath() + "/my-orders");
        return;
    }

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Orders | SHOPKART</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f5f5f5;
    color: #202020;
}

header {
    background: #202020;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 27px;
    font-weight: bold;
}

.logo span {
    color: #ffc928;
}

nav {
    display: flex;
    gap: 22px;
}

nav a {
    color: white;
    text-decoration: none;
}

.container {
    max-width: 1100px;
    margin: 35px auto;
    padding: 0 20px;
}

.page-title {
    font-size: 28px;
    margin-bottom: 8px;
}

.subtitle {
    color: #666;
    margin-bottom: 25px;
}

.order-card {
    background: white;
    border-radius: 10px;
    padding: 22px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
}

.order-header {
    display: flex;
    justify-content: space-between;
    gap: 15px;
    flex-wrap: wrap;
    border-bottom: 1px solid #eee;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.order-number {
    font-weight: bold;
    font-size: 17px;
}

.order-date {
    color: #777;
    font-size: 14px;
    margin-top: 7px;
}

.status {
    display: inline-block;
    padding: 7px 13px;
    border-radius: 20px;
    background: #fff3cd;
    color: #856404;
    font-size: 13px;
    font-weight: bold;
}

.status.CONFIRMED {
    background: #d1ecf1;
    color: #0c5460;
}

.status.SHIPPED {
    background: #e2d9f3;
    color: #563d7c;
}

.status.DELIVERED {
    background: #d4edda;
    color: #155724;
}

.status.CANCELLED {
    background: #f8d7da;
    color: #721c24;
}

.order-details {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
}

.detail-label {
    color: #777;
    font-size: 13px;
    margin-bottom: 7px;
}

.detail-value {
    font-size: 16px;
    font-weight: bold;
}

.amount {
    color: #e87900;
}

.empty-orders {
    background: white;
    text-align: center;
    padding: 55px 20px;
    border-radius: 10px;
}

.empty-orders h2 {
    margin-bottom: 12px;
}

.shop-btn {
    display: inline-block;
    background: #ff8c00;
    color: white;
    text-decoration: none;
    padding: 13px 25px;
    border-radius: 6px;
    margin-top: 20px;
    font-weight: bold;
}

.back-link {
    display: inline-block;
    margin-bottom: 20px;
    color: #202020;
    text-decoration: none;
}

footer {
    background: #202020;
    color: white;
    text-align: center;
    padding: 20px;
    margin-top: 45px;
}

@media(max-width: 650px) {
    header {
        padding: 15px;
    }

    nav {
        gap: 10px;
        font-size: 13px;
    }

    .order-details {
        grid-template-columns: 1fr 1fr;
    }
}
</style>
</head>

<body>

<header>
    <div class="logo">SHOP<span>KART</span></div>

    <nav>
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/products">Products</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>
</header>

<div class="container">

    <a class="back-link"
       href="<%= request.getContextPath() %>/index.jsp">
       ← Back to Home
    </a>

    <h1 class="page-title">My Orders</h1>

    <p class="subtitle">
        View and track your SHOPKART orders.
    </p>

    <% if (orders.isEmpty()) { %>

        <div class="empty-orders">
            <h2>No Orders Yet!</h2>
            <p>You haven't placed any orders.</p>

            <a href="<%= request.getContextPath() %>/products"
               class="shop-btn">
                Start Shopping
            </a>
        </div>

    <% } else { %>

        <% for (Order order : orders) { %>

            <div class="order-card">

                <div class="order-header">

                    <div>
                        <div class="order-number">
                            Order #<%= order.getOrderNumber() %>
                        </div>

                        <div class="order-date">
                            <% if (order.getOrderedAt() != null) { %>
                                <%= dateFormat.format(order.getOrderedAt()) %>
                            <% } else { %>
                                Date unavailable
                            <% } %>
                        </div>
                    </div>

                    <div>
                        <span class="status <%= order.getOrderStatus() %>">
                            <%= order.getOrderStatus() %>
                        </span>
                    </div>

                </div>

                <div class="order-details">

                    <div>
                        <div class="detail-label">Items</div>
                        <div class="detail-value">
                            <%= order.getItemCount() %>
                        </div>
                    </div>

                    <div>
                        <div class="detail-label">Payment Method</div>
                        <div class="detail-value">
                            <%= order.getPaymentMethod() %>
                        </div>
                    </div>

                    <div>
                        <div class="detail-label">Total Amount</div>
                        <div class="detail-value amount">
                            ₹<%= order.getTotalAmount() %>
                        </div>
                    </div>

                </div>

            </div>

        <% } %>

    <% } %>

</div>

<footer>
    <p>© 2026 SHOPKART. Everything You Love. One Place.</p>
</footer>

</body>
</html>
