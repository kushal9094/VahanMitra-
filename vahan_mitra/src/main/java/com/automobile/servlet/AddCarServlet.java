package com.automobile.servlet;

import com.automobile.dao.CarDAO;
import com.automobile.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addCar")
public class AddCarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read form fields
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        String fuelType = request.getParameter("fuelType");
        String description = request.getParameter("description");

        // Create Car object
        Car car = new Car();
        car.setName(name);
        car.setBrand(brand);
        car.setModel(model);
        car.setYear(year);
        car.setFuelType(fuelType);
        car.setDescription(description);

        // Insert car using DAO
        boolean success = CarDAO.addCar(car);

        if (success) {
            response.sendRedirect("adminDashboard.jsp?msg=CarAdded");
        } else {
            response.sendRedirect("addCar.jsp?error=Failed");
        }
    }
}
