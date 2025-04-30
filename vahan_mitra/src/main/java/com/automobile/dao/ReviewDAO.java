package com.automobile.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.automobile.model.Review;
import com.automobile.util.DatabaseConnection;

public class ReviewDAO {

    // Add a new review
    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (car_id, username, rating, review_text, review_date) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, review.getCarId());
            stmt.setString(2, review.getUsername());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getReviewText());
            stmt.setTimestamp(5, new Timestamp(review.getReviewDate().getTime()));

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Update car's average rating and review count
                updateCarRating(review.getCarId());
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get reviews for a specific car
    public List<Review> getReviewsByCarId(int carId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE car_id = ? ORDER BY review_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, carId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setCarId(rs.getInt("car_id"));
                review.setUsername(rs.getString("username"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Get reviews by a specific user
    public List<Review> getReviewsByUsername(String username) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as car_name, c.brand as car_brand FROM reviews r " +
                     "JOIN cars c ON r.car_id = c.id " +
                     "WHERE r.username = ? ORDER BY r.review_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setCarId(rs.getInt("car_id"));
                review.setUsername(rs.getString("username"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Update a review
    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, review_text = ? WHERE id = ? AND username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getReviewText());
            stmt.setInt(3, review.getId());
            stmt.setString(4, review.getUsername());

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Update car's average rating
                updateCarRating(review.getCarId());
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a review
    public boolean deleteReview(int reviewId, String username) {
        // First get the car ID for the review
        int carId = -1;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT car_id FROM reviews WHERE id = ?")) {

            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                carId = rs.getInt("car_id");
            } else {
                return false; // Review not found
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Now delete the review
        String sql = "DELETE FROM reviews WHERE id = ? AND username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);
            stmt.setString(2, username);

            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0 && carId != -1) {
                // Update car's average rating
                updateCarRating(carId);
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update car's average rating and review count
    private void updateCarRating(int carId) {
        String sql = "UPDATE cars SET average_rating = " +
                    "(SELECT COALESCE(AVG(rating), 0) FROM reviews WHERE car_id = ?), " +
                    "review_count = (SELECT COUNT(*) FROM reviews WHERE car_id = ?) " +
                    "WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, carId);
            stmt.setInt(2, carId);
            stmt.setInt(3, carId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Check if a user has already reviewed a car
    public boolean hasUserReviewedCar(String username, int carId) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE username = ? AND car_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setInt(2, carId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get a specific review
    public Review getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setCarId(rs.getInt("car_id"));
                review.setUsername(rs.getString("username"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                return review;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all reviews (for admin)
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as car_name FROM reviews r " +
                     "JOIN cars c ON r.car_id = c.id " +
                     "ORDER BY r.review_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setCarId(rs.getInt("car_id"));
                review.setUsername(rs.getString("username"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Delete a review by admin (can delete any review)
    public boolean deleteReviewByAdmin(int reviewId) {
        // First get the car ID for the review
        int carId = -1;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT car_id FROM reviews WHERE id = ?")) {

            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                carId = rs.getInt("car_id");
            } else {
                return false; // Review not found
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        // Now delete the review
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);

            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0 && carId != -1) {
                // Update car's average rating
                updateCarRating(carId);
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get the number of reviews by a user
    public static int getReviewCountByUser(String username) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get the average rating given by a user
    public static String getAverageRatingByUser(String username) {
        String sql = "SELECT AVG(rating) FROM reviews WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                double avgRating = rs.getDouble(1);
                if (rs.wasNull()) {
                    return "0.0";
                }
                DecimalFormat df = new DecimalFormat("#.#");
                return df.format(avgRating);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "0.0";
    }
}
