<%@ page session="true" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="navbar.jsp" %>

<h1>Welcome to the Automobile Ratings Platform</h1>
<p>Hello, <%= session.getAttribute("username") %>!</p>
