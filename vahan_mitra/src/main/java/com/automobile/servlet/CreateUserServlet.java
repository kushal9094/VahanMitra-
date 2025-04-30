package com.automobile.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.automobile.dao.UserDAO;

public class CreateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is an admin
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            response.sendRedirect("createUser.jsp?error=All fields are required");
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("createUser.jsp?error=Passwords do not match");
            return;
        }
        
        // Register the user
        String result = UserDAO.registerUser(username, password, email);
        
        if ("SUCCESS".equals(result)) {
            response.sendRedirect("createUser.jsp?success=true");
        } else {
            response.sendRedirect("createUser.jsp?error=" + result);
        }
    }
}
