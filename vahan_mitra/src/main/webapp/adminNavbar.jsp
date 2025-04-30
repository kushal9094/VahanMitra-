<%@ page session="true" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

  .admin-navbar {
    background: linear-gradient(90deg, #071952 0%, #0B666A 100%);
    padding: 1em 2em;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
  }

  .admin-navbar-brand {
    color: #ffffff;
    font-weight: bold;
    font-size: 1.5em;
    text-decoration: none;
    letter-spacing: 1px;
    display: flex;
    align-items: center;
  }

  .admin-navbar-brand i {
    margin-right: 10px;
    font-size: 24px;
  }

  .admin-nav {
    list-style: none;
    display: flex;
    gap: 0.8em;
    margin: 0;
    padding: 0;
  }

  .admin-nav-item {
    display: inline;
    position: relative;
  }

  .admin-nav-link {
    color: #ffffff;
    text-decoration: none;
    padding: 0.6em 1em;
    border-radius: 6px;
    transition: all 0.3s ease;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .admin-nav-link:hover {
    background-color: rgba(255, 255, 255, 0.15);
    transform: translateY(-3px);
  }

  .admin-nav-link:active {
    transform: translateY(0);
  }

  .admin-nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    font-weight: 600;
  }

  .admin-nav-link i {
    font-size: 16px;
  }

  /* Mobile menu */
  .admin-menu-toggle {
    display: none;
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
  }

  /* Responsive adjustments */
  @media (max-width: 1024px) {
    .admin-nav {
      gap: 0.4em;
    }

    .admin-nav-link {
      padding: 0.5em 0.8em;
      font-size: 14px;
    }
  }

  @media (max-width: 768px) {
    .admin-menu-toggle {
      display: block;
    }

    .admin-nav {
      position: absolute;
      top: 100%;
      right: 0;
      flex-direction: column;
      background: linear-gradient(90deg, #071952 0%, #0B666A 100%);
      padding: 1em;
      border-radius: 0 0 10px 10px;
      box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
      display: none;
      width: 200px;
    }

    .admin-nav.show {
      display: flex;
    }

    .admin-nav-item {
      width: 100%;
    }

    .admin-nav-link {
      width: 100%;
      padding: 0.8em 1em;
    }
  }
</style>

<nav class="admin-navbar">
  <a href="adminDashboard.jsp" class="admin-navbar-brand">
    <i class="fas fa-tachometer-alt"></i> Admin Dashboard
  </a>

  <button class="admin-menu-toggle" onclick="toggleAdminMenu()">
    <i class="fas fa-bars"></i>
  </button>

  <ul class="admin-nav" id="adminNav">
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("adminDashboard.jsp") ? "active" : "" %>" href="adminDashboard.jsp">
        <i class="fas fa-home"></i> Dashboard
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("createUser.jsp") ? "active" : "" %>" href="createUser.jsp">
        <i class="fas fa-user-plus"></i> Create User
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("manageUsers.jsp") ? "active" : "" %>" href="manageUsers.jsp">
        <i class="fas fa-users-cog"></i> Manage Users
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("viewAllCars.jsp") ? "active" : "" %>" href="viewAllCars.jsp">
        <i class="fas fa-car"></i> View Cars
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("viewAllReviews.jsp") ? "active" : "" %>" href="viewAllReviews.jsp">
        <i class="fas fa-star"></i> Reviews
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("addCar.jsp") ? "active" : "" %>" href="addCar.jsp">
        <i class="fas fa-plus-circle"></i> Add Car
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link <%= request.getRequestURI().endsWith("vehicleList.jsp") ? "active" : "" %>" href="vehicleList.jsp">
        <i class="fas fa-search"></i> Browse
      </a>
    </li>
    <li class="admin-nav-item">
      <a class="admin-nav-link" href="adminLogout">
        <i class="fas fa-sign-out-alt"></i> Logout
      </a>
    </li>
  </ul>
</nav>

<script>
  function toggleAdminMenu() {
    const nav = document.getElementById('adminNav');
    nav.classList.toggle('show');
  }
</script>
