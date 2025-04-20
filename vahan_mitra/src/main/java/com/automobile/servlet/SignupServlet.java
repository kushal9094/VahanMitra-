package com.automobile.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import com.automobile.dao.UserDAO;

public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String result = UserDAO.registerUser(username, password, email);

        if ("SUCCESS".equals(result)) {
            request.setAttribute("message", "Registration successful! Please login.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}