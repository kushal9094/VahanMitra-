<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Sign Up - VahanMitra</title>
</head>
<body style="margin: 0; font-family: 'Poppins', sans-serif; background: url('https://static.vecteezy.com/system/resources/thumbnails/030/661/949/small/an-empty-road-with-mountains-in-the-background-free-photo.jpg') no-repeat center center/cover; height: 100vh; display: flex; align-items: center; justify-content: center;">
  <section style="width: 800px; height: 500px; background: #fff; box-shadow: 0 15px 50px rgba(0,0,0,0.1); display: flex;">
    
    <!-- Left Form -->
    <div style="width: 50%; padding: 40px; display: flex; align-items: center; justify-content: center;">
      <form action="signup" method="post" style="width: 100%;">
        <h2 style="text-align: center; font-size: 18px; letter-spacing: 2px; color: #555; margin-bottom: 10px;">Create an Account</h2>

        <input type="text" name="username" placeholder="Username" required 
               style="width: 100%; padding: 10px; margin: 8px 0; background: #f5f5f5; border: none; font-size: 14px;">
        
        <input type="email" name="email" placeholder="Email Address" required 
               style="width: 100%; padding: 10px; margin: 8px 0; background: #f5f5f5; border: none; font-size: 14px;">
        
        <input type="password" name="password" placeholder="Create Password" required 
               style="width: 100%; padding: 10px; margin: 8px 0; background: #f5f5f5; border: none; font-size: 14px;">
        
        <input type="submit" value="Sign Up" 
               style="background: #566573; color: white; padding: 10px; border: none; cursor: pointer; font-weight: 500; width: 100px;">
        
        <!-- Success and Error Messages -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div style="color: green; font-size: 13px; margin-top: 10px; text-align: center;"><%= message %></div>
        <%
            }
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div style="color: red; font-size: 13px; margin-top: 10px; text-align: center;"><%= error %></div>
        <%
            }
        %>

        <!-- Link to Login -->
        <p style="margin-top: 20px; font-size: 12px; text-align: center;">
          Already have an account? 
          <a href="login.jsp" style="color: #2c3e50; font-weight: 600; text-decoration: none;">Sign In.</a>
        </p>
      </form>
    </div>

    <!-- Right Image -->
    <div style="width: 50%; height: 100%; position: relative;">
      <img src="https://w0.peakpx.com/wallpaper/114/548/HD-wallpaper-porsche-panamera-car-dark.jpg" style="width: 100%; height: 100%; object-fit: cover;">
    </div>
  </section>
  
</body>
</html>