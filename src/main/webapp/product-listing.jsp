
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopkart.model.Product" %>

<%
    List<Product> products =
        (List<Product>) request.getAttribute("products");

    String searchKeyword =
        request.getAttribute("searchKeyword") == null
        ? "" : (String) request.getAttribute("searchKeyword");

    String selectedCategory =
        request.getAttribute("selectedCategory") == null
        ? "" : (String) request.getAttribute("selectedCategory");

    String selectedSort =
        request.getAttribute("selectedSort") == null
        ? "default" : (String) request.getAttribute("selectedSort");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SHOPKART | Products</title>

<link rel="stylesheet"
      href="<%= contextPath %>/css/shopkart-amazon.css">

<link rel="stylesheet"
      href="<%= contextPath %>/css/product-listing.css">

<style>
* {
    box-sizing: border-box;
}

.listing-container {
    max-width: 1500px;
    margin: auto;
    padding: 25px 30px;
}

.listing-toolbar {
    background: white;
    padding: 18px 22px;
    border-radius: 8px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
    margin-bottom: 25px;
}

.listing-search {
    display: flex;
    flex: 1;
    max-width: 750px;
    gap: 10px;
}

.listing-search input {
    flex: 1;
    min-width: 100px;
    height: 46px;
    padding: 10px 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
}

.listing-search button {
    background: #ffbd2e;
    border: 1px solid #e6a700;
    border-radius: 6px;
    padding: 0 25px;
    font-weight: bold;
    cursor: pointer;
}

.sort-select {
    min-width: 210px;
    height: 44px;
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background: white;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 22px;
}

.product-card {
    background: white;
    border: 1px solid #e1e1e1;
    border-radius: 7px;
    padding: 17px;
    transition: box-shadow .2s;
}

.product-card:hover {
    box-shadow: 0 5px 18px rgba(0,0,0,.13);
}

.product-image-container {
    width: 100%;
    height: 205px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

.product-price {
    color: #b12704;
    font-weight: bold;
}

.stock-info {
    color: #168000;
}

.add-cart-btn {
    width: 100%;
    padding: 12px;
    margin-top: 10px;
    background: #ffd814;
    border: 1px solid #f0c000;
    border-radius: 20px;
    cursor: pointer;
    font-weight: bold;
}

.add-cart-btn:hover {
    background: #f7ca00;
}

.add-cart-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
}

/* HAMBURGER MENU */

.menu-trigger {
    background: transparent;
    border: 1px solid #777;
    color: white;
    font-size: 24px;
    padding: 5px 11px;
    cursor: pointer;
    border-radius: 5px;
}

.menu-trigger:hover {
    border-color: white;
}

.menu-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,.55);
    z-index: 9998;
}

.menu-sidebar {
    position: fixed;
    top: 0;
    left: -320px;
    width: 300px;
    max-width: 85%;
    height: 100%;
    background: white;
    z-index: 9999;
    transition: left .3s ease;
    overflow-y: auto;
}

.menu-sidebar.open {
    left: 0;
}

.menu-overlay.open {
    display: block;
}

.menu-heading {
    background: #232f3e;
    color: white;
    padding: 22px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.menu-heading h2 {
    margin: 0;
    font-size: 22px;
}

.menu-close {
    background: transparent;
    border: none;
    color: white;
    font-size: 28px;
    cursor: pointer;
}

.menu-section {
    padding: 15px 20px;
    border-bottom: 1px solid #ddd;
}

.menu-section h3 {
    margin: 0 0 12px;
    font-size: 17px;
}

.menu-sidebar a {
    display: block;
    padding: 11px 5px;
    color: #222;
    text-decoration: none;
    font-size: 15px;
}

.menu-sidebar a:hover {
    background: #f3f3f3;
    color: #e47911;
}

.no-products {
    background: white;
    padding: 50px 20px;
    text-align: center;
    border-radius: 8px;
}

@media(max-width: 900px) {
    .product-grid {
        grid-template-columns: repeat(3, minmax(0, 1fr));
    }
}

@media(max-width: 600px) {
    .product-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .listing-container {
        padding: 15px;
    }
}

@media(max-width: 400px) {
    .product-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<!-- HEADER -->
<header class="amazon-header">

    <!-- HAMBURGER MENU -->
    <button type="button"
            class="menu-trigger"
            onclick="openShopkartMenu()">
        ☰
    </button>

    <!-- LOGO -->
    <div class="logo">
        <a href="<%= contextPath %>/index.jsp">
            SHOPKART
        </a>
    </div>

    <div class="delivery">
        <span>Deliver to</span>
        <strong>India</strong>
    </div>

    <!-- HEADER SEARCH -->
    <form action="<%= contextPath %>/products"
          method="get"
          class="header-search">

        <input type="text"
               name="search"
               placeholder="Search ShopKart products..."
               value="<%= searchKeyword %>">

        <% if (!selectedCategory.isEmpty()) { %>
            <input type="hidden"
                   name="category"
                   value="<%= selectedCategory %>">
        <% } %>

        <button type="submit">Search</button>
    </form>

    <div class="header-links">
        <a href="<%= contextPath %>/login.jsp">Account</a>
        <a href="<%= contextPath %>/my-orders">Orders</a>
        <a href="<%= contextPath %>/cart">Cart</a>
    </div>

</header>

<!-- NAVIGATION -->
<nav class="amazon-nav">
    <a href="<%= contextPath %>/products">All</a>
    <a href="<%= contextPath %>/products?category=Mobiles">Mobiles</a>
    <a href="<%= contextPath %>/products?category=Electronics">Electronics</a>
    <a href="<%= contextPath %>/products?category=Fashion">Fashion</a>
    <a href="<%= contextPath %>/products?category=Home%20%26%20Kitchen">Home & Kitchen</a>
    <a href="<%= contextPath %>/products?category=Watches">Watches</a>
    <a href="<%= contextPath %>/products?category=Accessories">Accessories</a>
</nav>

<!-- SIDEBAR OVERLAY -->
<div id="shopkartOverlay"
     class="menu-overlay"
     onclick="closeShopkartMenu()">
</div>

<!-- SIDEBAR -->
<aside id="shopkartSidebar" class="menu-sidebar">

    <div class="menu-heading">
        <h2>SHOPKART</h2>

        <button type="button"
                class="menu-close"
                onclick="closeShopkartMenu()">
            ×
        </button>
    </div>

    <div class="menu-section">
        <h3>Trending</h3>
        <a href="<%= contextPath %>/products">All Products</a>
        <a href="<%= contextPath %>/products?sort=newest">New Arrivals</a>
    </div>

    <div class="menu-section">
        <h3>Shop by Category</h3>
        <a href="<%= contextPath %>/products?category=Mobiles">Mobiles</a>
        <a href="<%= contextPath %>/products?category=Electronics">Electronics</a>
        <a href="<%= contextPath %>/products?category=Fashion">Fashion</a>
        <a href="<%= contextPath %>/products?category=Home%20%26%20Kitchen">Home & Kitchen</a>
        <a href="<%= contextPath %>/products?category=Watches">Watches</a>
        <a href="<%= contextPath %>/products?category=Accessories">Accessories</a>
    </div>

    <div class="menu-section">
        <h3>Your Account</h3>
        <a href="<%= contextPath %>/login.jsp">Login / Account</a>
        <a href="<%= contextPath %>/my-orders">My Orders</a>
        <a href="<%= contextPath %>/cart">My Cart</a>
        <a href="<%= contextPath %>/index.jsp">Home</a>
    </div>

</aside>

<!-- MAIN CONTENT -->
<main class="listing-container">

    <div class="listing-toolbar">

        <form action="<%= contextPath %>/products"
              method="get"
              class="listing-search">

            <input type="text"
                   name="search"
                   placeholder="Search products..."
                   value="<%= searchKeyword %>">

            <% if (!selectedCategory.isEmpty()) { %>
                <input type="hidden"
                       name="category"
                       value="<%= selectedCategory %>">
            <% } %>

            <button type="submit">Search</button>
        </form>

        <form action="<%= contextPath %>/products"
              method="get">

            <input type="hidden"
                   name="search"
                   value="<%= searchKeyword %>">

            <input type="hidden"
                   name="category"
                   value="<%= selectedCategory %>">

            <select name="sort"
                    class="sort-select"
                    onchange="this.form.submit()">

                <option value="default"
                    <%= "default".equals(selectedSort) ? "selected" : "" %>>
                    Featured
                </option>

                <option value="low"
                    <%= "low".equals(selectedSort) ? "selected" : "" %>>
                    Price: Low to High
                </option>

                <option value="high"
                    <%= "high".equals(selectedSort) ? "selected" : "" %>>
                    Price: High to Low
                </option>

                <option value="newest"
                    <%= "newest".equals(selectedSort) ? "selected" : "" %>>
                    Newest Arrivals
                </option>
            </select>
        </form>

    </div>

    <h2>
        <%= selectedCategory.isEmpty()
            ? "All Products" : selectedCategory %>
    </h2>

    <% if (!searchKeyword.isEmpty()) { %>
        <p>Search results for:
            <strong><%= searchKeyword %></strong>
        </p>
    <% } %>

    <p>
        <%= products == null ? 0 : products.size() %>
        Products Found
    </p>

    <% if (products != null && !products.isEmpty()) { %>

        <div class="product-grid">

            <% for (Product product : products) { %>

                <div class="product-card">

                    <div class="product-image-container">
                        <img
                            src="<%= contextPath %>/<%= product.getImageUrl() %>"
                            alt="<%= product.getProductName() %>"
                            class="product-image">
                    </div>

                    <div class="product-info">

                        <h3><%= product.getProductName() %></h3>

                        <p>
                            <%= product.getDescription() == null
                                ? "" : product.getDescription() %>
                        </p>

                        <h3 class="product-price">
                            ₹<%= String.format("%,.2f", product.getPrice()) %>
                        </h3>

                        <p class="stock-info">
                            <%= product.getStockQuantity() > 0
                                ? "In Stock" : "Out of Stock" %>
                        </p>

                        <!-- ADD TO CART -->
                        <form action="<%= contextPath %>/cart"
                              method="post">

                            <input type="hidden"
                                   name="action"
                                   value="add">

                            <input type="hidden"
                                   name="productId"
                                   value="<%= product.getProductId() %>">

                            <button type="submit"
                                    class="add-cart-btn"
                                    <%= product.getStockQuantity() <= 0
                                        ? "disabled" : "" %>>
                                Add to Cart
                            </button>
                        </form>

                    </div>
                </div>

            <% } %>

        </div>

    <% } else { %>

        <div class="no-products">
            <h2>No Products Found!</h2>
            <p>Try another product name or category.</p>
            <a href="<%= contextPath %>/products">View All Products</a>
        </div>

    <% } %>

</main>

<!-- FOOTER -->
<footer class="amazon-footer">
    <h2>SHOPKART</h2>
    <p>Your Shopping Destination</p>
    <p>© 2026 SHOPKART. All Rights Reserved.</p>
    <a href="<%= contextPath %>/index.jsp">Back to Home</a>
</footer>

<!-- MENU JAVASCRIPT -->
<script>
function openShopkartMenu() {
    document.getElementById("shopkartSidebar")
            .classList.add("open");

    document.getElementById("shopkartOverlay")
            .classList.add("open");
}

function closeShopkartMenu() {
    document.getElementById("shopkartSidebar")
            .classList.remove("open");

    document.getElementById("shopkartOverlay")
            .classList.remove("open");
}

document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        closeShopkartMenu();
    }
});
</script>

</body>
</html>
