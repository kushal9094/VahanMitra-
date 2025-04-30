<%@ page session="true" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

  .user-navbar {
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

  .user-navbar-brand {
    color: #ffffff;
    font-weight: bold;
    font-size: 1.5em;
    text-decoration: none;
    letter-spacing: 1px;
    display: flex;
    align-items: center;
  }

  .user-navbar-brand i {
    margin-right: 10px;
    font-size: 24px;
  }

  .user-navbar-brand:hover {
    color: #fff;
    transform: translateY(-2px);
  }

  .user-nav {
    list-style: none;
    display: flex;
    gap: 0.8em;
    margin: 0;
    padding: 0;
  }

  .user-nav-item {
    display: inline;
    position: relative;
  }

  .user-nav-link {
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

  .user-nav-link:hover {
    background-color: rgba(255, 255, 255, 0.15);
    transform: translateY(-3px);
  }

  .user-nav-link:active {
    transform: translateY(0);
  }

  .user-nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    font-weight: 600;
  }

  .user-nav-link i {
    font-size: 16px;
  }

  .disabled-link {
    color: rgba(255, 255, 255, 0.5) !important;
    pointer-events: none;
    cursor: default;
    opacity: 0.7;
  }

  .user-profile-link {
    display: flex;
    align-items: center;
    gap: 8px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 30px;
    padding: 6px 15px;
  }

  .user-profile-link:hover {
    background-color: rgba(255, 255, 255, 0.2);
  }

  .user-avatar {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background-color: rgba(255, 255, 255, 0.2);
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    color: white;
    font-size: 14px;
  }

  /* Mobile menu */
  .user-menu-toggle {
    display: none;
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
  }

  /* Responsive adjustments */
  @media (max-width: 1024px) {
    .user-nav {
      gap: 0.4em;
    }

    .user-nav-link {
      padding: 0.5em 0.8em;
      font-size: 14px;
    }
  }

  @media (max-width: 768px) {
    .user-menu-toggle {
      display: block;
    }

    .user-nav {
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

    .user-nav.show {
      display: flex;
    }

    .user-nav-item {
      width: 100%;
    }

    .user-nav-link {
      width: 100%;
      padding: 0.8em 1em;
    }
  }
</style>

<nav class="user-navbar">
  <a href="index.jsp" class="user-navbar-brand">
    <i class="fas fa-car"></i> VahanMitra
  </a>

  <button class="user-menu-toggle" onclick="toggleUserMenu()">
    <i class="fas fa-bars"></i>
  </button>

  <ul class="user-nav" id="userNav">
    <% if (session.getAttribute("username") != null) {
        String username = (String) session.getAttribute("username");
    %>
      <!-- Show these links only to logged-in users -->
      <li class="user-nav-item">
        <a class="user-nav-link <%= request.getRequestURI().endsWith("vehicleList.jsp") ? "active" : "" %>" href="vehicleList.jsp">
          <i class="fas fa-car-side"></i> Browse Vehicles
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link <%= request.getRequestURI().endsWith("recommendations.jsp") ? "active" : "" %>" href="recommendations.jsp">
          <i class="fas fa-thumbs-up"></i> Recommendations
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link <%= request.getRequestURI().endsWith("myReviews.jsp") ? "active" : "" %>" href="myReviews.jsp">
          <i class="fas fa-star"></i> My Reviews
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link user-profile-link <%= request.getRequestURI().endsWith("profile.jsp") ? "active" : "" %>" href="profile.jsp">
          <div class="user-avatar"><%= username.substring(0, 1).toUpperCase() %></div>
          <span><%= username %></span>
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link" href="logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </li>
    <% } else { %>
      <!-- Show these links to guests -->
      <li class="user-nav-item">
        <a class="user-nav-link disabled-link" title="Please login to access">
          <i class="fas fa-car-side"></i> Browse Vehicles
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link disabled-link" title="Please login to access">
          <i class="fas fa-thumbs-up"></i> Recommendations
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link disabled-link" title="Please login to access">
          <i class="fas fa-star"></i> My Reviews
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link <%= request.getRequestURI().endsWith("login.jsp") ? "active" : "" %>" href="login.jsp">
          <i class="fas fa-sign-in-alt"></i> Login
        </a>
      </li>
      <li class="user-nav-item">
        <a class="user-nav-link <%= request.getRequestURI().endsWith("signup.jsp") ? "active" : "" %>" href="signup.jsp">
          <i class="fas fa-user-plus"></i> Sign Up
        </a>
      </li>
    <% } %>
  </ul>
</nav>

<script>
  function toggleUserMenu() {
    const nav = document.getElementById('userNav');
    nav.classList.toggle('show');
  }
</script>