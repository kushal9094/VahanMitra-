package com.automobile.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class to initialize the database schema and tables if they don't exist.
 * This ensures the application can run without requiring manual database setup.
 */
public class DatabaseInitializer {
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializer.class.getName());

    private static final String URL = "jdbc:postgresql://localhost:5432/";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Dedeepya@0608";
    private static final String DB_NAME = "automobile_ratings";

    /**
     * Initialize the database, creating it if it doesn't exist.
     */
    public static void initialize() {
        System.out.println("Starting database initialization...");
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
            System.out.println("PostgreSQL JDBC driver loaded successfully");

            // First, check if database exists
            boolean dbExists = databaseExists();
            System.out.println("Database exists: " + dbExists);

            if (!dbExists) {
                createDatabase();
                System.out.println("Database created successfully");
            }

            // Connect to the database and create tables if they don't exist
            System.out.println("Connecting to database: " + URL + DB_NAME);
            try (Connection conn = DriverManager.getConnection(URL + DB_NAME, USER, PASSWORD)) {
                System.out.println("Connected to database successfully");
                createTables(conn);
                System.out.println("Tables created/verified successfully");
                createAdminUser(conn);
                System.out.println("Admin user created/verified successfully");
            }

            // Seed the database with sample data
            System.out.println("Starting data seeding process");
            DataSeeder.seedData();

            System.out.println("Database initialization completed successfully");
            LOGGER.log(Level.INFO, "Database initialization completed successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC driver not found: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "PostgreSQL JDBC driver not found", e);
        } catch (SQLException e) {
            System.err.println("SQL Error initializing database: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "Error initializing database", e);
        } catch (Exception e) {
            System.err.println("Unexpected error initializing database: " + e.getMessage());
            LOGGER.log(Level.SEVERE, "Unexpected error initializing database", e);
        }
    }

    /**
     * Check if the database exists.
     */
    private static boolean databaseExists() throws SQLException {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT 1 FROM pg_database WHERE datname = ?")) {

            stmt.setString(1, DB_NAME);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Create the database if it doesn't exist.
     */
    private static void createDatabase() throws SQLException {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {

            stmt.executeUpdate("CREATE DATABASE " + DB_NAME);
            LOGGER.log(Level.INFO, "Database created: {0}", DB_NAME);
        }
    }

    /**
     * Create tables if they don't exist.
     */
    private static void createTables(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            // Create users table
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS users (" +
                "id SERIAL PRIMARY KEY, " +
                "username VARCHAR(50) UNIQUE NOT NULL, " +
                "email VARCHAR(100) UNIQUE NOT NULL, " +
                "password VARCHAR(100) NOT NULL, " +
                "is_admin BOOLEAN DEFAULT FALSE" +
                ")"
            );
            try {
                stmt.executeUpdate(
                    "ALTER TABLE users ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE"
                );
            } catch (SQLException e) {
                // Log the error but continue with other tables
                LOGGER.log(Level.WARNING, "Could not add is_admin column: " + e.getMessage());
            }

            // Create cars table
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS cars (" +
                "id SERIAL PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "brand VARCHAR(50) NOT NULL, " +
                "model VARCHAR(50) NOT NULL, " +
                "year INTEGER NOT NULL, " +
                "fuel_type VARCHAR(20) NOT NULL, " +
                "description TEXT, " +
                "image_url VARCHAR(255), " +
                "engine_details TEXT, " +
                "transmission VARCHAR(50), " +
                "mileage VARCHAR(50), " +
                "safety_features TEXT, " +
                "average_rating DECIMAL(3,2) DEFAULT 0, " +
                "review_count INTEGER DEFAULT 0" +
                ")"
            );

            // Create reviews table
            stmt.executeUpdate(
                "CREATE TABLE IF NOT EXISTS reviews (" +
                "id SERIAL PRIMARY KEY, " +
                "car_id INTEGER NOT NULL, " +
                "username VARCHAR(50) NOT NULL, " +
                "rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5), " +
                "review_text TEXT, " +
                "review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "UNIQUE (car_id, username), " +
                "FOREIGN KEY (car_id) REFERENCES cars(id) ON DELETE CASCADE, " +
                "FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE" +
                ")"
            );

            LOGGER.log(Level.INFO, "Tables created successfully");
        }
    }

    /**
     * Create admin user if it doesn't exist.
     */
    private static void createAdminUser(Connection conn) throws SQLException {
        try (PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT 1 FROM users WHERE username = ?")) {

            checkStmt.setString(1, "admin");
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (!rs.next()) {
                    // Admin doesn't exist, create it
                    try (PreparedStatement insertStmt = conn.prepareStatement(
                            "INSERT INTO users (username, email, password, is_admin) VALUES (?, ?, ?, ?)")) {

                        insertStmt.setString(1, "admin");
                        insertStmt.setString(2, "admin@vahanmitra.com");
                        insertStmt.setString(3, "admin");
                        insertStmt.setBoolean(4, true);
                        insertStmt.executeUpdate();

                        LOGGER.log(Level.INFO, "Admin user created");
                    }
                }
            }
        }

        // Add sample car data if the cars table is empty
        try (PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM cars")) {
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) == 0) {
                    System.out.println("No cars found in database, adding sample car data");
                    // No cars exist, add sample data
                    String[] insertQueries = {
                        "INSERT INTO cars (name, brand, model, year, fuel_type, description, engine_details, transmission, mileage, safety_features, image_url) " +
                        "VALUES ('Swift', 'Maruti Suzuki', 'Swift VXI', 2022, 'Petrol', 'A popular hatchback with good fuel efficiency', '1.2L K-Series Engine', 'Manual', '23.2 kmpl', 'ABS, Airbags', 'https://imgd.aeplcdn.com/664x374/n/cw/ec/110233/swift-exterior-right-front-three-quarter-2.jpeg')",

                        "INSERT INTO cars (name, brand, model, year, fuel_type, description, engine_details, transmission, mileage, safety_features, image_url) " +
                        "VALUES ('City', 'Honda', 'City ZX', 2021, 'Petrol', 'Comfortable sedan with premium features', '1.5L i-VTEC Engine', 'Automatic', '18.4 kmpl', 'ABS, 6 Airbags, ESP', 'https://imgd.aeplcdn.com/664x374/n/cw/ec/134287/city-exterior-right-front-three-quarter-3.jpeg')",

                        "INSERT INTO cars (name, brand, model, year, fuel_type, description, engine_details, transmission, mileage, safety_features, image_url) " +
                        "VALUES ('Creta', 'Hyundai', 'Creta SX', 2022, 'Diesel', 'Feature-rich compact SUV', '1.5L CRDi Engine', 'Manual', '21.4 kmpl', 'ABS, 6 Airbags, Hill Assist', 'https://imgd.aeplcdn.com/664x374/n/cw/ec/106257/creta-exterior-right-front-three-quarter-2.jpeg')",

                        "INSERT INTO cars (name, brand, model, year, fuel_type, description, engine_details, transmission, mileage, safety_features, image_url) " +
                        "VALUES ('Nexon EV', 'Tata', 'Nexon EV Max', 2023, 'Electric', 'Popular electric SUV with good range', '40.5 kWh Battery', 'Automatic', '437 km range', 'ABS, EBD, 2 Airbags', 'https://imgd.aeplcdn.com/664x374/n/cw/ec/42611/tata-nexon-ev-left-front-three-quarter8.jpeg')"
                    };

                    try (Statement stmt = conn.createStatement()) {
                        for (String query : insertQueries) {
                            try {
                                int result = stmt.executeUpdate(query);
                                System.out.println("Sample car added, result: " + result);
                            } catch (SQLException e) {
                                System.err.println("Error adding sample car: " + e.getMessage());
                                // Continue with next car even if one fails
                            }
                        }
                        System.out.println("Sample car data added successfully");
                        LOGGER.log(Level.INFO, "Sample car data added");
                    }
                } else {
                    System.out.println("Cars table already has data, skipping sample data insertion");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking or adding sample car data: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
