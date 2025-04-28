<%@ page session="true" %>
<%
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Reset Password - VahanMitra</title>
  <style>
    
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
    
    .reset-container {
      width: 600px;
      height: 400px;
      background: #fff;
      box-shadow: 0 15px 50px rgba(0,0,0,0.1);
      padding: 40px;
    }
    
    .reset-form {
      width: 100%;
    }
  </style>
</head>
<body>
  <div class="reset-container">
    <form method="POST" action="resetPassword" class="reset-form">
      <h2 style="text-align: center; margin-bottom: 20px; color: #566573;">Reset Password</h2>
      
      <input type="email" name="email" placeholder="Enter your email" required 
       class="form-input"
       onblur="validateResetEmail(this)">

<!-- Add error display below email input -->
<div id="email-error" class="error-message"></div>
      
      <input type="password" name="newPassword" placeholder="New Password" required 
             class="form-input">
      
      <button type="submit" class="login-btn">Reset Password</button>

      <% if (error != null) { %>
        <div class="error-message"><%= error %></div>
      <% } %>
      <% if (message != null) { %>
        <div class="error-message" style="color: green;"><%= message %></div>
      <% } %>
    </form>
  </div>
  <script>
    function validateResetEmail(input) {
        const email = input.value;
        const errorDiv = document.getElementById('email-error');
        
        // Simple client-side check
        if(!email.includes('@')) {
            errorDiv.textContent = 'Please enter a valid email address';
            return;
        }
        
        // Clear error message
        errorDiv.textContent = '';
    }
    </script>
</body>
</html>