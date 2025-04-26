package com.automobile.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import com.automobile.dao.UserDAO;

public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            
            String result = UserDAO.updatePassword(email, newPassword);
            
            if ("SUCCESS".equals(result)) {
                request.setAttribute("message", "Password updated successfully! Please login.");
            } else {
                request.setAttribute("error", result);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
        }
        
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}