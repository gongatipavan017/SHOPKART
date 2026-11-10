
<%@ page import="java.util.List" %>
<%@ page import="com.shopkart.model.Product" %>

<%
    String context = request.getContextPath();

    List<Product> products =
        (List<Product>) request.getAttribute("products");

    String userEmail = (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopKart - Products</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f5f5;
        }

        header {
            background: #ffc928;
            padding: 18px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            color: #202020;
            font-size: 28px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links a {
            color: #202020;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }

        .search-section {
            padding: 25px 5%;
            text-align: center;
        }

        .search-section form {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-section input {
            width: 350px;
            max-width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            background: #ff8c00;
            color: white;
            padding: 11px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background: #e67800;
        }

        h2 {
            text-align: center;
            margin: 15px 0 25px;
        }

        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            padding: 20px 5%;
        }

        .product {
            background: white;
            border-radius: 8px;
            padding: 18px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.10);
        }

        .product img {
            width: 100%;
            height: 180px;
            object-fit: contain;
            margin-bottom: 15px;
        }

        .product h3 {
            margin-bottom: 10px;
            color: #202020;
        }

        .price {
            color: #e67800;
            font-size: 20px;
            font-weight: bold;
            margin: 12px 0;
        }

        .product form {
            margin-top: 12px;
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        footer {
            background: #202020;
            color: white;
            text-align: center;
            padding: 18px;
            margin-top: 40px;
        }

        @media(max-width: 600px) {
            header {
                flex-direction: column;
            }

            .nav-links a {
                margin: 5px;
            }
        }
    </style>
</head>

<body>

<header>
    <a class="logo" href="<%= context %>/index.jsp">SHOPKART</a>

    <div class="nav-links">
        <a href="<%= context %>/index.jsp">Home</a>
        <a href="<%= context %>/products">Products</a>
        <a href="<%= context %>/cart">My Cart</a>

        <% if (userEmail != null) { %>
            <a href="<%= context %>/logout">Logout</a>
        <% } else { %>
            <a href="<%= context %>/login.jsp">Login</a>
        <% } %>
    </div>
</header>

<section class="search-section">
    <form action="<%= context %>/products" method="get">
        <input
            type="text"
            name="search"
            placeholder="Search products..."
            value="<%= request.getParameter("search") == null ? "" : request.getParameter("search") %>">

        <button type="submit">Search</button>
    </form>
</section>

<h2>Our Products</h2>

<div class="product-container">

<%
    if (products != null && !products.isEmpty()) {

        for (Product product : products) {
%>

    <div class="product">

        <% if (product.getImageUrl() != null &&
               !product.getImageUrl().trim().isEmpty()) { %>

            <img
                src="<%= context %>/<%= product.getImageUrl() %>"
                alt="<%= product.getProductName() %>">

        <% } else { %>

            <img
                src="https://placehold.co/300x200?text=ShopKart"
                alt="Product image">

        <% } %>

        <h3><%= product.getProductName() %></h3>

        <p class="price">
            ₹ <%= String.format("%.2f", product.getPrice()) %>
        </p>

        <form action="<%= context %>/cart" method="post">

            <input type="hidden" name="action" value="add">

            <input
                type="hidden"
                name="productId"
                value="<%= product.getProductId() %>">

            <button type="submit">Add to Cart</button>

        </form>

    </div>

<%
        }

    } else {
%>

    <div class="empty-message">
        <h3>No Products Available</h3>
        <p>Products will appear here once they are added to the database.</p>
    </div>

<%
    }
%>

</div>

<footer>
    <p>© 2026 SHOPKART. All Rights Reserved.</p>
    <p>EVERYTHING YOU LOVE. ONE PLACE.</p>
</footer>

</body>
</html>
