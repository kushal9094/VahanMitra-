package com.automobile.servlet;

import com.automobile.dao.CarDAO;
import com.automobile.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/addCar")
public class AddCarServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddCarServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Read form fields
            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");

            // Handle year - use current year if not provided or invalid
            int year;
            try {
                String yearStr = request.getParameter("year");
                if (yearStr != null && !yearStr.isEmpty()) {
                    year = Integer.parseInt(yearStr);
                } else {
                    year = java.time.Year.now().getValue(); // Current year
                    LOGGER.log(Level.INFO, "Year not provided, using current year: {0}", year);
                }
            } catch (NumberFormatException e) {
                year = java.time.Year.now().getValue(); // Current year as fallback
                LOGGER.log(Level.WARNING, "Invalid year format, using current year: {0}", year);
            }

            String fuelType = request.getParameter("fuelType");
            String description = request.getParameter("description");

            // Debug logging
            LOGGER.log(Level.INFO, "Adding car: {0}, {1} {2}, Year: {3}, Fuel: {4}",
                new Object[]{name, brand, model, year, fuelType});

            // Set default fuel type if not selected
            if (fuelType == null || fuelType.isEmpty()) {
                fuelType = "Petrol";
                LOGGER.log(Level.WARNING, "Fuel type was null or empty, defaulting to Petrol");
            }

            // Read additional fields
            String engineDetails = request.getParameter("engineDetails");
            String transmission = request.getParameter("transmission");
            String mileage = request.getParameter("mileage");
            String imageUrl = request.getParameter("imageUrl");
            String safetyFeatures = request.getParameter("safetyFeatures");

            // Set default values for empty fields
            if (name == null || name.isEmpty()) name = "Unnamed Vehicle";
            if (brand == null || brand.isEmpty()) brand = "Unknown Brand";
            if (model == null || model.isEmpty()) model = "Unknown Model";
            if (description == null) description = "";
            if (engineDetails == null) engineDetails = "";
            if (transmission == null) transmission = "";
            if (mileage == null) mileage = "";
            if (imageUrl == null) imageUrl = "";
            if (safetyFeatures == null) safetyFeatures = "";

            // Create Car object
            Car car = new Car();
            car.setName(name);
            car.setBrand(brand);
            car.setModel(model);
            car.setYear(year);
            car.setFuelType(fuelType);
            car.setDescription(description);
            car.setEngineDetails(engineDetails);
            car.setTransmission(transmission);
            car.setMileage(mileage);
            car.setImageUrl(imageUrl);
            car.setSafetyFeatures(safetyFeatures);

            // Insert car using DAO
            boolean success = CarDAO.addCar(car);

            if (success) {
                LOGGER.log(Level.INFO, "Car added successfully: {0}", name);
                response.sendRedirect("addCar.jsp?msg=success");
            } else {
                LOGGER.log(Level.WARNING, "Failed to add car: {0}", name);
                response.sendRedirect("addCar.jsp?error=Failed");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding car", e);
            e.printStackTrace();
            response.sendRedirect("addCar.jsp?error=Failed&message=" + e.getMessage());
        }
    }
}
