package com.automobile.servlet;

import com.automobile.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        UserDAO dao = new UserDAO();
        boolean success = dao.deleteUser(userId);

        if (success) {
            response.sendRedirect("manageUsers.jsp"); // Redirect back to the user management page
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User deletion failed");
        }
    }
}
