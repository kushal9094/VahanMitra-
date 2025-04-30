<%@ page import="java.util.*, com.automobile.model.Review, com.automobile.dao.ReviewDAO, com.automobile.dao.CarDAO, com.automobile.model.Car" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reviews - VahanMitra</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .navbar-spacer {
            height: 80px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        h1 {
            color: #071952;
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
            position: relative;
            padding-bottom: 15px;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: #0B666A;
        }
        
        .reviews-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 30px;
            padding: 20px;
        }
        
        .no-reviews {
            text-align: center;
            padding: 50px;
            color: #666;
            font-style: italic;
        }
        
        .review-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        
        .car-info {
            display: flex;
            align-items: center;
        }
        
        .car-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }
        
        .car-details {
            flex-grow: 1;
        }
        
        .car-name {
            font-size: 18px;
            font-weight: bold;
            color: #071952;
            margin-bottom: 5px;
        }
        
        .car-brand {
            font-size: 14px;
            color: #0B666A;
        }
        
        .review-rating {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        
        .stars {
            color: #FFD700;
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .review-date {
            font-size: 12px;
            color: #777;
        }
        
        .review-content {
            color: #444;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .review-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            border: none;
            font-size: 14px;
        }
        
        .edit-btn {
            background-color: #0B666A;
            color: white;
        }
        
        .edit-btn:hover {
            background-color: #35A29F;
        }
        
        .delete-btn {
            background-color: #c62828;
            color: white;
        }
        
        .delete-btn:hover {
            background-color: #e53935;
        }
        
        .view-btn {
            background-color: #071952;
            color: white;
        }
        
        .view-btn:hover {
            background-color: #0B4D89;
        }
        
        .login-required {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .login-required h2 {
            color: #071952;
            margin-bottom: 20px;
        }
        
        .login-required p {
            color: #444;
            margin-bottom: 30px;
        }
        
        .login-btn {
            background-color: #0B666A;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        
        .login-btn:hover {
            background-color: #35A29F;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .review-header {
                flex-direction: column;
            }
            
            .review-rating {
                align-items: flex-start;
                margin-top: 10px;
            }
            
            .car-info {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="navbar-spacer"></div>
    
    <div class="container">
        <h1>My Reviews</h1>
        
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            if (username == null) {
        %>
            <div class="login-required">
                <h2>Login Required</h2>
                <p>You need to be logged in to view your reviews.</p>
                <a href="login.jsp" class="login-btn">Login Now</a>
            </div>
        <%
            } else {
                // Get user's reviews
                ReviewDAO reviewDAO = new ReviewDAO();
                List<Review> userReviews = reviewDAO.getReviewsByUsername(username);
                
                if (userReviews.isEmpty()) {
        %>
            <div class="reviews-container">
                <div class="no-reviews">
                    <p>You haven't reviewed any vehicles yet.</p>
                    <a href="vehicleList.jsp" class="btn view-btn">Browse Vehicles</a>
                </div>
            </div>
        <%
                } else {
        %>
            <div class="reviews-container">
                <% 
                    CarDAO carDAO = new CarDAO();
                    for (Review review : userReviews) {
                        Car car = carDAO.getCarById(review.getCarId());
                        if (car != null) {
                %>
                <div class="review-card">
                    <div class="review-header">
                        <div class="car-info">
                            <% if (car.getImageUrl() != null && !car.getImageUrl().isEmpty()) { %>
                                <img src="<%= car.getImageUrl() %>" alt="<%= car.getName() %>" class="car-image">
                            <% } else { %>
                                <img src="https://via.placeholder.com/80x60?text=No+Image" alt="No Image" class="car-image">
                            <% } %>
                            
                            <div class="car-details">
                                <div class="car-name"><%= car.getName() %></div>
                                <div class="car-brand"><%= car.getBrand() %> <%= car.getModel() %> (<%= car.getYear() %>)</div>
                            </div>
                        </div>
                        
                        <div class="review-rating">
                            <div class="stars">
                                <% for (int i = 1; i <= 5; i++) { %>
                                    <% if (i <= review.getRating()) { %>
                                        <i class="fas fa-star"></i>
                                    <% } else { %>
                                        <i class="far fa-star"></i>
                                    <% } %>
                                <% } %>
                            </div>
                            <div class="review-date">
                                <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(review.getReviewDate()) %>
                            </div>
                        </div>
                    </div>
                    
                    <div class="review-content">
                        <% if (review.getReviewText() != null && !review.getReviewText().isEmpty()) { %>
                            <%= review.getReviewText() %>
                        <% } else { %>
                            <em>No written review provided.</em>
                        <% } %>
                    </div>
                    
                    <div class="review-actions">
                        <a href="carDetails.jsp?id=<%= car.getId() %>" class="btn view-btn">View Vehicle</a>
                        <a href="rateVehicle.jsp?id=<%= car.getId() %>" class="btn edit-btn">Edit Review</a>
                        <a href="deleteReview?id=<%= review.getId() %>" class="btn delete-btn" onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                    </div>
                </div>
                <% 
                        }
                    } 
                %>
            </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>
