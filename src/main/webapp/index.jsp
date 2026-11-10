
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SHOPKART | Online Shopping</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f5f5f5;
    color: #222;
}

.header {
    background: #202020;
    color: white;
    padding: 20px 5%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 20px;
}

.logo {
    color: #ffae00;
    font-size: 30px;
    font-weight: bold;
    text-decoration: none;
}

.search-box {
    display: flex;
    flex: 1;
    max-width: 500px;
}

.search-box input {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 5px 0 0 5px;
    outline: none;
}

.search-box button {
    padding: 12px 20px;
    border: none;
    background: #ff8c00;
    color: white;
    cursor: pointer;
    border-radius: 0 5px 5px 0;
}

.user-links {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
}

.user-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.user-links a:hover {
    color: #ffae00;
}

.welcome {
    color: #ffca28;
}

nav {
    background: #ffae00;
    padding: 15px 5%;
    display: flex;
    gap: 25px;
    flex-wrap: wrap;
}

nav a {
    color: #202020;
    text-decoration: none;
    font-weight: bold;
}

nav a:hover {
    color: white;
}

.container {
    width: 90%;
    margin: 30px auto;
}

.hero {
    background: linear-gradient(120deg, #ffb300, #ff8000);
    padding: 75px 20px;
    text-align: center;
    border-radius: 15px;
    margin-bottom: 40px;
}

.hero h1 {
    font-size: 38px;
    margin-bottom: 15px;
}

.hero p {
    font-size: 19px;
    margin-bottom: 25px;
}

.shop-btn {
    display: inline-block;
    background: #202020;
    color: white;
    padding: 14px 30px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
}

.shop-btn:hover {
    background: #444;
}

.section-title {
    font-size: 27px;
    margin-bottom: 25px;
}

.categories {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 20px;
    margin-bottom: 40px;
}

.category-card {
    display: block;
    background: white;
    padding: 30px 10px;
    text-align: center;
    border-radius: 10px;
    text-decoration: none;
    color: #222;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.category-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
}

.category-icon {
    display: block;
    font-size: 42px;
    margin-bottom: 15px;
}

.category-name {
    display: block;
    font-size: 17px;
    font-weight: bold;
}

.featured {
    background: white;
    padding: 35px;
    border-radius: 10px;
    text-align: center;
    margin-bottom: 40px;
}

.featured p {
    margin-bottom: 20px;
    color: #555;
}

footer {
    background: #202020;
    color: white;
    text-align: center;
    padding: 35px 15px;
}

footer h2 {
    margin-bottom: 12px;
}

footer p {
    margin: 8px 0;
}

@media(max-width: 900px) {
    .categories {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media(max-width: 600px) {
    .header {
        flex-direction: column;
        align-items: stretch;
    }

    .categories {
        grid-template-columns: repeat(2, 1fr);
    }

    .hero h1 {
        font-size: 28px;
    }

    nav {
        gap: 15px;
    }
}
</style>
</head>

<body>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String context = request.getContextPath();
%>

<!-- HEADER -->
<header class="header">

    <a href="<%=context%>/index.jsp" class="logo">
        SHOPKART
    </a>

    <form class="search-box" action="<%=context%>/products" method="get">
        <input type="text" name="search"
               placeholder="Search products...">
        <button type="submit">Search</button>
    </form>

    <div class="user-links">

        <% if (userEmail != null) { %>

            <span class="welcome">
                Welcome, <%=userEmail%>
            </span>

            <a href="<%=context%>/logout">Logout</a>

        <% } else { %>

            <a href="<%=context%>/login.jsp">Login</a>
            <a href="<%=context%>/register.jsp">Register</a>

        <% } %>

    </div>

</header>

<!-- NAVIGATION -->
<nav>
    <a href="<%=context%>/index.jsp">Home</a>
    <a href="<%=context%>/products">All Products</a>
    <a href="<%=context%>/products?category=Mobiles">Mobiles</a>
    <a href="<%=context%>/products?category=Electronics">Electronics</a>
    <a href="<%=context%>/products?category=Fashion">Fashion</a>
    <a href="<%=context%>/products?category=Watches">Watches</a>
    <a href="<%=context%>/products?category=Accessories">Accessories</a>
    <a href="<%=context%>/products?category=Home%20%26%20Kitchen">Home &amp; Kitchen</a>
</nav>

<!-- MAIN CONTENT -->
<main class="container">

    <!-- HERO SECTION -->
    <section class="hero">

        <h1>Welcome to SHOPKART!</h1>

        <p>
            Discover amazing products at exciting prices.
        </p>

        <a href="<%=context%>/products" class="shop-btn">
            Start Shopping
        </a>

    </section>

    <!-- CATEGORY SECTION -->
    <section>

        <h2 class="section-title">
            Shop By Categories
        </h2>

        <div class="categories">

            <a class="category-card"
               href="<%=context%>/products?category=Mobiles">
                <span class="category-icon">📱</span>
                <span class="category-name">Mobiles</span>
            </a>

            <a class="category-card"
               href="<%=context%>/products?category=Electronics">
                <span class="category-icon">💻</span>
                <span class="category-name">Electronics</span>
            </a>

            <a class="category-card"
               href="<%=context%>/products?category=Fashion">
                <span class="category-icon">👕</span>
                <span class="category-name">Fashion</span>
            </a>

            <a class="category-card"
               href="<%=context%>/products?category=Watches">
                <span class="category-icon">⌚</span>
                <span class="category-name">Watches</span>
            </a>

            <a class="category-card"
               href="<%=context%>/products?category=Accessories">
                <span class="category-icon">🎧</span>
                <span class="category-name">Accessories</span>
            </a>

            <a class="category-card"
               href="<%=context%>/products?category=Home%20%26%20Kitchen">
                <span class="category-icon">🏠</span>
                <span class="category-name">Home &amp; Kitchen</span>
            </a>

        </div>

    </section>

    <!-- FEATURED PRODUCTS -->
    <section>

        <h2 class="section-title">
            Featured Products
        </h2>

        <div class="featured">

            <p>
                Explore our latest products and exciting offers.
            </p>

            <a href="<%=context%>/products" class="shop-btn">
                View All Products
            </a>

        </div>

    </section>

</main>

<!-- FOOTER -->
<footer>

    <h2>SHOPKART</h2>

    <p>Everything You Love. One Place.</p>

    <p>© 2026 SHOPKART. All Rights Reserved.</p>

</footer>

</body>
</html>
