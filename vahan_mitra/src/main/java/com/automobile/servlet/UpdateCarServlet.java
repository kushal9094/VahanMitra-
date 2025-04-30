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
        try {
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

            // Get additional fields
            String engineDetails = request.getParameter("engineDetails");
            String transmission = request.getParameter("transmission");
            String mileage = request.getParameter("mileage");
            String imageUrl = request.getParameter("imageUrl");
            String safetyFeatures = request.getParameter("safetyFeatures");

            // Create updated Car object
            Car updatedCar = new Car();
            updatedCar.setId(id);
            updatedCar.setName(name);
            updatedCar.setBrand(brand);
            updatedCar.setModel(model);
            updatedCar.setYear(year);
            updatedCar.setFuelType(fuelType);
            updatedCar.setDescription(description);
            updatedCar.setEngineDetails(engineDetails);
            updatedCar.setTransmission(transmission);
            updatedCar.setMileage(mileage);
            updatedCar.setImageUrl(imageUrl);
            updatedCar.setSafetyFeatures(safetyFeatures);

            // Update the car using DAO
            boolean success = CarDAO.updateCar(updatedCar);

            if (success) {
                response.sendRedirect("editCar.jsp?id=" + id + "&msg=success"); // Redirect back to edit page with success message
            } else {
                response.sendRedirect("editCar.jsp?id=" + id + "&error=Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            int id = Integer.parseInt(request.getParameter("id"));
            response.sendRedirect("editCar.jsp?id=" + id + "&error=Failed&message=" + e.getMessage());
        }
    }
}
