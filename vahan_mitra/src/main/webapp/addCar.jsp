<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Car - VahanMitra</title>
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
            max-width: 800px;
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
        input[type="number"],
        input[type="url"],
        textarea,
        select {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: #f9f9f9;
            color: #333;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #0B666A;
            box-shadow: 0 0 0 3px rgba(11, 102, 106, 0.2);
            background-color: #fff;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-col {
            flex: 1;
        }

        .fuel-type-selector {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        .fuel-type-option {
            flex: 1;
            min-width: 120px;
        }

        .fuel-type-label {
            display: block;
            padding: 15px;
            text-align: center;
            border: 2px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .fuel-type-input {
            position: absolute;
            opacity: 0;
        }

        .fuel-type-input:checked + .fuel-type-label {
            border-color: #0B666A;
            background-color: rgba(11, 102, 106, 0.1);
            color: #0B666A;
            font-weight: 500;
        }

        .fuel-icon {
            display: block;
            font-size: 24px;
            margin-bottom: 10px;
            color: #071952;
        }

        .fuel-type-input:checked + .fuel-type-label .fuel-icon {
            color: #0B666A;
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

        /* Car animation */
        .car-animation {
            position: absolute;
            bottom: 50px;
            left: -200px;
            width: 120px;
            height: 60px;
            z-index: 1;
            animation: drive 15s linear infinite;
        }

        .car-body {
            position: absolute;
            width: 100%;
            height: 100%;
            background: #0B666A;
            border-radius: 10px 30px 0 10px;
            overflow: hidden;
        }

        .car-top {
            position: absolute;
            top: -20px;
            left: 30px;
            width: 60px;
            height: 25px;
            background: #0B666A;
            border-radius: 30px 30px 0 0;
        }

        .car-window {
            position: absolute;
            top: 5px;
            left: 40px;
            width: 40px;
            height: 15px;
            background: #c3cfe2;
            border-radius: 10px 10px 0 0;
        }

        .wheel {
            position: absolute;
            bottom: -10px;
            width: 25px;
            height: 25px;
            background: #333;
            border-radius: 50%;
            border: 3px solid #777;
            animation: rotate 2s linear infinite;
        }

        .wheel-front {
            right: 15px;
        }

        .wheel-back {
            left: 15px;
        }

        .headlight {
            position: absolute;
            top: 15px;
            right: 5px;
            width: 10px;
            height: 10px;
            background: #ffeb3b;
            border-radius: 50%;
            box-shadow: 0 0 10px 5px rgba(255, 235, 59, 0.5);
        }

        @keyframes drive {
            0% { left: -200px; }
            100% { left: 110%; }
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 80px 15px 30px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            h2 {
                font-size: 26px;
            }

            .fuel-type-selector {
                gap: 10px;
            }

            .fuel-type-option {
                min-width: 100px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="adminNavbar.jsp" %>

    <div class="navbar-spacer"></div>

    <div class="car-animation">
        <div class="car-body"></div>
        <div class="car-top"></div>
        <div class="car-window"></div>
        <div class="wheel wheel-front"></div>
        <div class="wheel wheel-back"></div>
        <div class="headlight"></div>
    </div>

    <div class="container">
        <h2>Add New Vehicle</h2>

        <p class="form-intro">
            Add a new vehicle to the VahanMitra database. Fill in all the required details to ensure users get comprehensive information.
        </p>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                Failed to add vehicle. Please check your inputs and try again.
            </div>
        <% } %>

        <% if (request.getParameter("msg") != null && request.getParameter("msg").equals("success")) { %>
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                Vehicle added successfully!
            </div>
        <% } %>

        <form action="addCar" method="post" id="addCarForm">
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="name">Vehicle Name</label>
                        <input type="text" id="name" name="name">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="year">Year</label>
                        <input type="number" id="year" name="year" min="1900" max="2099">
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="brand">Brand</label>
                        <input type="text" id="brand" name="brand">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="model">Model</label>
                        <input type="text" id="model" name="model">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Fuel Type</label>
                <div class="fuel-type-selector">
                    <div class="fuel-type-option">
                        <input type="radio" id="fuel-petrol" name="fuelType" value="Petrol" class="fuel-type-input" checked required>
                        <label for="fuel-petrol" class="fuel-type-label">
                            <i class="fas fa-gas-pump fuel-icon"></i>
                            Petrol
                        </label>
                    </div>
                    <div class="fuel-type-option">
                        <input type="radio" id="fuel-diesel" name="fuelType" value="Diesel" class="fuel-type-input">
                        <label for="fuel-diesel" class="fuel-type-label">
                            <i class="fas fa-oil-can fuel-icon"></i>
                            Diesel
                        </label>
                    </div>
                    <div class="fuel-type-option">
                        <input type="radio" id="fuel-electric" name="fuelType" value="Electric" class="fuel-type-input">
                        <label for="fuel-electric" class="fuel-type-label">
                            <i class="fas fa-bolt fuel-icon"></i>
                            Electric
                        </label>
                    </div>
                    <div class="fuel-type-option">
                        <input type="radio" id="fuel-hybrid" name="fuelType" value="Hybrid" class="fuel-type-input">
                        <label for="fuel-hybrid" class="fuel-type-label">
                            <i class="fas fa-leaf fuel-icon"></i>
                            Hybrid
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="engineDetails">Engine Details</label>
                        <input type="text" id="engineDetails" name="engineDetails" placeholder="e.g., 2.0L Turbo, 150HP">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="transmission">Transmission</label>
                        <input type="text" id="transmission" name="transmission" placeholder="e.g., Automatic, Manual, CVT">
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label for="mileage">Mileage</label>
                        <input type="text" id="mileage" name="mileage" placeholder="e.g., 18 km/l, 400 km/charge">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label for="imageUrl">Image URL</label>
                        <input type="url" id="imageUrl" name="imageUrl" placeholder="https://example.com/car-image.jpg">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="safetyFeatures">Safety Features</label>
                <input type="text" id="safetyFeatures" name="safetyFeatures" placeholder="e.g., ABS, Airbags, Lane Assist">
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="5" placeholder="Provide a detailed description of the vehicle..."></textarea>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-car-side"></i> Add Vehicle
            </button>
        </form>
    </div>

    <script>
        // Form validation
        document.getElementById('addCarForm').addEventListener('submit', function(event) {
            // Validate year only if it's provided
            const year = document.getElementById('year').value;
            if (year) {
                const currentYear = new Date().getFullYear();
                if (year < 1900 || year > currentYear + 1) {
                    alert('Please enter a valid year between 1900 and ' + (currentYear + 1));
                    event.preventDefault();
                    return false;
                }
            }

            // Validate only that a fuel type is selected
            const fuelTypeSelected = document.querySelector('input[name="fuelType"]:checked');
            if (!fuelTypeSelected) {
                alert('Please select a fuel type (Petrol, Diesel, Electric, or Hybrid)');
                event.preventDefault();
                return false;
            }

            console.log('Form validation passed, submitting with fuel type: ' + fuelTypeSelected.value);
            return true;
        });
    </script>
</body>
</html>
