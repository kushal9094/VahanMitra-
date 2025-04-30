<%@ page import="java.util.*, com.automobile.model.Car, com.automobile.dao.CarDAO" %>
<%@ page session="true" %>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null && session.getAttribute("admin") == null) {
        String carId = request.getParameter("id");
        if (carId != null && !carId.isEmpty()) {
            response.sendRedirect("login.jsp?redirect=carDetails.jsp?id=" + carId);
        } else {
            response.sendRedirect("login.jsp?redirect=vehicleList.jsp");
        }
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Details - VahanMitra</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .car-details-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .car-header {
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .car-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        .car-title-section {
            background: linear-gradient(to bottom, rgba(0,0,0,0) 0%, rgba(0,0,0,0.8) 100%);
            padding: 20px;
            position: absolute;
            bottom: 0;
            width: 100%;
            box-sizing: border-box;
            color: white;
        }

        .car-name {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .car-brand {
            font-size: 18px;
            opacity: 0.9;
        }

        .car-content {
            padding: 30px;
        }

        .car-rating-section {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .car-rating {
            display: flex;
            align-items: center;
            color: #FFD700;
            font-weight: bold;
            font-size: 18px;
            margin-right: 20px;
        }

        .car-rating .stars {
            margin-right: 10px;
        }

        .rate-btn {
            background-color: #071952;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .rate-btn:hover {
            background-color: #0B4D89;
        }

        .car-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .info-title {
            font-size: 16px;
            font-weight: 500;
            color: #071952;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .info-icon {
            margin-right: 10px;
            color: #0B666A;
            width: 20px;
            text-align: center;
        }

        .info-content {
            font-size: 15px;
            color: #444;
        }

        .car-description-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 22px;
            color: #071952;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #0B666A;
        }

        .car-description {
            line-height: 1.6;
            color: #444;
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

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .car-image {
                height: 250px;
            }

            .car-name {
                font-size: 24px;
            }

            .car-content {
                padding: 20px;
            }

            .car-info-grid {
                grid-template-columns: 1fr;
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
            // Get car ID from request parameter
            String carIdParam = request.getParameter("id");

            if (carIdParam != null && !carIdParam.isEmpty()) {
                try {
                    int carId = Integer.parseInt(carIdParam);
                    CarDAO carDAO = new CarDAO();
                    Car car = carDAO.getCarById(carId);

                    if (car != null) {
        %>

        <div class="car-details-container">
            <div class="car-header">
                <% if (car.getImageUrl() != null && !car.getImageUrl().isEmpty()) { %>
                    <img src="<%= car.getImageUrl() %>" alt="<%= car.getName() %>" class="car-image">
                <% } else { %>
                    <img src="https://via.placeholder.com/1200x400?text=No+Image+Available" alt="No Image" class="car-image">
                <% } %>

                <div class="car-title-section">
                    <div class="car-name"><%= car.getName() %></div>
                    <div class="car-brand"><%= car.getBrand() %> <%= car.getModel() %> (<%= car.getYear() %>)</div>
                </div>
            </div>

            <div class="car-content">
                <div class="car-rating-section">
                    <div class="car-rating">
                        <div class="stars">
                            <%
                                double rating = car.getAverageRating();
                                for (int i = 1; i <= 5; i++) {
                                    if (i <= rating) {
                            %>
                                <i class="fas fa-star"></i>
                            <% } else if (i - 0.5 <= rating) { %>
                                <i class="fas fa-star-half-alt"></i>
                            <% } else { %>
                                <i class="far fa-star"></i>
                            <% } } %>
                        </div>
                        <span><%= car.getAverageRating() %> (<%= car.getReviewCount() %> reviews)</span>
                    </div>

                    <% if (session.getAttribute("username") != null) { %>
                        <a href="rateVehicle.jsp?id=<%= car.getId() %>" class="rate-btn">Rate This Vehicle</a>
                    <% } else { %>
                        <a href="login.jsp?redirect=rateVehicle.jsp?id=<%= car.getId() %>" class="rate-btn">Login to Rate</a>
                    <% } %>
                </div>

                <div class="car-info-grid">
                    <div class="info-card">
                        <div class="info-title">
                            <i class="fas fa-gas-pump info-icon"></i>
                            Fuel Type
                        </div>
                        <div class="info-content"><%= car.getFuelType() %></div>
                    </div>

                    <% if (car.getEngineDetails() != null && !car.getEngineDetails().isEmpty()) { %>
                    <div class="info-card">
                        <div class="info-title">
                            <i class="fas fa-cogs info-icon"></i>
                            Engine
                        </div>
                        <div class="info-content"><%= car.getEngineDetails() %></div>
                    </div>
                    <% } %>

                    <% if (car.getTransmission() != null && !car.getTransmission().isEmpty()) { %>
                    <div class="info-card">
                        <div class="info-title">
                            <i class="fas fa-tachometer-alt info-icon"></i>
                            Transmission
                        </div>
                        <div class="info-content"><%= car.getTransmission() %></div>
                    </div>
                    <% } %>

                    <% if (car.getMileage() != null && !car.getMileage().isEmpty()) { %>
                    <div class="info-card">
                        <div class="info-title">
                            <i class="fas fa-road info-icon"></i>
                            Mileage
                        </div>
                        <div class="info-content"><%= car.getMileage() %></div>
                    </div>
                    <% } %>

                    <% if (car.getSafetyFeatures() != null && !car.getSafetyFeatures().isEmpty()) { %>
                    <div class="info-card">
                        <div class="info-title">
                            <i class="fas fa-shield-alt info-icon"></i>
                            Safety Features
                        </div>
                        <div class="info-content"><%= car.getSafetyFeatures() %></div>
                    </div>
                    <% } %>
                </div>

                <div class="car-description-section">
                    <h3 class="section-title">Description</h3>
                    <div class="car-description">
                        <%= car.getDescription() %>
                    </div>
                </div>
            </div>
        </div>

        <% } else { %>
            <div class="not-found">
                <h2>Vehicle Not Found</h2>
                <p>The vehicle you are looking for does not exist or has been removed.</p>
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
                <p>No vehicle ID was provided.</p>
                <a href="vehicleList.jsp" class="back-btn">Browse All Vehicles</a>
            </div>
        <% } %>
    </div>
</body>
</html>
