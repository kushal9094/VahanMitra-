<%@ page import="java.util.*, com.automobile.model.User, com.automobile.dao.UserDAO" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Users</title>
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
    }

    table {
      width: 80%;
      margin-top: 2rem;
      background-color: white;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-left: auto;
      margin-right: auto;
      border-collapse: collapse;
      border-radius: 8px;
    }

    th, td {
      padding: 0.75rem 1rem;
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

    /* Adjusted column width */
    th:nth-child(1), td:nth-child(1) {
      width: 10%;
    }

    th:nth-child(2), td:nth-child(2) {
      width: 25%;
    }

    th:nth-child(3), td:nth-child(3) {
      width: 40%;
    }

    th:nth-child(4), td:nth-child(4) {
      width: 25%;
    }

    .delete-button {
      background-color: #e74c3c;
      color: white;
      border: none;
      padding: 0.5rem 1rem;
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }

    .delete-button:hover {
      background-color: #c0392b;
    }

    .action-buttons {
      display: flex;
      justify-content: space-around;
    }

    .edit-button {
      background-color: #3498db;
      color: white;
      padding: 0.5rem 1rem;
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }

    .edit-button:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

<jsp:include page="adminNavbar.jsp"/>

<h2>All Users</h2>

<%
  UserDAO dao = new UserDAO();
  List<User> users = dao.getAllUsers();

  if (users != null && !users.isEmpty()) {
%>
  <table>
    <tr>
      <th>ID</th>
      <th>Username</th>
      <th>Email</th>
      <th>Actions</th>
    </tr>
    <% for (User user : users) { %>
    <tr>
      <td><%= user.getId() %></td>
      <td><%= user.getUsername() %></td>
      <td><%= user.getEmail() %></td>
      <td class="action-buttons">
        <!-- Delete Button -->
        <form action="deleteUser" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
          <input type="hidden" name="id" value="<%= user.getId() %>"/>
          <button type="submit" class="delete-button">Delete</button>
        </form>
        <!-- Edit Button (optional) -->
        <!--
        <form action="editUser.jsp" method="get" style="display:inline;">
          <input type="hidden" name="id" value="<%= user.getId() %>"/>
          <button type="submit" class="edit-button">Edit</button>
        </form>
        -->
      </td>
    </tr>
    <% } %>
  </table>
<% } else { %>
  <p style="text-align:center; color: red;">No users found in the system.</p>
<% } %>

</body>
</html>
