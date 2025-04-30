<%@ page import="java.util.*, com.automobile.model.Car, com.automobile.dao.CarDAO" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rate Vehicle - VahanMitra</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .rating-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .car-info {
            display: flex;
            align-items: center;
            padding: 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
        }
        
        .car-image {
            width: 100px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 20px;
        }
        
        .car-details {
            flex-grow: 1;
        }
        
        .car-name {
            font-size: 20px;
            font-weight: bold;
            color: #071952;
            margin-bottom: 5px;
        }
        
        .car-brand {
            font-size: 14px;
            color: #0B666A;
        }
        
        .rating-form {
            padding: 30px;
        }
        
        .form-title {
            font-size: 24px;
            color: #071952;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .rating-stars {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            font-size: 30px;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            cursor: pointer;
            color: #ddd;
            padding: 0 5px;
        }
        
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input:checked ~ label {
            color: #FFD700;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #071952;
        }
        
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            transition: border-color 0.3s;
            box-sizing: border-box;
            resize: vertical;
            min-height: 150px;
        }
        
        textarea:focus {
            border-color: #0B666A;
            outline: none;
            box-shadow: 0 0 0 2px rgba(11, 102, 106, 0.2);
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            border: none;
            font-size: 16px;
        }
        
        .submit-btn {
            background-color: #0B666A;
            color: white;
        }
        
        .submit-btn:hover {
            background-color: #35A29F;
            transform: translateY(-2px);
        }
        
        .cancel-btn {
            background-color: #f8f9fa;
            color: #444;
            border: 1px solid #ddd;
        }
        
        .cancel-btn:hover {
            background-color: #e9ecef;
        }
        
        .error {
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #c62828;
        }
        
        .success {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #2e7d32;
        }
        
        .not-found {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .not-found h2 {
            color: #071952;
            margin-bottom: 20px;
        }
        
        .not-found p {
            color: #444;
            margin-bottom: 30px;
        }
        
        .back-btn {
            background-color: #0B666A;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .back-btn:hover {
            background-color: #35A29F;
        }
        
        .back-btn i {
            margin-right: 5px;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-actions {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="navbar-spacer"></div>
    
    <div class="container">
        <a href="vehicleList.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Vehicles</a>
        
        <%
            // Check if user is logged in
            if (session.getAttribute("username") == null) {
        %>
            <div class="not-found">
                <h2>Login Required</h2>
                <p>You need to be logged in to rate vehicles.</p>
                <a href="login.jsp" class="back-btn">Login Now</a>
            </div>
        <%
            } else {
                // Get car ID from request parameter
                String carIdParam = request.getParameter("id");
                
                if (carIdParam != null && !carIdParam.isEmpty()) {
                    try {
                        int carId = Integer.parseInt(carIdParam);
                        CarDAO carDAO = new CarDAO();
                        Car car = carDAO.getCarById(carId);
                        
                        if (car != null) {
        %>
        
        <div class="rating-container">
            <div class="car-info">
                <% if (car.getImageUrl() != null && !car.getImageUrl().isEmpty()) { %>
                    <img src="<%= car.getImageUrl() %>" alt="<%= car.getName() %>" class="car-image">
                <% } else { %>
                    <img src="https://via.placeholder.com/100x70?text=No+Image" alt="No Image" class="car-image">
                <% } %>
                
                <div class="car-details">
                    <div class="car-name"><%= car.getName() %></div>
                    <div class="car-brand"><%= car.getBrand() %> <%= car.getModel() %> (<%= car.getYear() %>)</div>
                </div>
            </div>
            
            <div class="rating-form">
                <h2 class="form-title">Rate This Vehicle</h2>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="error">Failed to submit your rating. Please try again!</div>
                <% } %>
                
                <% if (request.getParameter("success") != null) { %>
                    <div class="success">Your rating has been submitted successfully!</div>
                <% } %>
                
                <form action="submitRating" method="post">
                    <input type="hidden" name="carId" value="<%= car.getId() %>">
                    
                    <div class="rating-stars">
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5" required>
                            <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star4" name="rating" value="4">
                            <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star3" name="rating" value="3">
                            <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star2" name="rating" value="2">
                            <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" id="star1" name="rating" value="1">
                            <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="review">Your Review (Optional)</label>
                        <textarea id="review" name="review" placeholder="Share your experience with this vehicle..."></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <a href="carDetails.jsp?id=<%= car.getId() %>" class="btn cancel-btn">Cancel</a>
                        <button type="submit" class="btn submit-btn">Submit Rating</button>
                    </div>
                </form>
            </div>
        </div>
        
        <% } else { %>
            <div class="not-found">
                <h2>Vehicle Not Found</h2>
                <p>The vehicle you are trying to rate does not exist or has been removed.</p>
                <a href="vehicleList.jsp" class="back-btn">Browse All Vehicles</a>
            </div>
        <% }
            } catch (NumberFormatException e) { %>
                <div class="not-found">
                    <h2>Invalid Vehicle ID</h2>
                    <p>The vehicle ID provided is not valid.</p>
                    <a href="vehicleList.jsp" class="back-btn">Browse All Vehicles</a>
                </div>
        <%  }
        } else { %>
            <div class="not-found">
                <h2>Vehicle ID Missing</h2>
                <p>No vehicle ID was provided for rating.</p>
                <a href="vehicleList.jsp" class="back-btn">Browse All Vehicles</a>
            </div>
        <% } 
        } %>
    </div>
</body>
</html>
