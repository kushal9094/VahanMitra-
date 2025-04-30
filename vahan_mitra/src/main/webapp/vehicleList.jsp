<%@ page import="java.util.*, com.automobile.model.Car, com.automobile.dao.CarDAO" %>
<%@ page session="true" %>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null && session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp?redirect=vehicleList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Vehicles - VahanMitra</title>
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
        }

        h1 {
            color: #071952;
            text-align: center;
            margin-bottom: 40px;
            font-size: 36px;
            position: relative;
            padding-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 4px;
            background: linear-gradient(90deg, #0B666A, #35A29F);
            border-radius: 2px;
        }

        .page-intro {
            text-align: center;
            max-width: 800px;
            margin: 0 auto 40px;
            color: #444;
            line-height: 1.6;
            font-size: 18px;
        }

        .fuel-section {
            margin-bottom: 50px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .fuel-section:hover {
            transform: translateY(-5px);
        }

        .fuel-title {
            font-size: 28px;
            border-bottom: 3px solid #0B666A;
            padding-bottom: 15px;
            margin-bottom: 30px;
            color: #071952;
            display: flex;
            align-items: center;
        }

        .fuel-icon {
            margin-right: 15px;
            font-size: 28px;
            color: #0B666A;
            background-color: rgba(11, 102, 106, 0.1);
            padding: 10px;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
        }

        .car-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: all 0.4s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
            border: 1px solid #eee;
        }

        .car-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            border-color: #0B666A;
        }

        .car-image-container {
            position: relative;
            overflow: hidden;
            height: 220px;
        }

        .car-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .car-card:hover .car-image {
            transform: scale(1.05);
        }

        .fuel-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #0B666A;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .car-content {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .car-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .car-name {
            font-size: 24px;
            font-weight: bold;
            color: #071952;
            margin-bottom: 8px;
            transition: color 0.3s;
        }

        .car-card:hover .car-name {
            color: #0B666A;
        }

        .car-rating {
            display: flex;
            align-items: center;
            color: #FFD700;
            font-weight: bold;
            background-color: rgba(255, 215, 0, 0.1);
            padding: 5px 10px;
            border-radius: 20px;
        }

        .car-rating .stars {
            margin-right: 8px;
        }

        .car-brand {
            font-weight: 500;
            color: #0B666A;
            font-size: 18px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .car-brand i {
            margin-right: 8px;
        }

        .car-details {
            margin-top: 20px;
            color: #444;
            flex-grow: 1;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
        }

        .car-detail-item {
            display: flex;
            margin-bottom: 12px;
            align-items: center;
        }

        .car-detail-icon {
            margin-right: 12px;
            color: #0B666A;
            width: 20px;
            text-align: center;
            font-size: 16px;
        }

        .car-description {
            margin-top: 20px;
            color: #555;
            line-height: 1.6;
            border-top: 1px solid #eee;
            padding-top: 20px;
            font-size: 15px;
        }

        .car-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .view-details-btn, .rate-btn {
            padding: 10px 20px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .view-details-btn {
            background-color: #0B666A;
            color: white;
            border: 2px solid #0B666A;
        }

        .view-details-btn:hover {
            background-color: #35A29F;
            border-color: #35A29F;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(11, 102, 106, 0.3);
        }

        .view-details-btn i {
            margin-right: 8px;
        }

        .rate-btn {
            background-color: transparent;
            color: #071952;
            border: 2px solid #071952;
        }

        .rate-btn:hover {
            background-color: #071952;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(7, 25, 82, 0.3);
        }

        .rate-btn i {
            margin-right: 8px;
        }

        .no-cars {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            margin: 30px 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            font-size: 18px;
        }

        .fuel-type-nav {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
            background-color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .fuel-type-btn {
            background-color: #f5f7fa;
            color: #071952;
            border: 2px solid #eee;
            padding: 15px 25px;
            margin: 0 10px 10px;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
            z-index: 1;
            min-width: 150px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .fuel-type-btn i {
            font-size: 24px;
            margin-bottom: 10px;
            display: block;
            transition: all 0.3s;
        }

        .fuel-type-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-color: #ddd;
        }

        .fuel-type-btn.active {
            background-color: #0B666A;
            color: white;
            border-color: #0B666A;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(11, 102, 106, 0.2);
        }

        .fuel-type-btn .fuel-count {
            background-color: rgba(7, 25, 82, 0.1);
            color: #071952;
            padding: 3px 8px;
            border-radius: 20px;
            font-size: 12px;
            margin-top: 8px;
            transition: all 0.3s;
        }

        .fuel-type-btn.active .fuel-count {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .search-bar {
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
        }

        .search-input {
            width: 70%;
            max-width: 600px;
            padding: 15px 20px;
            border: none;
            border-radius: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 5px 20px rgba(11, 102, 106, 0.3);
            width: 75%;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .car-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .car-grid {
                grid-template-columns: 1fr;
            }

            .fuel-type-nav {
                flex-direction: row;
                flex-wrap: wrap;
                border-radius: 15px;
            }

            .fuel-type-btn {
                margin: 5px;
                width: auto;
                font-size: 14px;
                padding: 10px 15px;
            }

            .search-input {
                width: 90%;
            }

            h1 {
                font-size: 28px;
            }

            .page-intro {
                font-size: 16px;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fuel-section {
            animation: fadeIn 0.5s ease-out forwards;
        }

        .fuel-section:nth-child(2) {
            animation-delay: 0.1s;
        }

        .fuel-section:nth-child(3) {
            animation-delay: 0.2s;
        }

        .fuel-section:nth-child(4) {
            animation-delay: 0.3s;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="navbar-spacer"></div>

    <div class="container">
        <h1>Browse Vehicles</h1>

        <p class="page-intro">
            Explore our comprehensive collection of vehicles categorized by fuel type.
            Compare specifications, read reviews, and find the perfect vehicle that matches your needs and preferences.
        </p>

        <div class="search-bar">
            <input type="text" class="search-input" id="carSearch" placeholder="Search by name, brand, model or fuel type..." onkeyup="searchCars()">
        </div>

        <%
            CarDAO carDAO = new CarDAO();
            List<Car> allCars = carDAO.getAllCars();

            // Group cars by fuel type
            Map<String, List<Car>> carsByFuelType = new HashMap<String, List<Car>>();

            for (Car car : allCars) {
                String fuelType = car.getFuelType();
                if (fuelType == null) fuelType = "Other";
                if (!carsByFuelType.containsKey(fuelType)) {
                    carsByFuelType.put(fuelType, new ArrayList<Car>());
                }
                carsByFuelType.get(fuelType).add(car);
            }

            // Create a navigation for fuel types
            if (!carsByFuelType.isEmpty()) {
        %>
        <div class="fuel-type-nav">
            <button class="fuel-type-btn active" onclick="showAllFuelTypes()">
                <i class="fas fa-car-side"></i>
                All Types
                <span class="fuel-count"><%= allCars.size() %> vehicles</span>
            </button>
            <%
                for (String fuelType : carsByFuelType.keySet()) {
                    String icon = "fa-gas-pump";
                    if (fuelType.equalsIgnoreCase("Electric")) {
                        icon = "fa-bolt";
                    } else if (fuelType.equalsIgnoreCase("Diesel")) {
                        icon = "fa-oil-can";
                    } else if (fuelType.equalsIgnoreCase("Hybrid")) {
                        icon = "fa-leaf";
                    }
                    int count = carsByFuelType.get(fuelType).size();
            %>
                <button class="fuel-type-btn" onclick="showFuelType('<%= fuelType %>')">
                    <i class="fas <%= icon %>"></i>
                    <%= fuelType %>
                    <span class="fuel-count"><%= count %> <%= count == 1 ? "vehicle" : "vehicles" %></span>
                </button>
            <% } %>
        </div>
        <% } %>

        <%
            // Display cars by fuel type
            for (Map.Entry<String, List<Car>> entry : carsByFuelType.entrySet()) {
                String fuelType = entry.getKey();
                List<Car> cars = entry.getValue();

                // Determine icon based on fuel type
                String fuelIcon = "fa-gas-pump";
                if (fuelType.equalsIgnoreCase("Electric")) {
                    fuelIcon = "fa-bolt";
                } else if (fuelType.equalsIgnoreCase("Diesel")) {
                    fuelIcon = "fa-oil-can";
                } else if (fuelType.equalsIgnoreCase("Hybrid")) {
                    fuelIcon = "fa-leaf";
                }
        %>

        <div class="fuel-section" id="fuel-<%= fuelType.toLowerCase().replace(" ", "-") %>">
            <h2 class="fuel-title">
                <i class="fas <%= fuelIcon %> fuel-icon"></i>
                <%= fuelType %> Vehicles
            </h2>

            <% if (cars.isEmpty()) { %>
                <div class="no-cars">No <%= fuelType %> vehicles available at the moment.</div>
            <% } else { %>
                <div class="car-grid">
                    <% for (Car car : cars) { %>
                        <div class="car-card" data-name="<%= car.getName().toLowerCase() %>" data-brand="<%= car.getBrand().toLowerCase() %>" data-model="<%= car.getModel().toLowerCase() %>" data-fuel="<%= car.getFuelType().toLowerCase() %>">
                            <div class="car-image-container">
                                <% if (car.getImageUrl() != null && !car.getImageUrl().isEmpty()) { %>
                                    <img src="<%= car.getImageUrl() %>" alt="<%= car.getName() %>" class="car-image">
                                <% } else { %>
                                    <img src="https://via.placeholder.com/350x200?text=No+Image+Available" alt="No Image" class="car-image">
                                <% } %>
                                <div class="fuel-badge"><%= car.getFuelType() %></div>
                            </div>

                            <div class="car-content">
                                <div class="car-header">
                                    <div>
                                        <div class="car-name"><%= car.getName() %></div>
                                        <div class="car-brand"><i class="fas fa-building"></i> <%= car.getBrand() %> <%= car.getModel() %></div>
                                    </div>
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
                                        <span><%= car.getReviewCount() %></span>
                                    </div>
                                </div>

                                <div class="car-details">
                                    <div class="car-detail-item">
                                        <i class="fas fa-calendar-alt car-detail-icon"></i>
                                        <span>Year: <%= car.getYear() %></span>
                                    </div>

                                    <% if (car.getEngineDetails() != null && !car.getEngineDetails().isEmpty()) { %>
                                    <div class="car-detail-item">
                                        <i class="fas fa-cogs car-detail-icon"></i>
                                        <span>Engine: <%= car.getEngineDetails() %></span>
                                    </div>
                                    <% } %>

                                    <% if (car.getTransmission() != null && !car.getTransmission().isEmpty()) { %>
                                    <div class="car-detail-item">
                                        <i class="fas fa-tachometer-alt car-detail-icon"></i>
                                        <span>Transmission: <%= car.getTransmission() %></span>
                                    </div>
                                    <% } %>

                                    <% if (car.getMileage() != null && !car.getMileage().isEmpty()) { %>
                                    <div class="car-detail-item">
                                        <i class="fas fa-road car-detail-icon"></i>
                                        <span>Mileage: <%= car.getMileage() %></span>
                                    </div>
                                    <% } %>
                                </div>

                                <div class="car-description">
                                    <%= car.getDescription() != null ? (car.getDescription().length() > 150 ? car.getDescription().substring(0, 150) + "..." : car.getDescription()) : "No description available." %>
                                </div>

                                <div class="car-footer">
                                    <a href="carDetails.jsp?id=<%= car.getId() %>" class="view-details-btn"><i class="fas fa-info-circle"></i> View Details</a>
                                    <% if (session.getAttribute("username") != null) { %>
                                        <a href="rateVehicle.jsp?id=<%= car.getId() %>" class="rate-btn"><i class="fas fa-star"></i> Rate Vehicle</a>
                                    <% } else { %>
                                        <a href="login.jsp?redirect=rateVehicle.jsp?id=<%= car.getId() %>" class="rate-btn"><i class="fas fa-sign-in-alt"></i> Login to Rate</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <% } %>

        <% if (allCars.isEmpty()) { %>
            <div class="no-cars">No vehicles available at the moment. Please check back later.</div>
        <% } %>
    </div>

    <script>
        // JavaScript for fuel type filtering
        function showAllFuelTypes() {
            const fuelSections = document.querySelectorAll('.fuel-section');
            fuelSections.forEach(section => {
                section.style.display = 'block';
            });

            // Update active button
            const buttons = document.querySelectorAll('.fuel-type-btn');
            buttons.forEach(btn => {
                btn.classList.remove('active');
            });
            buttons[0].classList.add('active');

            // Reset search
            document.getElementById('carSearch').value = '';
            searchCars();
        }

        function showFuelType(fuelType) {
            const fuelSections = document.querySelectorAll('.fuel-section');
            fuelSections.forEach(section => {
                if (section.id === 'fuel-' + fuelType.toLowerCase().replace(' ', '-')) {
                    section.style.display = 'block';
                } else {
                    section.style.display = 'none';
                }
            });

            // Update active button
            const buttons = document.querySelectorAll('.fuel-type-btn');
            buttons.forEach(btn => {
                btn.classList.remove('active');
                if (btn.textContent.trim() === fuelType) {
                    btn.classList.add('active');
                }
            });

            // Reset search
            document.getElementById('carSearch').value = '';
            searchCars();
        }

        // Search functionality
        function searchCars() {
            const searchInput = document.getElementById('carSearch').value.toLowerCase();
            const carCards = document.querySelectorAll('.car-card');
            let hasVisibleCars = {};

            carCards.forEach(card => {
                const name = card.getAttribute('data-name');
                const brand = card.getAttribute('data-brand');
                const model = card.getAttribute('data-model');
                const fuel = card.getAttribute('data-fuel');
                const fuelSection = card.closest('.fuel-section');
                const fuelType = fuelSection.id.replace('fuel-', '').replace('-', ' ');

                if (searchInput === '' ||
                    name.includes(searchInput) ||
                    brand.includes(searchInput) ||
                    model.includes(searchInput) ||
                    fuel.includes(searchInput)) {
                    card.style.display = 'flex';
                    hasVisibleCars[fuelType] = true;
                } else {
                    card.style.display = 'none';
                }
            });

            // Show/hide "No cars" message
            document.querySelectorAll('.fuel-section').forEach(section => {
                if (section.style.display !== 'none') {
                    const fuelType = section.id.replace('fuel-', '').replace('-', ' ');
                    const noCarsMsgContainer = section.querySelector('.no-cars');
                    const carGrid = section.querySelector('.car-grid');

                    if (noCarsMsgContainer) {
                        // If there's already a no-cars message
                        if (!hasVisibleCars[fuelType]) {
                            noCarsMsgContainer.style.display = 'block';
                        } else {
                            noCarsMsgContainer.style.display = 'none';
                        }
                    } else if (carGrid) {
                        // Check if all cars in this section are hidden
                        const visibleCars = Array.from(carGrid.querySelectorAll('.car-card')).filter(card =>
                            card.style.display !== 'none'
                        );

                        if (visibleCars.length === 0) {
                            // Create and show "No cars" message if all are filtered out
                            if (!section.querySelector('.search-no-cars')) {
                                const noResultsMsg = document.createElement('div');
                                noResultsMsg.className = 'no-cars search-no-cars';
                                noResultsMsg.textContent = 'No vehicles match your search criteria.';
                                carGrid.parentNode.insertBefore(noResultsMsg, carGrid.nextSibling);
                            } else {
                                section.querySelector('.search-no-cars').style.display = 'block';
                            }
                        } else {
                            // Hide "No cars" message if there are visible cars
                            const searchNoResults = section.querySelector('.search-no-cars');
                            if (searchNoResults) {
                                searchNoResults.style.display = 'none';
                            }
                        }
                    }
                }
            });
        }

        // Initialize with animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation classes to car cards
            const carCards = document.querySelectorAll('.car-card');
            carCards.forEach((card, index) => {
                card.style.animationDelay = (index * 0.05) + 's';
            });
        });
    </script>
</body>
</html>



