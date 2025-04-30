package com.automobile.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class to seed the database with sample data.
 * This ensures the application has some initial data to work with.
 */
public class DataSeeder {
    private static final Logger LOGGER = Logger.getLogger(DataSeeder.class.getName());

    private static final String URL = "jdbc:postgresql://localhost:5432/automobile_ratings";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Dedeepya@0608";

    // Sample car data
    private static final List<Car> SAMPLE_CARS = new ArrayList<>();

    static {
        // Initialize sample cars
        SAMPLE_CARS.add(new Car("Civic", "Honda", "Sedan", 2022, "Petrol",
                "A reliable and fuel-efficient sedan with modern features and comfortable interior.",
                "https://imgd.aeplcdn.com/664x374/n/cw/ec/141115/civic-exterior-right-front-three-quarter.jpeg",
                "1.5L Turbocharged 4-cylinder, 180 HP", "6-speed Manual / CVT Automatic",
                "18-22 km/l", "ABS, EBD, 6 Airbags, Electronic Stability Control"));

        SAMPLE_CARS.add(new Car("Model 3", "Tesla", "Electric", 2023, "Electric",
                "Popular electric vehicle with good range and cutting-edge technology.",
                "https://imgd.aeplcdn.com/664x374/n/cw/ec/42611/tesla-model-3-left-front-three-quarter8.jpeg",
                "Dual Motor All-Wheel Drive, 346 HP", "Single-speed Automatic",
                "500 km per charge", "Autopilot, 8 Airbags, Collision Avoidance, Lane Departure Warning"));

        SAMPLE_CARS.add(new Car("Fortuner", "Toyota", "SUV", 2021, "Diesel",
                "Powerful SUV with great off-road capabilities and premium features.",
                "https://imgd.aeplcdn.com/664x374/n/cw/ec/44709/fortuner-exterior-right-front-three-quarter-19.jpeg",
                "2.8L Turbocharged Diesel, 201 HP", "6-speed Manual / Automatic",
                "10-14 km/l", "ABS, EBD, 7 Airbags, Hill Assist Control, Vehicle Stability Control"));

        SAMPLE_CARS.add(new Car("City", "Honda", "Sedan", 2022, "Petrol",
                "Elegant sedan with spacious interior and advanced features.",
                "https://imgd.aeplcdn.com/664x374/n/cw/ec/134287/city-exterior-right-front-three-quarter-3.jpeg",
                "1.5L i-VTEC, 121 HP", "6-speed Manual / CVT Automatic",
                "17-20 km/l", "ABS, EBD, 6 Airbags, Vehicle Stability Assist"));

        SAMPLE_CARS.add(new Car("Nexon EV", "Tata", "SUV", 2023, "Electric",
                "Compact electric SUV with good range and affordable price.",
                "https://imgd.aeplcdn.com/664x374/n/cw/ec/42611/tata-nexon-ev-left-front-three-quarter8.jpeg",
                "Permanent Magnet Synchronous Motor, 129 HP", "Single-speed Automatic",
                "312 km per charge", "ABS, EBD, 2 Airbags, Electronic Stability Program"));
    }

    /**
     * Seed the database with sample data if it's empty.
     */
    public static void seedData() {
        System.out.println("Starting database seeding process...");
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
            System.out.println("PostgreSQL JDBC driver loaded successfully");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                System.out.println("Connected to database successfully");

                // Check if cars table is empty
                boolean carsEmpty = isTableEmpty(conn, "cars");
                System.out.println("Cars table is empty: " + carsEmpty);

                if (carsEmpty) {
                    seedCars(conn);
                    System.out.println("Sample cars added to database");
                    LOGGER.log(Level.INFO, "Sample cars added to database");
                } else {
                    System.out.println("Cars table already has data, skipping seeding");
                }

                // Check if users table has only admin
                boolean onlyAdmin = hasOnlyAdminUser(conn);
                System.out.println("Users table has only admin: " + onlyAdmin);

                if (onlyAdmin) {
                    seedUsers(conn);
                    System.out.println("Sample users added to database");
                    LOGGER.log(Level.INFO, "Sample users added to database");
                } else {
                    System.out.println("Users table already has data, skipping seeding");
                }

                // Check if reviews table is empty
                boolean reviewsEmpty = isTableEmpty(conn, "reviews");
                System.out.println("Reviews table is empty: " + reviewsEmpty);

                if (reviewsEmpty) {
                    seedReviews(conn);
                    System.out.println("Sample reviews added to database");
                    LOGGER.log(Level.INFO, "Sample reviews added to database");
                } else {
                    System.out.println("Reviews table already has data, skipping seeding");
                }
            }
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC driver not found: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "PostgreSQL JDBC driver not found", e);
        } catch (SQLException e) {
            System.err.println("SQL Error seeding database: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "Error seeding database", e);
        } catch (Exception e) {
            System.err.println("Unexpected error seeding database: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "Unexpected error seeding database", e);
        }
        System.out.println("Database seeding process completed");
    }

    /**
     * Check if a table is empty.
     */
    private static boolean isTableEmpty(Connection conn, String tableName) throws SQLException {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + tableName)) {

            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
            return true;
        }
    }

    /**
     * Check if users table has only the admin user.
     */
    private static boolean hasOnlyAdminUser(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE username != 'admin'")) {

            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
            return true;
        }
    }

    /**
     * Seed the cars table with sample data.
     */
    private static void seedCars(Connection conn) throws SQLException {
        System.out.println("Starting to seed cars table with " + SAMPLE_CARS.size() + " sample cars");
        String sql = "INSERT INTO cars (name, brand, model, year, fuel_type, description, " +
                    "image_url, engine_details, transmission, mileage, safety_features) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Car car : SAMPLE_CARS) {
                System.out.println("Adding car: " + car.name + ", " + car.brand + " " + car.model + ", Fuel: " + car.fuelType);

                stmt.setString(1, car.name);
                stmt.setString(2, car.brand);
                stmt.setString(3, car.model);
                stmt.setInt(4, car.year);
                stmt.setString(5, car.fuelType);
                stmt.setString(6, car.description);
                stmt.setString(7, car.imageUrl);
                stmt.setString(8, car.engineDetails);
                stmt.setString(9, car.transmission);
                stmt.setString(10, car.mileage);
                stmt.setString(11, car.safetyFeatures);

                try {
                    int result = stmt.executeUpdate();
                    System.out.println("Car added successfully: " + car.name + ", Result: " + result);
                } catch (SQLException e) {
                    System.err.println("Error adding car " + car.name + ": " + e.getMessage());
                    throw e; // Re-throw to handle in the calling method
                }
            }
            System.out.println("Finished seeding cars table");
        }
    }

    /**
     * Seed the users table with sample data.
     */
    private static void seedUsers(Connection conn) throws SQLException {
        String sql = "INSERT INTO users (username, email, password, is_admin) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Add user1
            stmt.setString(1, "user1");
            stmt.setString(2, "user1@example.com");
            stmt.setString(3, "password1");
            stmt.setBoolean(4, false);
            stmt.executeUpdate();

            // Add user2
            stmt.setString(1, "user2");
            stmt.setString(2, "user2@example.com");
            stmt.setString(3, "password2");
            stmt.setBoolean(4, false);
            stmt.executeUpdate();
        }
    }

    /**
     * Seed the reviews table with sample data.
     */
    private static void seedReviews(Connection conn) throws SQLException {
        // First, get car IDs
        List<Integer> carIds = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id FROM cars ORDER BY id LIMIT 3")) {

            while (rs.next()) {
                carIds.add(rs.getInt("id"));
            }
        }

        if (carIds.size() < 3) {
            LOGGER.log(Level.WARNING, "Not enough cars in database to add sample reviews");
            return;
        }

        String sql = "INSERT INTO reviews (car_id, username, rating, review_text, review_date) " +
                    "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP - (? || ' days')::INTERVAL)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Review 1
            stmt.setInt(1, carIds.get(0));
            stmt.setString(2, "user1");
            stmt.setInt(3, 4);
            stmt.setString(4, "Great car with excellent fuel efficiency. The interior is comfortable and the ride is smooth.");
            stmt.setInt(5, 5);
            stmt.executeUpdate();

            // Review 2
            stmt.setInt(1, carIds.get(0));
            stmt.setString(2, "user2");
            stmt.setInt(3, 5);
            stmt.setString(4, "Best sedan I have ever driven. The performance is outstanding and it looks stylish.");
            stmt.setInt(5, 3);
            stmt.executeUpdate();

            // Review 3
            stmt.setInt(1, carIds.get(1));
            stmt.setString(2, "user1");
            stmt.setInt(3, 5);
            stmt.setString(4, "Amazing electric vehicle with impressive range. The technology is cutting-edge.");
            stmt.setInt(5, 7);
            stmt.executeUpdate();

            // Review 4
            stmt.setInt(1, carIds.get(2));
            stmt.setString(2, "user2");
            stmt.setInt(3, 4);
            stmt.setString(4, "Powerful SUV with great off-road capabilities. Fuel efficiency could be better though.");
            stmt.setInt(5, 2);
            stmt.executeUpdate();
        }

        // Update car ratings
        for (int carId : carIds) {
            updateCarRating(conn, carId);
        }
    }

    /**
     * Update car's average rating and review count.
     */
    private static void updateCarRating(Connection conn, int carId) throws SQLException {
        String sql = "UPDATE cars SET " +
                    "average_rating = (SELECT COALESCE(AVG(rating), 0) FROM reviews WHERE car_id = ?), " +
                    "review_count = (SELECT COUNT(*) FROM reviews WHERE car_id = ?) " +
                    "WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, carId);
            stmt.setInt(2, carId);
            stmt.setInt(3, carId);
            stmt.executeUpdate();
        }
    }

    /**
     * Inner class to represent a car for seeding.
     */
    private static class Car {
        String name;
        String brand;
        String model;
        int year;
        String fuelType;
        String description;
        String imageUrl;
        String engineDetails;
        String transmission;
        String mileage;
        String safetyFeatures;

        Car(String name, String brand, String model, int year, String fuelType,
            String description, String imageUrl, String engineDetails,
            String transmission, String mileage, String safetyFeatures) {

            this.name = name;
            this.brand = brand;
            this.model = model;
            this.year = year;
            this.fuelType = fuelType;
            this.description = description;
            this.imageUrl = imageUrl;
            this.engineDetails = engineDetails;
            this.transmission = transmission;
            this.mileage = mileage;
            this.safetyFeatures = safetyFeatures;
        }
    }
}
