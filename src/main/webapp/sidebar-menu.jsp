
<%
String ctx = request.getContextPath();
%>

<style>
.menu-trigger {
    background: transparent;
    border: 1px solid #777;
    color: white;
    font-size: 25px;
    padding: 5px 12px;
    cursor: pointer;
    border-radius: 5px;
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
    height: 100%;
    background: white;
    z-index: 9999;
    transition: left .3s ease;
    overflow-y: auto;
    box-shadow: 3px 0 15px rgba(0,0,0,.2);
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
</style>

<button type="button"
        class="menu-trigger"
        onclick="openShopkartMenu()">
    ☰
</button>

<div id="shopkartOverlay"
     class="menu-overlay"
     onclick="closeShopkartMenu()">
</div>

<aside id="shopkartSidebar" class="menu-sidebar">

    <div class="menu-heading">
        <h2>SHOPKART</h2>
        <button class="menu-close"
                onclick="closeShopkartMenu()">×</button>
    </div>

    <div class="menu-section">
        <h3>Trending</h3>
        <a href="<%=ctx%>/products">All Products</a>
        <a href="<%=ctx%>/products?sort=newest">New Arrivals</a>
    </div>

    <div class="menu-section">
        <h3>Shop by Category</h3>
        <a href="<%=ctx%>/products?category=Mobiles">Mobiles</a>
        <a href="<%=ctx%>/products?category=Electronics">Electronics</a>
        <a href="<%=ctx%>/products?category=Fashion">Fashion</a>
        <a href="<%=ctx%>/products?category=Home%20%26%20Kitchen">Home & Kitchen</a>
        <a href="<%=ctx%>/products?category=Watches">Watches</a>
        <a href="<%=ctx%>/products?category=Accessories">Accessories</a>
    </div>

    <div class="menu-section">
        <h3>Your Account</h3>
        <a href="<%=ctx%>/login.jsp">Login / Account</a>
        <a href="<%=ctx%>/my-orders">My Orders</a>
        <a href="<%=ctx%>/cart">My Cart</a>
        <a href="<%=ctx%>/index.jsp">Home</a>
    </div>

</aside>

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
</script>
