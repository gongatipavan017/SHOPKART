
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String orderNumber = request.getParameter("orderNumber");

    if (orderNumber == null || !orderNumber.matches("SK[A-F0-9]{12}")) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Successful | SHOPKART</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f5f5f5;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.success-card {
    background: white;
    width: 90%;
    max-width: 550px;
    padding: 40px 25px;
    text-align: center;
    border-radius: 12px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.1);
}

.checkmark {
    width: 85px;
    height: 85px;
    background: #e5f8e9;
    color: #159447;
    border-radius: 50%;
    font-size: 48px;
    line-height: 85px;
    margin: 0 auto 20px;
}

h1 {
    color: #159447;
    margin-bottom: 12px;
}

p {
    color: #555;
    line-height: 1.6;
    margin-bottom: 15px;
}

.order-number {
    background: #fff8df;
    padding: 15px;
    border-radius: 7px;
    margin: 22px 0;
}

.order-number strong {
    display: block;
    margin-top: 8px;
    color: #202020;
    font-size: 20px;
}

.payment {
    color: #159447;
    font-weight: bold;
    margin-bottom: 25px;
}

.btn {
    display: inline-block;
    background: #ff8c00;
    color: white;
    padding: 13px 25px;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
}

.btn:hover {
    background: #e87900;
}
</style>
</head>

<body>

<div class="success-card">

    <div class="checkmark">✓</div>

    <h1>Order Placed Successfully!</h1>

    <p>
        Thank you for shopping with SHOPKART.
        Your order has been received successfully.
    </p>

    <div class="order-number">
        Your Order Number
        <strong><%= orderNumber %></strong>
    </div>

    <div class="payment">
        Payment Method: Cash on Delivery
    </div>

    <p>
        Please pay when your order is delivered.
    </p>

    <a class="btn"
       href="<%= request.getContextPath() %>/products">
       Continue Shopping
    </a>

</div>

</body>
</html>
