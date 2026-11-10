
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SHOPKART - Online Shopping</title>

<link rel="stylesheet"
      href="<%= contextPath %>/css/shopkart-amazon.css">
</head>

<body>

<!-- MAIN HEADER -->
<header class="main-header">

    <a href="<%= contextPath %>/home-new.jsp" class="brand-logo">
        SHOPKART
    </a>

    <div class="delivery-location">
        Deliver to<br>
        <strong>India</strong>
    </div>

    <!-- SEARCH -->
    <form class="header-search"
          action="<%= contextPath %>/products"
          method="get">

        <select name="category">
            <option value="">All</option>
            <option value="Mobiles">Mobiles</option>
            <option value="Electronics">Electronics</option>
            <option value="Fashion">Fashion</option>
        </select>

        <input type="text"
               name="search"
               placeholder="Search SHOPKART products">

        <button type="submit">⌕</button>
    </form>

    <a class="header-action"
       href="<%= contextPath %>/login.jsp">

        <% if (userEmail != null) { %>
            Hello, <strong>Account</strong>
        <% } else { %>
            Hello, Sign in
            <strong>Account & Lists</strong>
        <% } %>

    </a>

    <a class="header-action"
       href="<%= contextPath %>/my-orders">
        Returns & <strong>Orders</strong>
    </a>

    <a class="header-action"
       href="<%= contextPath %>/cart">
        🛒 <strong>Cart</strong>
    </a>

</header>

<!-- NAVIGATION -->
<nav class="main-navigation">

    <a href="<%= contextPath %>/products">☰ All</a>

    <a href="<%= contextPath %>/products?category=Mobiles">
        Mobiles
    </a>

    <a href="<%= contextPath %>/products?category=Electronics">
        Electronics
    </a>

    <a href="<%= contextPath %>/products?category=Fashion">
        Fashion
    </a>

    <a href="<%= contextPath %>/products?category=Watches">
        Watches
    </a>

    <a href="<%= contextPath %>/products?category=Home%20%26%20Kitchen">
        Home &amp; Kitchen
    </a>

    <a href="<%= contextPath %>/products?category=Accessories">
        Accessories
    </a>

</nav>

<!-- MAIN CONTENT -->
<main class="shop-container">

    <!-- HERO SECTION -->
    <section class="hero-section">

        <div class="hero-content">

            <h1>Welcome to SHOPKART</h1>

            <p>Everything You Love. One Place.</p>

            <br>

            <a href="<%= contextPath %>/products"
               class="shop-button">
                Shop Now
            </a>

        </div>

    </section>

    <!-- CATEGORIES -->
    <section class="shop-section">

        <h2 class="section-title">
            Shop by Category
        </h2>

        <div class="category-grid">

            <a class="category-card"
               href="<%= contextPath %>/products?category=Mobiles">
                <h3>Mobiles</h3>
                <p>Explore Smartphones</p>
            </a>

            <a class="category-card"
               href="<%= contextPath %>/products?category=Electronics">
                <h3>Electronics</h3>
                <p>Explore Electronics</p>
            </a>

            <a class="category-card"
               href="<%= contextPath %>/products?category=Fashion">
                <h3>Fashion</h3>
                <p>Explore Fashion</p>
            </a>

            <a class="category-card"
               href="<%= contextPath %>/products?category=Home%20%26%20Kitchen">
                <h3>Home &amp; Kitchen</h3>
                <p>Explore Home Products</p>
            </a>

        </div>

    </section>

    <!-- SHOPPING SECTION -->
    <section class="shop-section">

        <h2 class="section-title">
            Explore All Products
        </h2>

        <p>
            Discover products across mobiles, electronics,
            fashion, watches and accessories.
        </p>

        <br>

        <a href="<%= contextPath %>/products"
           class="shop-button">
            View All Products
        </a>

    </section>

    <!-- ACCOUNT SECTION -->
    <section class="shop-section">

        <h2 class="section-title">Your SHOPKART Account</h2>

        <% if (userEmail != null) { %>

            <p>Welcome back, <%= userEmail %></p>

            <br>

            <a href="<%= contextPath %>/my-orders"
               class="shop-button">
                My Orders
            </a>

        <% } else { %>

            <p>Sign in to manage your shopping and orders.</p>

            <br>

            <a href="<%= contextPath %>/login.jsp"
               class="shop-button">
                Sign In
            </a>

        <% } %>

    </section>

</main>

<!-- FOOTER -->
<footer class="main-footer">

    <h3>SHOPKART</h3>

    <p>Everything You Love. One Place.</p>

    <p>© 2026 SHOPKART. All Rights Reserved.</p>

</footer>

</body>
</html>
