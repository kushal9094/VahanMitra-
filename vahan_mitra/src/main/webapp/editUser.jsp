<%@ page import="com.automobile.dao.UserDAO, com.automobile.model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get user ID from request
    int id = Integer.parseInt(request.getParameter("id"));
    User user = UserDAO.getUserById(id);
    
    if (user == null) {
        response.sendRedirect("manageUsers.jsp?error=UserNotFound");
        return;
    }
    
    // Handle form submission
    String message = null;
    String messageType = null;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        
        if (email != null && !email.isEmpty()) {
            user.setEmail(email);
        }
        
        if (newPassword != null && !newPassword.isEmpty()) {
            user.setPassword(newPassword);
        }
        
        boolean updated = UserDAO.updateUserProfile(user);
        if (updated) {
            message = "User updated successfully!";
            messageType = "success";
        } else {
            message = "Failed to update user. Please try again.";
            messageType = "error";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User - VahanMitra</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            color: #333;
        }

        .navbar-spacer {
            height: 80px;
        }

        .container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 100%;
            z-index: 10;
            position: relative;
            margin: 100px auto 40px;
        }

        h2 {
            text-align: center;
            color: #071952;
            margin-bottom: 30px;
            font-size: 32px;
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #0B666A, #35A29F);
            border-radius: 2px;
        }

        .form-intro {
            text-align: center;
            margin-bottom: 30px;
            color: #555;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #071952;
            font-size: 16px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: #f9f9f9;
            color: #333;
        }

        input:focus {
            outline: none;
            border-color: #0B666A;
            box-shadow: 0 0 0 3px rgba(11, 102, 106, 0.2);
            background-color: #fff;
        }

        .submit-btn {
            width: 100%;
            padding: 16px;
            background-color: #0B666A;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .submit-btn:hover {
            background-color: #35A29F;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(11, 102, 106, 0.3);
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #0B666A;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .back-link:hover {
            color: #35A29F;
            transform: translateX(-5px);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 80px 15px 30px;
            }

            h2 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="adminNavbar.jsp" %>

    <div class="navbar-spacer"></div>

    <div class="container">
        <h2>Edit User</h2>
        
        <p class="form-intro">
            Update user information in the VahanMitra database.
        </p>
        
        <% if (message != null) { %>
            <div class="<%= messageType.equals("success") ? "success-message" : "error-message" %>">
                <i class="fas fa-<%= messageType.equals("success") ? "check-circle" : "exclamation-circle" %>"></i>
                <%= message %>
            </div>
        <% } %>
        
        <form action="editUser.jsp?id=<%= user.getId() %>" method="post" id="editUserForm">
            <input type="hidden" name="id" value="<%= user.getId() %>">
            
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" value="<%= user.getUsername() %>" disabled>
                <small style="color: #666; display: block; margin-top: 5px;">Username cannot be changed</small>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword">New Password (leave blank to keep current)</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password">
            </div>
            
            <button type="submit" class="submit-btn">
                <i class="fas fa-save"></i> Update User
            </button>
        </form>
        
        <a href="manageUsers.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to User List
        </a>
    </div>
</body>
</html>
