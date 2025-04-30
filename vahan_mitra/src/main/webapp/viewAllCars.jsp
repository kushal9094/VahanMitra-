<%@ page import="java.util.*, com.automobile.model.Car, com.automobile.dao.CarDAO" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Cars</title>
    <style>



        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f8;
            padding: 2rem;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .table-container {
            width: 100%;
            margin-top: 2rem;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: auto;
            max-height: 70vh;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        /* Make the table header sticky */
        thead {
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #34495e;
            color: white;
            font-size: 16px;
            text-transform: uppercase;
        }

        td {
            font-size: 14px;
            color: #555;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            align-items: center;
        }

        .delete-button, .edit-button {
            padding: 10px 20px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Delete Button Styles */
        .delete-button {
            background-color: #e74c3c;
            color: white;
        }

        .delete-button:hover {
            background-color: #c0392b;
            transform: translateY(-3px);
        }

        .delete-button:active {
            background-color: #e74c3c;
            transform: translateY(1px);
        }

        .delete-button:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(231, 76, 60, 0.8);
        }

        /* Edit Button Styles */
        .edit-button {
            background-color: #3498db;
            color: white;
        }

        .edit-button:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
        }

        .edit-button:active {
            background-color: #3498db;
            transform: translateY(1px);
        }

        .edit-button:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.8);
        }

        /* Table Hover Effect */
        tr:hover {
            background-color: #ecf0f1;
            transition: background-color 0.3s ease;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:nth-child(odd) {
            background-color: #ffffff;
        }

        .no-cars {
            text-align: center;
            color: #e74c3c;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
        }

    </style>
</head>
<body>

<jsp:include page="adminNavbar.jsp"/>

<h2>All Cars in Database</h2>

<%
    CarDAO dao = new CarDAO();
    List<Car> cars = dao.getAllCars();

    if (cars != null && !cars.isEmpty()) {
%>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Year</th>
                    <th>Fuel Type</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Car car : cars) { %>
                <tr>
                    <td><%= car.getId() %></td>
                    <td><%= car.getName() %></td>
                    <td><%= car.getBrand() %></td>
                    <td><%= car.getModel() %></td>
                    <td><%= car.getYear() %></td>
                    <td><%= car.getFuelType() %></td>
                    <td><%= car.getDescription() %></td>
                    <td class="action-buttons">
                        <!-- Delete Button -->
                        <form action="deleteCar" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this car?');">
                            <input type="hidden" name="id" value="<%= car.getId() %>"/>
                            <button type="submit" class="delete-button">Delete</button>
                        </form>

                        <!-- Edit Button -->
                        <form action="editCar.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= car.getId() %>"/>
                            <button type="submit" class="edit-button">Edit</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
<% } else { %>
    <p class="no-cars">No cars found in the system.</p>
<% } %>

</body>
</html>
