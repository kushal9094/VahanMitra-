<%@ page session="true" %>
<%
    String redirect = request.getParameter("redirect");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Login - VahanMitra</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');
    
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: url('https://static.vecteezy.com/system/resources/thumbnails/030/661/949/small/an-empty-road-with-mountains-in-the-background-free-photo.jpg') no-repeat center center/cover;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .login-container {
      width: 800px;
      height: 500px;
      background: #fff;
      box-shadow: 0 15px 50px rgba(0,0,0,0.1);
      display: flex;
    }
    
    .login-image {
      width: 50%;
      height: 100%;
      position: relative;
    }
    
    .login-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .login-form {
      width: 50%;
      padding: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .form-wrapper {
      width: 100%;
    }
    
    .form-title {
      text-align: center;
      font-size: 18px;
      letter-spacing: 2px;
      color: #566573;
      margin-bottom: 10px;
    }
    
    .form-input {
      width: 100%;
      padding: 10px;
      margin: 8px 0;
      background: #f5f5f5;
      border: none;
      font-size: 14px;
      font-family: 'Poppins', sans-serif;
    }
    
    .login-btn {
      background: #566573;
      color: white;
      padding: 10px;
      border: none;
      cursor: pointer;
      font-weight: 500;
      width: 100px;
      font-family: 'Poppins', sans-serif;
      transition: background 0.3s ease;
    }
    
    .login-btn:hover {
      background: #2c3e50;
    }
    
    .error-message {
      color: red;
      font-size: 13px;
      margin-top: 10px;
      text-align: center;
    }
    
    .signup-link {
      margin-top: 20px;
      font-size: 12px;
      text-align: center;
    }
    
    .signup-link a {
      color: #566573;
      font-weight: 600;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    
    .signup-link a:hover {
      color: #2c3e50;
    }
  </style>
</head>
<body>
  <section class="login-container">
    <!-- Left Image -->
    <div class="login-image">
      <img src="https://w0.peakpx.com/wallpaper/114/548/HD-wallpaper-porsche-panamera-car-dark.jpg" alt="Luxury Car">
    </div>

    <!-- Right Form -->
    <div class="login-form">
      <form method="POST" action="login<% if (redirect != null) { %>?redirect=<%= java.net.URLEncoder.encode(redirect, "UTF-8") %><% } %>" class="form-wrapper">
        <h2 class="form-title">Sign In</h2>
        
        <input type="text" name="usernameOrEmail" placeholder="Username or Email" required class="form-input">
        
        <input type="password" name="password" placeholder="Password" required class="form-input">
        
        <button type="submit" class="login-btn">Login</button>

        <!-- Error Message -->
        <% if (error != null) { %>
          <div class="error-message"><%= error %></div>
        <% } %>

        <!-- Link to Sign Up -->
        <p class="signup-link">
          Don't have an account? 
          <a href="signup.jsp<%= redirect != null ? "?redirect=" + java.net.URLEncoder.encode(redirect, "UTF-8") : "" %>">Sign Up.</a>
        </p>
        <p class="signup-link">
          <a href="resetPassword.jsp" style="color: #2c3e50; font-weight: 600; text-decoration: none;">Forgot Password?</a>
        </p>
      </form>
    </div>
  </section>
  
</body>
</html>