package com.automobile.dao;

import java.sql.*;

public class UserDAO {
    private static final String URL = "jdbc:postgresql://localhost:5432/automobile_ratings";
    private static final String USER = "postgres";
    private static final String PASSWORD = "dvgs";

    public static boolean checkUser(String usernameOrEmail, String password) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "SELECT password FROM users WHERE username = ? OR email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, usernameOrEmail);
                stmt.setString(2, usernameOrEmail);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    return password.equals(dbPassword); // Plain-text comparison
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String registerUser(String username, String password, String email) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, password); // Store plain-text password
                stmt.setString(3, email);
                stmt.executeUpdate();
                return "SUCCESS";
            }
        } catch (SQLException e) {
            if ("23505".equals(e.getSQLState())) {
                return "Username or email already exists.";
            }
            e.printStackTrace();
            return "Registration failed.";
        }
    }
}