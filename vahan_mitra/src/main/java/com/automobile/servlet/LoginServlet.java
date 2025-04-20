package com.automobile.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("usernameOrEmail").trim();
        String password = request.getParameter("password").trim();

        // Check for empty fields
        if (usernameOrEmail.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Username/email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Admin credentials (plain-text check)
        if ("admin".equals(usernameOrEmail) && "admin".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", "admin");
            response.sendRedirect("adminDashboard.jsp");
            return;
        }

        // Regular user check (plain-text)
        try {
            if (com.automobile.dao.UserDAO.checkUser(usernameOrEmail, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", usernameOrEmail);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Invalid username/email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}