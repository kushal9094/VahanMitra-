<%@ page session="true" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

  body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background-color: #f4f6f8;
  }

  .navbar {
    background: #566573;
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

  .navbar-brand:hover {
    color: #fff;
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

  .disabled-link {
    color: #bdc3c7 !important;
    pointer-events: none;
    cursor: default;
    opacity: 0.7;
  }
</style>

<nav class="navbar">
  <a href="index.jsp" class="navbar-brand">VahanMitra</a>
  <ul class="nav">
    <% if (session.getAttribute("username") != null) { %>
      <!-- Show these links only to logged-in users -->
      <li class="nav-item">
        <a class="nav-link" href="vehicleList.jsp">Browse Vehicles</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="recommendations.jsp">Recommendations</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="myReviews.jsp">My Reviews</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="profile.jsp">Profile</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logout">Logout</a>
      </li>
    <% } else { %>
      <!-- Show these links to guests -->
      <li class="nav-item">
        <a class="nav-link disabled-link" title="Please login to access">Browse Vehicles</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled-link" title="Please login to access">Recommendations</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled-link" title="Please login to access">My Reviews</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="login.jsp">Login</a>
      </li>
    <% } %>
  </ul>
</nav>