<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="adminNavbar.jsp" %>

<h1>Welcome to the Admin Dashboard</h1>
<p>Manage users, view reports, and more!</p>
