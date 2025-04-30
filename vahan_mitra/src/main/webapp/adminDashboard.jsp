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
    <title>Admin Dashboard - VahanMitra</title>
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

        .dashboard-header {
            text-align: center;
            margin-bottom: 40px;
        }

        h1 {
            color: #071952;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #555;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .dashboard-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .card-icon {
            font-size: 48px;
            color: #0B666A;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 22px;
            font-weight: 600;
            color: #071952;
            margin-bottom: 15px;
        }

        .card-description {
            color: #555;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .card-link {
            display: inline-block;
            background-color: #0B666A;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .card-link:hover {
            background-color: #35A29F;
        }
    </style>
</head>
<body>
    <%@ include file="adminNavbar.jsp" %>

    <div class="container">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p class="subtitle">Manage users, vehicles, reviews, and more from one central location.</p>
        </div>

        <div class="dashboard-cards">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h2 class="card-title">User Management</h2>
                <p class="card-description">Create new users, view all users, and manage user accounts.</p>
                <a href="manageUsers.jsp" class="card-link">Manage Users</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h2 class="card-title">Create User</h2>
                <p class="card-description">Add new users to the system with custom credentials.</p>
                <a href="createUser.jsp" class="card-link">Create User</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-car"></i>
                </div>
                <h2 class="card-title">Vehicle Management</h2>
                <p class="card-description">Add, edit, or remove vehicles from the database.</p>
                <a href="viewAllCars.jsp" class="card-link">Manage Vehicles</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h2 class="card-title">Add Vehicle</h2>
                <p class="card-description">Add a new vehicle to the database with detailed information.</p>
                <a href="addCar.jsp" class="card-link">Add Vehicle</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-star"></i>
                </div>
                <h2 class="card-title">Review Management</h2>
                <p class="card-description">View and manage all user reviews across the platform.</p>
                <a href="viewAllReviews.jsp" class="card-link">Manage Reviews</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-list"></i>
                </div>
                <h2 class="card-title">Browse Vehicles</h2>
                <p class="card-description">View all vehicles as they appear to users, organized by fuel type.</p>
                <a href="vehicleList.jsp" class="card-link">Browse Vehicles</a>
            </div>
        </div>
    </div>
</body>
</html>
