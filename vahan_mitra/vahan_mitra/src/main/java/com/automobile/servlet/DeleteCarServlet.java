package com.automobile.servlet;

import com.automobile.dao.CarDAO;
import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


public class DeleteCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int carId = Integer.parseInt(request.getParameter("id"));
            System.out.println("Car ID to delete: " + carId); // Debug log
            
            CarDAO dao = new CarDAO();
            boolean isDeleted = dao.deleteCar(carId); // Call DAO method to delete car

            if (isDeleted) {
                System.out.println("Car deleted successfully."); // Debug log
                response.sendRedirect("viewAllCars.jsp");
            } else {
                System.out.println("Car deletion failed."); // Debug log
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
