package com.automobile.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.automobile.model.Car; // You’ll need to create this POJO

public class CarDAO {
    private static final String URL = "jdbc:postgresql://localhost:5432/automobile_ratings";
    private static final String USER = "postgres";
    private static final String PASSWORD = "prasanna";
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }


    public boolean deleteCar(int id) {
        boolean rowDeleted = false;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM cars WHERE id = ?")) {
            ps.setInt(1, id);
            System.out.println("Executing query: DELETE FROM cars WHERE id = " + id); // Debug log
            rowDeleted = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
    
    public boolean updateCar(Car car) {
         boolean rowUpdated = false;
         try (Connection conn = getConnection()) {
         String sql = "UPDATE cars SET name = ?, brand = ?, model = ?, year = ?, fuel_type = ?, description = ? WHERE id = ?";
         PreparedStatement stmt = conn.prepareStatement(sql);
         stmt.setString(1, car.getName());
         stmt.setString(2, car.getBrand());
         stmt.setString(3, car.getModel());
         stmt.setInt(4, car.getYear());
        stmt.setString(5, car.getFuelType());
         stmt.setString(6, car.getDescription());
         stmt.setInt(7, car.getId());
        
        rowUpdated = stmt.executeUpdate() > 0;
         } catch (Exception e) {
         e.printStackTrace();
         }
         return rowUpdated;
        }
        

    // Add a new car
    public static boolean addCar(Car car) {
        String sql = "INSERT INTO cars (name, brand, model, year, fuel_type, description) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, car.getName());
            stmt.setString(2, car.getBrand());
            stmt.setString(3, car.getModel());
            stmt.setInt(4, car.getYear());
            stmt.setString(5, car.getFuelType());
            stmt.setString(6, car.getDescription());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM cars");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Car car = new Car();
                car.setId(rs.getInt("id"));
                car.setName(rs.getString("name"));
                car.setBrand(rs.getString("brand"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setDescription(rs.getString("description"));
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }


    public Car getCarById(int id) {
        Car car = null;
        try {
            Connection conn = getConnection();
            String sql = "SELECT * FROM cars WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                car = new Car();
                car.setId(rs.getInt("id"));
                car.setName(rs.getString("name"));
                car.setBrand(rs.getString("brand"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setDescription(rs.getString("description"));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return car;
    }
    
    
        
    /*// Get list of all cars
    public static List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT * FROM cars";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Car car = new Car();
                car.setId(rs.getInt("id"));
                car.setName(rs.getString("name"));
                car.setBrand(rs.getString("brand"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setFuelType(rs.getString("fuel_type"));
                car.setDescription(rs.getString("description"));
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cars;
    }*/
}
