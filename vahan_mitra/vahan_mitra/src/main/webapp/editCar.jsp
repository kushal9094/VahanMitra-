<%@ page import="com.automobile.dao.CarDAO, com.automobile.model.Car" %>
<%
 int id = Integer.parseInt(request.getParameter("id"));
 CarDAO dao = new CarDAO();
 Car car = dao.getCarById(id);
%>

<!DOCTYPE html>
<html>
<head>
  <title>Edit Car</title>
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
    textarea {
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
    <h2>Edit Car Details</h2>
    <form action="updateCar" method="post">
      <input type="hidden" name="id" value="<%= car.getId() %>"/>

      <label>Name:</label>
      <input type="text" name="name" value="<%= car.getName() %>"/>

      <label>Brand:</label>
      <input type="text" name="brand" value="<%= car.getBrand() %>"/>

      <label>Model:</label>
      <input type="text" name="model" value="<%= car.getModel() %>"/>

      <label>Year:</label>
      <input type="text" name="year" value="<%= car.getYear() %>"/>

      <label>Fuel Type:</label>
      <input type="text" name="fuelType" value="<%= car.getFuelType() %>"/>

      <label>Description:</label>
      <textarea name="description"><%= car.getDescription() %></textarea>

      <button type="submit">Update</button>
    </form>
  </div>
</body>
</html>
