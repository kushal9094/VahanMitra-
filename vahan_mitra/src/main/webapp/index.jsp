<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VahanMitra - Automobile Ratings</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            color: #071952;
            margin: 0;
            padding: 0;
            background-color: #EBF4F6;
            overflow-x: hidden;
            box-sizing: border-box;
        }
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f8;
        }
        .hero {
            background: #808b96;
            color: white;
            padding: 80px 20px;
            text-align: center;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #566573;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 10px;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background: #2c3e50;
            transform: translateY(-2px);
        }
        a {
            text-decoration: none;
            color: #071952;
        }

        #features, #how-it-works, #resources {
            background-color: #e5e8e8;
            padding: 2rem 1rem;
            color: #071952;
            text-align: center;
            box-sizing: border-box;
        }

        .features-container, .steps-container, .resources-container {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .feature-card, .step, .resource-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 250px;
            text-align: center;
            color: #071952;
        }

        .feature-card ion-icon,
        .step ion-icon,
        .resource-card ion-icon {
            font-size: 50px;
            color: #071952;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="hero">
    <h1>Welcome to VahanMitra</h1>
    <p>Your trusted automobile ratings platform</p>
    <% if (session.getAttribute("username") == null) { %>
        <a href="login.jsp" class="btn">Login</a>
        <a href="signup.jsp" class="btn">Sign Up</a>
    <% } else { %>
        <p>Welcome back, <%= session.getAttribute("username") %>!</p>
        <a href="vehicleList.jsp" class="btn">Browse Vehicles</a>
    <% } %>
</div>


<section id="features">
    <h2>Features</h2>
    <div class="features-container">
        <div class="feature-card">
            <ion-icon name="book-outline" class="icon"></ion-icon>
            <h3>Vehicle Ratings & Reviews</h3>
            <p>Users can rate and review vehicles based on real experiences, contributing to community-driven scores.</p>
        </div>
        <div class="feature-card">
            <ion-icon name="person-circle-outline" class="icon"></ion-icon>
            <h3>Personalized Recommendations</h3>
            <p>Get suggestions for popular or highly-rated vehicles tailored to user interests.</p>
        </div>
        <div class="feature-card">
            <ion-icon name="bar-chart-outline" class="icon"></ion-icon>
            <h3>Profile Management</h3>
            <p>Registered users can manage personal details, track review history, and access suggestions.</p>
        </div>
    </div>
</section>

<section id="how-it-works">
    <h2>How It Works</h2>
    <div class="steps-container">
        <div class="step">
            <ion-icon name="people-outline" class="icon"></ion-icon>
            <h3>Sign Up & Log In</h3>
            <p>Create an account to access the platform and browse vehicles.</p>
        </div>
        <div class="step">
            <ion-icon name="create-outline" class="icon"></ion-icon>
            <h3>Browse Vehicles</h3>
            <p>After logging in, explore a wide range of cars with detailed information, ratings, and user reviews.</p>
        </div>
        <div class="step">
            <ion-icon name="book-outline" class="icon"></ion-icon>
            <h3>Rate & Review</h3>
            <p>Submit your thoughts and rate vehicles to help others make smart automotive decisions.</p>
        </div>
        <div class="step">
            <ion-icon name="person-circle-outline" class="icon"></ion-icon>
            <h3>Get Recommendations</h3>
            <p>Receive vehicle suggestions based on community ratings and your preferences.</p>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const header = document.querySelector('header');
        const heroHeight = 0;

        window.addEventListener('scroll', function() {
            if (window.scrollY > heroHeight) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
    });
</script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>
