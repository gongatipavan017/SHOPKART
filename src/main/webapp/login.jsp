
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SHOPKART | Login</title>

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
    padding: 25px;
}

.login-container {
    width: 100%;
    max-width: 500px;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.10);
}

.logo {
    text-align: center;
    color: #ff8c00;
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 25px;
}

h1 {
    text-align: center;
    color: #202020;
    margin-bottom: 10px;
    font-size: 32px;
}

.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
    font-size: 18px;
}

.form-group {
    margin-bottom: 22px;
}

label {
    display: block;
    font-size: 17px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #202020;
}

input {
    width: 100%;
    padding: 15px;
    border: 1px solid #ccc;
    border-radius: 7px;
    font-size: 16px;
}

input:focus {
    outline: none;
    border-color: #ff8c00;
}

.login-btn {
    width: 100%;
    padding: 16px;
    background: #ff8c00;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
}

.login-btn:hover {
    background: #e87900;
}

.register-link {
    text-align: center;
    margin-top: 25px;
    font-size: 17px;
}

.register-link a {
    color: #ff8c00;
    text-decoration: none;
    font-weight: bold;
}

.home-link {
    text-align: center;
    margin-top: 20px;
}

.home-link a {
    color: #202020;
    text-decoration: none;
}

.error-message {
    background: #ffe0e0;
    color: #d00000;
    padding: 12px;
    text-align: center;
    border-radius: 6px;
    margin-bottom: 20px;
}

</style>
</head>

<body>

<div class="login-container">

    <div class="logo">SHOPKART</div>

    <h1>Welcome Back!</h1>

    <p class="subtitle">
        Login to your SHOPKART account
    </p>

    <%
        String error = request.getParameter("error");

        if ("invalid".equals(error)) {
    %>
        <div class="error-message">
            Invalid email or password.
        </div>
    <%
        } else if ("empty".equals(error)) {
    %>
        <div class="error-message">
            Please enter email and password.
        </div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <div class="form-group">
            <label>Email Address</label>

            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>
        </div>

        <div class="form-group">
            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter your password"
                   required>
        </div>

        <button type="submit" class="login-btn">
            Login
        </button>

    </form>

    <div class="register-link">
        Don't have an account?
        <a href="register.jsp">Create Account</a>
    </div>

    <div class="home-link">
        <a href="index.jsp">← Back to Home</a>
    </div>

</div>

</body>
</html>
