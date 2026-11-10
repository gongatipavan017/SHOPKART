
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SHOPKART | Create Account</title>

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

.header {
    background: #202020;
    color: white;
    padding: 20px 5%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    color: #ffc928;
    font-size: 28px;
    font-weight: bold;
}

.header a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.container {
    min-height: 80vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 35px 15px;
}

.register-box {
    background: white;
    width: 100%;
    max-width: 470px;
    padding: 35px;
    border-radius: 10px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.10);
}

.register-box h2 {
    text-align: center;
    margin-bottom: 10px;
    font-size: 28px;
}

.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
}

.form-group input {
    width: 100%;
    padding: 13px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 15px;
}

.form-group input:focus {
    outline: none;
    border-color: #ff8c00;
}

.register-btn {
    width: 100%;
    padding: 14px;
    background: #ff8c00;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.register-btn:hover {
    background: #e67800;
}

.message {
    padding: 12px;
    margin-bottom: 18px;
    border-radius: 5px;
    text-align: center;
    font-size: 14px;
}

.error {
    background: #ffe0e0;
    color: #c62828;
}

.success {
    background: #e0ffe5;
    color: #16833b;
}

.login-link {
    text-align: center;
    margin-top: 22px;
}

.login-link a {
    color: #e67800;
    font-weight: bold;
    text-decoration: none;
}

.footer {
    background: #202020;
    color: white;
    text-align: center;
    padding: 25px;
}

@media(max-width: 500px) {
    .register-box {
        padding: 25px 20px;
    }
}
</style>
</head>

<body>

<!-- Header -->
<header class="header">
    <div class="logo">SHOPKART</div>
    <a href="index.jsp">Home</a>
</header>

<!-- Registration Form -->
<div class="container">

    <div class="register-box">

        <h2>Create Account</h2>
        <p class="subtitle">Join SHOPKART today!</p>

        <!-- Error Message -->
        <%
            String error = (String) request.getAttribute("error");

            if (error != null) {
        %>
            <div class="message error">
                <%= error %>
            </div>
        <%
            }
        %>

        <!-- Success Message -->
        <%
            String success = request.getParameter("registered");

            if ("success".equals(success)) {
        %>
            <div class="message success">
                Registration successful! Please login.
            </div>
        <%
            }
        %>

        <form action="register" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input
                    type="text"
                    name="fullName"
                    placeholder="Enter your full name"
                    maxlength="100"
                    required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input
                    type="email"
                    name="email"
                    placeholder="Enter your email"
                    maxlength="150"
                    required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input
                    type="password"
                    name="password"
                    placeholder="Create a password"
                    minlength="8"
                    required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input
                    type="password"
                    name="confirmPassword"
                    placeholder="Confirm your password"
                    minlength="8"
                    required>
            </div>

            <button type="submit" class="register-btn">
                Create Account
            </button>

        </form>

        <div class="login-link">
            Already have an account?
            <a href="login.jsp">Login</a>
        </div>

    </div>

</div>

<!-- Footer -->
<footer class="footer">
    <h3>SHOPKART</h3>
    <p>Everything You Love. One Place.</p>
    <p>© 2026 SHOPKART. All Rights Reserved.</p>
</footer>

</body>
</html>
