<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Car</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #dff9fb;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
            z-index: 10;
            position: relative;
        }

        h2 {
            text-align: center;
            color: #2f3640;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-top: 5px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 80px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #44bd32;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #4cd137;
        }

        /* Car animation */
        .car {
            position: absolute;
            bottom: 20px;
            left: -200px;
            width: 120px;
            height: 60px;
            background: red;
            border-radius: 10px;
            animation: drive 10s linear infinite;
            z-index: 1;
        }

        .car::before, .car::after {
            content: '';
            position: absolute;
            bottom: -15px;
            width: 25px;
            height: 25px;
            background: black;
            border-radius: 50%;
        }

        .car::before {
            left: 15px;
        }

        .car::after {
            right: 15px;
        }

        @keyframes drive {
            0% { left: -200px; }
            100% { left: 110%; }
        }
    </style>
</head>
<body>

<div class="car"></div>

<div class="container">
    <h2>Add New Car</h2>
    <% if (request.getParameter("error") != null) { %>
        <div class="error">Failed to add car. Try again!</div>
    <% } %>
    <form action="addCar" method="post">
        <input type="text" name="name" placeholder="Car Name" required>
        <input type="text" name="brand" placeholder="Brand" required>
        <input type="text" name="model" placeholder="Model" required>
        <input type="number" name="year" placeholder="Year" required>
        <select name="fuelType" required>
            <option value="">Select Fuel Type</option>
            <option value="Petrol">Petrol</option>
            <option value="Diesel">Diesel</option>
            <option value="Electric">Electric</option>
            <option value="Hybrid">Hybrid</option>
        </select>
        <textarea name="description" placeholder="Description" rows="4"></textarea>
        <button type="submit">Add Car</button>
    </form>
</div>

</body>
</html>
