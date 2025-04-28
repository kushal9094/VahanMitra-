package com.automobile.servlet;

import com.automobile.dao.CarDAO;
import com.automobile.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateCar")
public class UpdateCarServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Set encoding
     request.setCharacterEncoding("UTF-8");

     // Get values from the form
     int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
     String brand = request.getParameter("brand");
     String model = request.getParameter("model");
     int year = Integer.parseInt(request.getParameter("year"));
     String fuelType = request.getParameter("fuelType");
     String description = request.getParameter("description");

     // Create updated Car object
     Car updatedCar = new Car();
     updatedCar.setId(id);
    updatedCar.setName(name);
     updatedCar.setBrand(brand);
     updatedCar.setModel(model);
     updatedCar.setYear(year);
    updatedCar.setFuelType(fuelType);
     updatedCar.setDescription(description);

    // Update the car using DAO
    CarDAO dao = new CarDAO();
     boolean success = dao.updateCar(updatedCar);

     if (success) {
         response.sendRedirect("viewAllCars.jsp"); // Redirect to view after update
     } else {
         response.getWriter().println("Failed to update car details.");
     }
 }
}
