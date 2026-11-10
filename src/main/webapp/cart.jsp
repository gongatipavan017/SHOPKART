
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.shopkart.model.CartItem" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<CartItem> cartItems =
        (List<CartItem>) request.getAttribute("cartItems");

    Double cartTotal =
        (Double) request.getAttribute("cartTotal");

    if (cartItems == null) {
        response.sendRedirect(request.getContextPath() + "/cart");
        return;
    }

    if (cartTotal == null) {
        cartTotal = 0.0;
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Shopping Cart | SHOPKART</title>

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

/* Header */
header {
    background: #202020;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 28px;
    font-weight: bold;
}

.logo span {
    color: #ffc928;
}

.header-links {
    display: flex;
    gap: 22px;
}

.header-links a {
    color: white;
    text-decoration: none;
    font-size: 15px;
}

/* Main Container */
.container {
    max-width: 1200px;
    margin: 35px auto;
    padding: 0 20px;
}

.page-title {
    font-size: 27px;
    margin-bottom: 25px;
}

/* Cart Layout */
.cart-layout {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 25px;
}

.cart-card,
.summary-card {
    background: white;
    border-radius: 10px;
    padding: 25px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
}

.cart-card h3,
.summary-card h3 {
    margin-bottom: 22px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
}

/* Cart Item */
.cart-item {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 18px 0;
    border-bottom: 1px solid #eee;
}

.product-image {
    width: 115px;
    height: 115px;
    object-fit: contain;
    border: 1px solid #eee;
    border-radius: 7px;
    padding: 8px;
}

.product-details {
    flex: 1;
}

.product-details h4 {
    font-size: 17px;
    margin-bottom: 10px;
}

.price {
    color: #e87900;
    font-weight: bold;
    font-size: 18px;
    margin-bottom: 8px;
}

.quantity {
    color: #555;
    margin-bottom: 8px;
}

.subtotal {
    font-weight: bold;
    margin-bottom: 12px;
}

.remove-btn {
    background: #fff;
    color: #d32f2f;
    border: 1px solid #d32f2f;
    padding: 7px 13px;
    border-radius: 5px;
    cursor: pointer;
}

.remove-btn:hover {
    background: #d32f2f;
    color: white;
}

/* Summary */
.summary-row {
    display: flex;
    justify-content: space-between;
    margin: 18px 0;
    color: #555;
}

.total-row {
    border-top: 1px solid #ddd;
    padding-top: 18px;
    font-size: 21px;
    font-weight: bold;
    color: #202020;
}

.checkout-btn {
    display: block;
    background: #ff8c00;
    color: white;
    text-align: center;
    padding: 14px;
    margin-top: 20px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
}

.checkout-btn:hover {
    background: #e87900;
}

.continue {
    display: inline-block;
    margin-top: 20px;
    color: #202020;
    text-decoration: none;
    font-weight: bold;
}

/* Empty Cart */
.empty-cart {
    background: white;
    padding: 60px 20px;
    text-align: center;
    border-radius: 10px;
}

.empty-cart h2 {
    margin-bottom: 15px;
}

.shop-btn {
    display: inline-block;
    background: #ff8c00;
    color: white;
    padding: 13px 25px;
    text-decoration: none;
    border-radius: 6px;
    margin-top: 20px;
}

/* Footer */
footer {
    background: #202020;
    color: white;
    text-align: center;
    padding: 20px;
    margin-top: 50px;
}

/* Responsive */
@media(max-width: 800px) {
    .cart-layout {
        grid-template-columns: 1fr;
    }
}

@media(max-width: 500px) {
    header {
        padding: 15px;
    }

    .logo {
        font-size: 22px;
    }

    .header-links {
        gap: 10px;
    }

    .cart-card,
    .summary-card {
        padding: 15px;
    }

    .cart-item {
        gap: 12px;
    }

    .product-image {
        width: 85px;
        height: 85px;
    }
}
</style>
</head>

<body>

<header>
    <div class="logo">SHOP<span>KART</span></div>

    <div class="header-links">
        <a href="<%= contextPath %>/index.jsp">Home</a>
        <a href="<%= contextPath %>/products">Products</a>
        <a href="<%= contextPath %>/logout">Logout</a>
    </div>
</header>

<div class="container">

    <h2 class="page-title">🛒 My Shopping Cart</h2>

    <% if (cartItems.isEmpty()) { %>

        <div class="empty-cart">
            <h2>Your Cart is Empty!</h2>
            <p>Add some products to your shopping cart.</p>

            <a href="<%= contextPath %>/products" class="shop-btn">
                Continue Shopping
            </a>
        </div>

    <% } else { %>

        <div class="cart-layout">

            <div class="cart-card">

                <h3>Cart Items (<%= cartItems.size() %>)</h3>

                <% for (CartItem item : cartItems) { %>

                    <div class="cart-item">

                        <img
                            class="product-image"
                            src="<%= contextPath %>/<%= item.getImageUrl() %>"
                            alt="<%= item.getProductName() %>">

                        <div class="product-details">

                            <h4><%= item.getProductName() %></h4>

                            <div class="price">
                                ₹<%= String.format("%.2f", item.getPrice()) %>
                            </div>

                            <div class="quantity">
                                Quantity: <%= item.getQuantity() %>
                            </div>

                            <div class="subtotal">
                                Subtotal: ₹<%= String.format("%.2f", item.getSubtotal()) %>
                            </div>

                            <form action="<%= contextPath %>/cart"
                                  method="post">

                                <input type="hidden"
                                       name="action"
                                       value="remove">

                                <input type="hidden"
                                       name="cartItemId"
                                       value="<%= item.getCartItemId() %>">

                                <button type="submit" class="remove-btn">
                                    Remove
                                </button>

                            </form>

                        </div>

                    </div>

                <% } %>

                <a href="<%= contextPath %>/products" class="continue">
                    ← Continue Shopping
                </a>

            </div>

            <div class="summary-card">

                <h3>Order Summary</h3>

                <div class="summary-row">
                    <span>Total Items</span>
                    <strong><%= cartItems.size() %></strong>
                </div>

                <div class="summary-row">
                    <span>Delivery Charges</span>
                    <strong style="color:green;">FREE</strong>
                </div>

                <div class="summary-row total-row">
                    <span>Total Amount</span>
                    <span>₹<%= String.format("%.2f", cartTotal) %></span>
                </div>

                <a href="<%= contextPath %>/checkout"
                   class="checkout-btn">
                    Proceed to Checkout
                </a>

            </div>

        </div>

    <% } %>

</div>

<footer>
    <p>© 2026 SHOPKART. Everything You Love. One Place.</p>
</footer>

</body>
</html>
