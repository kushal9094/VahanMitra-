package com.automobile.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // You’ll need to create this POJO
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.automobile.model.Car;

public class CarDAO {
    private static final String URL = "jdbc:postgresql://localhost:5432/automobile_ratings";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Dedeepya@0608";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }


    public static boolean deleteCar(int id) {
        boolean rowDeleted = false;
        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement("DELETE FROM cars WHERE id = ?")) {
            ps.setInt(1, id);
            System.out.println("Executing query: DELETE FROM cars WHERE id = " + id); // Debug log
            rowDeleted = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    public static boolean updateCar(Car car) {
        boolean rowUpdated = false;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "UPDATE cars SET name = ?, brand = ?, model = ?, year = ?, fuel_type = ?, description = ?, " +
                    "image_url = ?, engine_details = ?, transmission = ?, mileage = ?, safety_features = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, car.getName());
                stmt.setString(2, car.getBrand());
                stmt.setString(3, car.getModel());
                stmt.setInt(4, car.getYear());
                stmt.setString(5, car.getFuelType());
                stmt.setString(6, car.getDescription());
                stmt.setString(7, car.getImageUrl());
                stmt.setString(8, car.getEngineDetails());
                stmt.setString(9, car.getTransmission());
                stmt.setString(10, car.getMileage());
                stmt.setString(11, car.getSafetyFeatures());
                stmt.setInt(12, car.getId());

                rowUpdated = stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }


    // Add a new car
    public static boolean addCar(Car car) {
        String sql = "INSERT INTO cars (name, brand, model, year, fuel_type, description, image_url, engine_details, " +
                "transmission, mileage, safety_features) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        System.out.println("Attempting to add car: " + car.getName() + ", " + car.getBrand() + " " + car.getModel());
        System.out.println("Fuel type: " + car.getFuelType());

        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, car.getName());
                stmt.setString(2, car.getBrand());
                stmt.setString(3, car.getModel());
                stmt.setInt(4, car.getYear());
                stmt.setString(5, car.getFuelType());
                stmt.setString(6, car.getDescription());
                stmt.setString(7, car.getImageUrl());
                stmt.setString(8, car.getEngineDetails());
                stmt.setString(9, car.getTransmission());
                stmt.setString(10, car.getMileage());
                stmt.setString(11, car.getSafetyFeatures());

                System.out.println("Executing SQL: " + sql);
                int rowsInserted = stmt.executeUpdate();
                System.out.println("Rows inserted: " + rowsInserted);
                return rowsInserted > 0;
            }
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC driver not found: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (SQLException e) {
            System.err.println("SQL Error adding car: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("Unexpected error adding car: " + e.getMessage());
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
                car.setImageUrl(rs.getString("image_url"));
                car.setEngineDetails(rs.getString("engine_details"));
                car.setTransmission(rs.getString("transmission"));
                car.setMileage(rs.getString("mileage"));
                car.setSafetyFeatures(rs.getString("safety_features"));
                car.setAverageRating(rs.getDouble("average_rating"));
                car.setReviewCount(rs.getInt("review_count"));
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }


    public static Car getCarById(int id) {
        Car car = null;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "SELECT * FROM cars WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        car = new Car();
                        car.setId(rs.getInt("id"));
                        car.setName(rs.getString("name"));
                        car.setBrand(rs.getString("brand"));
                        car.setModel(rs.getString("model"));
                        car.setYear(rs.getInt("year"));
                        car.setFuelType(rs.getString("fuel_type"));
                        car.setDescription(rs.getString("description"));
                        car.setImageUrl(rs.getString("image_url"));
                        car.setEngineDetails(rs.getString("engine_details"));
                        car.setTransmission(rs.getString("transmission"));
                        car.setMileage(rs.getString("mileage"));
                        car.setSafetyFeatures(rs.getString("safety_features"));
                        car.setAverageRating(rs.getDouble("average_rating"));
                        car.setReviewCount(rs.getInt("review_count"));
                    }
                }
            }
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
