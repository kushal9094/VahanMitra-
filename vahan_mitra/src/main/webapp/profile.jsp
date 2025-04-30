<%@ page import="com.automobile.model.User, com.automobile.dao.UserDAO, com.automobile.dao.ReviewDAO, java.util.List" %>
<%@ page session="true" %>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?redirect=profile.jsp");
        return;
    }
    
    String username = (String) session.getAttribute("username");
    User user = UserDAO.getUserByUsername(username);
    
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Handle form submission for profile update
    String message = null;
    String messageType = null;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate current password
        if (currentPassword != null && !currentPassword.isEmpty()) {
            if (currentPassword.equals(user.getPassword())) {
                // Check if new password matches confirmation
                if (newPassword != null && !newPassword.isEmpty()) {
                    if (newPassword.equals(confirmPassword)) {
                        // Update password
                        user.setPassword(newPassword);
                        message = "Password updated successfully!";
                        messageType = "success";
                    } else {
                        message = "New password and confirmation do not match.";
                        messageType = "error";
                    }
                }
            } else {
                message = "Current password is incorrect.";
                messageType = "error";
            }
        }
        
        // Update email if provided
        if (email != null && !email.isEmpty() && !email.equals(user.getEmail())) {
            user.setEmail(email);
            if (message == null) {
                message = "Email updated successfully!";
                messageType = "success";
            } else if (messageType.equals("success")) {
                message = "Profile updated successfully!";
            }
        }
        
        // Save changes if there were no errors
        if (messageType == null || messageType.equals("success")) {
            boolean updated = UserDAO.updateUserProfile(user);
            if (!updated) {
                message = "Failed to update profile. Please try again.";
                messageType = "error";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - VahanMitra</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            color: #333;
        }

        .navbar-spacer {
            height: 80px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }

        .profile-sidebar {
            flex: 1;
            min-width: 300px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .profile-content {
            flex: 2;
            min-width: 500px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: #0B666A;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(11, 102, 106, 0.3);
        }

        .profile-name {
            font-size: 24px;
            font-weight: 700;
            color: #071952;
            margin-bottom: 10px;
        }

        .profile-email {
            color: #666;
            margin-bottom: 25px;
        }

        .profile-stats {
            display: flex;
            justify-content: space-around;
            width: 100%;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: #0B666A;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
        }

        .section-title {
            font-size: 24px;
            color: #071952;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 3px solid #0B666A;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: #0B666A;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #071952;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #0B666A;
            box-shadow: 0 0 0 3px rgba(11, 102, 106, 0.2);
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-col {
            flex: 1;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background-color: #0B666A;
            color: white;
        }

        .btn-primary:hover {
            background-color: #35A29F;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(11, 102, 106, 0.3);
        }

        .btn-secondary {
            background-color: #f5f5f5;
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #e0e0e0;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }

        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }

        .tab-nav {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 1px solid #ddd;
        }

        .tab-btn {
            padding: 12px 20px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            font-size: 16px;
            font-weight: 500;
            color: #666;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .tab-btn.active {
            color: #0B666A;
            border-bottom-color: #0B666A;
        }

        .tab-btn:hover:not(.active) {
            color: #35A29F;
            border-bottom-color: #35A29F;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .container {
                flex-direction: column;
            }
            
            .profile-sidebar, .profile-content {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="navbar-spacer"></div>

    <div class="container">
        <div class="profile-sidebar">
            <div class="profile-avatar">
                <%= user.getUsername().substring(0, 1).toUpperCase() %>
            </div>
            <div class="profile-name"><%= user.getUsername() %></div>
            <div class="profile-email"><%= user.getEmail() %></div>
            
            <div class="profile-stats">
                <div class="stat-item">
                    <div class="stat-value">
                        <%= ReviewDAO.getReviewCountByUser(user.getUsername()) %>
                    </div>
                    <div class="stat-label">Reviews</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%= ReviewDAO.getAverageRatingByUser(user.getUsername()) %>
                    </div>
                    <div class="stat-label">Avg. Rating</div>
                </div>
            </div>
        </div>
        
        <div class="profile-content">
            <div class="tab-nav">
                <button class="tab-btn active" onclick="openTab('profile')">
                    <i class="fas fa-user"></i> Profile
                </button>
                <button class="tab-btn" onclick="openTab('security')">
                    <i class="fas fa-lock"></i> Security
                </button>
                <button class="tab-btn" onclick="openTab('activity')">
                    <i class="fas fa-chart-line"></i> Activity
                </button>
            </div>
            
            <% if (message != null) { %>
                <div class="alert alert-<%= messageType %>">
                    <i class="fas fa-<%= messageType.equals("success") ? "check-circle" : "exclamation-circle" %>"></i>
                    <%= message %>
                </div>
            <% } %>
            
            <div id="profile-tab" class="tab-content active">
                <h2 class="section-title">
                    <i class="fas fa-user-edit"></i> Edit Profile
                </h2>
                
                <form action="profile.jsp" method="post">
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
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
            
            <div id="security-tab" class="tab-content">
                <h2 class="section-title">
                    <i class="fas fa-shield-alt"></i> Change Password
                </h2>
                
                <form action="profile.jsp" method="post">
                    <input type="hidden" name="email" value="<%= user.getEmail() %>">
                    
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <label for="newPassword">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" required>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <label for="confirmPassword">Confirm New Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-key"></i> Update Password
                        </button>
                    </div>
                </form>
            </div>
            
            <div id="activity-tab" class="tab-content">
                <h2 class="section-title">
                    <i class="fas fa-history"></i> Recent Activity
                </h2>
                
                <p>Your recent reviews and ratings will appear here.</p>
                
                <div class="form-group">
                    <a href="myReviews.jsp" class="btn btn-secondary">
                        <i class="fas fa-star"></i> View All My Reviews
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function openTab(tabName) {
            // Hide all tab contents
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Remove active class from all tab buttons
            const tabButtons = document.querySelectorAll('.tab-btn');
            tabButtons.forEach(button => {
                button.classList.remove('active');
            });
            
            // Show the selected tab content
            document.getElementById(tabName + '-tab').classList.add('active');
            
            // Add active class to the clicked button
            event.currentTarget.classList.add('active');
        }
    </script>
</body>
</html>
