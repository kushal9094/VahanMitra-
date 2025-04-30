<%@ page import="java.util.*, com.automobile.model.Review, com.automobile.dao.ReviewDAO, com.automobile.model.Car, com.automobile.dao.CarDAO" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Reviews - Admin Dashboard</title>
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
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        
        .reviews-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        h1 {
            color: #071952;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
        }
        
        .review-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .car-info {
            font-weight: 600;
            color: #071952;
            font-size: 18px;
        }
        
        .user-info {
            color: #0B666A;
            font-size: 14px;
        }
        
        .review-date {
            color: #6c757d;
            font-size: 12px;
            margin-top: 5px;
        }
        
        .rating {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .stars {
            color: #FFD700;
            margin-right: 5px;
        }
        
        .review-text {
            color: #333;
            line-height: 1.5;
            margin-bottom: 15px;
        }
        
        .review-actions {
            display: flex;
            justify-content: flex-end;
        }
        
        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        
        .delete-btn:hover {
            background-color: #c82333;
        }
        
        .no-reviews {
            text-align: center;
            padding: 50px 0;
            color: #6c757d;
            font-style: italic;
        }
        
        .filters {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-group {
            margin-bottom: 10px;
        }
        
        .filter-label {
            font-weight: 600;
            color: #071952;
            margin-right: 10px;
        }
        
        select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: white;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .page-btn {
            background-color: white;
            border: 1px solid #ddd;
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .page-btn:hover, .page-btn.active {
            background-color: #0B666A;
            color: white;
            border-color: #0B666A;
        }
        
        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #2e7d32;
        }
    </style>
</head>
<body>
    <%@ include file="adminNavbar.jsp" %>
    
    <div class="container">
        <div class="reviews-container">
            <h1>All Vehicle Reviews</h1>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="success-message">Review deleted successfully!</div>
            <% } %>
            
            <div class="filters">
                <div class="filter-group">
                    <span class="filter-label">Filter by Car:</span>
                    <select id="carFilter" onchange="filterReviews()">
                        <option value="all">All Cars</option>
                        <%
                            CarDAO carDAO = new CarDAO();
                            List<Car> allCars = carDAO.getAllCars();
                            for (Car car : allCars) {
                        %>
                            <option value="<%= car.getId() %>"><%= car.getBrand() %> <%= car.getModel() %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="filter-group">
                    <span class="filter-label">Sort by:</span>
                    <select id="sortFilter" onchange="filterReviews()">
                        <option value="date-desc">Newest First</option>
                        <option value="date-asc">Oldest First</option>
                        <option value="rating-desc">Highest Rating</option>
                        <option value="rating-asc">Lowest Rating</option>
                    </select>
                </div>
            </div>
            
            <%
                ReviewDAO reviewDAO = new ReviewDAO();
                List<Review> allReviews = reviewDAO.getAllReviews();
                
                if (allReviews.isEmpty()) {
            %>
                <div class="no-reviews">No reviews available at the moment.</div>
            <% } else {
                for (Review review : allReviews) {
                    Car car = carDAO.getCarById(review.getCarId());
            %>
                <div class="review-card" data-car-id="<%= review.getCarId() %>" data-rating="<%= review.getRating() %>" data-date="<%= review.getReviewDate().getTime() %>">
                    <div class="review-header">
                        <div>
                            <div class="car-info"><%= car.getBrand() %> <%= car.getModel() %> (<%= car.getYear() %>)</div>
                            <div class="user-info">Reviewed by: <%= review.getUsername() %></div>
                            <div class="review-date"><%= review.getReviewDate() %></div>
                        </div>
                        <div class="rating">
                            <div class="stars">
                                <% for (int i = 1; i <= 5; i++) { %>
                                    <% if (i <= review.getRating()) { %>
                                        <i class="fas fa-star"></i>
                                    <% } else { %>
                                        <i class="far fa-star"></i>
                                    <% } %>
                                <% } %>
                            </div>
                            <span><%= review.getRating() %>/5</span>
                        </div>
                    </div>
                    
                    <div class="review-text">
                        <%= review.getReviewText() != null && !review.getReviewText().isEmpty() ? review.getReviewText() : "No comment provided." %>
                    </div>
                    
                    <div class="review-actions">
                        <form action="deleteReview" method="post" onsubmit="return confirm('Are you sure you want to delete this review?');">
                            <input type="hidden" name="reviewId" value="<%= review.getId() %>">
                            <input type="hidden" name="admin" value="true">
                            <button type="submit" class="delete-btn">Delete Review</button>
                        </form>
                    </div>
                </div>
            <% }
            } %>
            
            <!-- Pagination (simplified for now) -->
            <div class="pagination">
                <button class="page-btn active">1</button>
                <!-- Add more pagination buttons as needed -->
            </div>
        </div>
    </div>
    
    <script>
        function filterReviews() {
            const carFilter = document.getElementById('carFilter').value;
            const sortFilter = document.getElementById('sortFilter').value;
            
            const reviewCards = document.querySelectorAll('.review-card');
            
            // Filter by car
            reviewCards.forEach(card => {
                if (carFilter === 'all' || card.dataset.carId === carFilter) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Sort reviews
            const visibleCards = Array.from(reviewCards).filter(card => card.style.display !== 'none');
            
            visibleCards.sort((a, b) => {
                if (sortFilter === 'date-desc') {
                    return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                } else if (sortFilter === 'date-asc') {
                    return parseInt(a.dataset.date) - parseInt(b.dataset.date);
                } else if (sortFilter === 'rating-desc') {
                    return parseInt(b.dataset.rating) - parseInt(a.dataset.rating);
                } else if (sortFilter === 'rating-asc') {
                    return parseInt(a.dataset.rating) - parseInt(b.dataset.rating);
                }
                return 0;
            });
            
            // Reorder the cards
            const container = document.querySelector('.reviews-container');
            const pagination = document.querySelector('.pagination');
            
            visibleCards.forEach(card => {
                container.insertBefore(card, pagination);
            });
        }
    </script>
</body>
</html>
