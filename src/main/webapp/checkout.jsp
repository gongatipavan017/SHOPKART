<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    java.math.BigDecimal total =
        (java.math.BigDecimal) request.getAttribute("cartTotal");

    Integer itemCount =
        (Integer) request.getAttribute("itemCount");

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout | SHOPKART</title>

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
    padding: 18px 7%;
    color: white;
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

header a {
    color: white;
    text-decoration: none;
}

.container {
    max-width: 1100px;
    margin: 35px auto;
    padding: 20px;
}

h2 {
    margin-bottom: 20px;
}

.checkout-layout {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 25px;
}

.card {
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    margin-bottom: 20px;
}

.card h3 {
    margin-bottom: 20px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 12px;
}

.form-group {
    margin-bottom: 16px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}

input, textarea, select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
}

textarea {
    resize: vertical;
    min-height: 85px;
}

.row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
}

.payment-option {
    padding: 15px;
    border: 2px solid #ffc928;
    border-radius: 7px;
    background: #fffbea;
}

.payment-option input {
    width: auto;
    margin-right: 8px;
}

.payment-option label {
    display: inline;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin: 15px 0;
}

.total {
    font-size: 21px;
    font-weight: bold;
    border-top: 1px solid #ddd;
    padding-top: 15px;
}

.place-order {
    width: 100%;
    background: #ff8c00;
    color: white;
    border: none;
    padding: 15px;
    font-size: 17px;
    font-weight: bold;
    border-radius: 7px;
    cursor: pointer;
    margin-top: 20px;
}

.place-order:hover {
    background: #e87900;
}

.error {
    background: #ffe5e5;
    color: #b00020;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 18px;
}

.back-link {
    display: inline-block;
    margin-bottom: 20px;
    color: #202020;
    text-decoration: none;
}

@media(max-width: 750px) {
    .checkout-layout {
        grid-template-columns: 1fr;
    }

    .row {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<header>
    <div class="logo">SHOP<span>KART</span></div>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
</header>

<div class="container">

    <a class="back-link"
       href="<%= request.getContextPath() %>/cart">
       ← Back to Cart
    </a>

    <h2>Checkout</h2>

    <% if ("missing".equals(error)) { %>
        <div class="error">Please fill in all required fields.</div>
    <% } else if ("invalid".equals(error)) { %>
        <div class="error">Please enter a valid 10-digit phone number and 6-digit PIN code.</div>
    <% } else if ("failed".equals(error)) { %>
        <div class="error">Order could not be placed. Please try again.</div>
    <% } %>

    <div class="checkout-layout">

        <div>

            <div class="card">
                <h3>1. Delivery Address</h3>

                <form action="<%= request.getContextPath() %>/checkout"
                      method="post">

                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="fullName"
                               placeholder="Enter your full name"
                               maxlength="100" required>
                    </div>

                    <div class="form-group">
                        <label>Mobile Number *</label>
                        <input type="tel" name="phone"
                               placeholder="10-digit mobile number"
                               pattern="[0-9]{10}"
                               maxlength="10" required>
                    </div>

                    <div class="form-group">
                        <label>Address *</label>
                        <textarea name="addressLine"
                                  placeholder="House number, street, area"
                                  maxlength="255" required></textarea>
                    </div>

                    <div class="row">

                        <div class="form-group">
                            <label>City *</label>
                            <input type="text" name="city"
                                   placeholder="City" required>
                        </div>

                        <div class="form-group">
                            <label>State *</label>
                            <input type="text" name="state"
                                   placeholder="State" required>
                        </div>

                    </div>

                    <div class="row">

                        <div class="form-group">
                            <label>PIN Code *</label>
                            <input type="text" name="pincode"
                                   placeholder="6-digit PIN code"
                                   pattern="[0-9]{6}"
                                   maxlength="6" required>
                        </div>

                        <div class="form-group">
                            <label>Address Type</label>
                            <select name="addressType">
                                <option value="HOME">Home</option>
                                <option value="OFFICE">Office</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>

                    </div>

                    <div class="card">
                        <h3>2. Payment Method</h3>

                        <div class="payment-option">
                            <input type="radio" name="paymentMethod"
                                   value="COD" id="cod" checked>
                            <label for="cod">
                                Cash on Delivery (COD)
                            </label>
                            <p style="margin:10px 0 0 25px;color:#555;">
                                Pay when your order is delivered.
                            </p>
                        </div>
                    </div>

                    <button type="submit" class="place-order">
                        Place Order
                    </button>

                </form>
            </div>

        </div>

        <div class="card">
            <h3>3. Order Summary</h3>

            <div class="summary-row">
                <span>Total Items</span>
                <strong><%= itemCount == null ? 0 : itemCount %></strong>
            </div>

            <div class="summary-row total">
                <span>Total Amount</span>
                <span>
                    ₹<%= total == null ? "0.00" : total.toPlainString() %>
                </span>
            </div>

            <p style="color:green;margin-top:15px;">
                Free Delivery
            </p>

            <p style="color:#666;margin-top:15px;font-size:13px;">
                Your order will be placed using Cash on Delivery.
            </p>
        </div>

    </div>
</div>

</body>
</html>