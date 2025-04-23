<%@ page session="true" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

  body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background-color: #f4f6f8;
  }

  .navbar {
    background: linear-gradient(90deg, #2c3e50 0%, #34495e 100%);
    padding: 0.8em 2em;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  }

  .navbar-brand {
    color: #ecf0f1;
    font-weight: bold;
    font-size: 1.5em;
    text-decoration: none;
    letter-spacing: 1px;
  }

  .nav {
    list-style: none;
    display: flex;
    gap: 1.2em;
    margin: 0;
    padding: 0;
  }

  .nav-item {
    display: inline;
  }

  .nav-link {
    color: #ecf0f1;
    text-decoration: none;
    padding: 0.5em 1em;
    border-radius: 6px;
    transition: all 0.3s ease;
    font-weight: 500;
  }

  .nav-link:hover {
    background-color: rgba(236, 240, 241, 0.1);
    transform: scale(1.05);
  }

  .nav-link:active {
    transform: scale(0.98);
  }
</style>

<nav class="navbar">
  <div class="navbar-brand">Admin Dashboard</div>
  <ul class="nav">
    <li class="nav-item">
      <a class="nav-link" href="manageUsers.jsp">Manage Users</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="manageVehicles.jsp">Manage Vehicles</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="viewReports.jsp">View Reviews</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="adminLogout">Logout</a>
    </li>
  </ul>
</nav>
