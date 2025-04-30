package com.automobile.servlet;

import com.automobile.dao.ReviewDAO;
import com.automobile.model.Review;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class SubmitRatingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp?error=LoginRequired");
            return;
        }

        // Read form fields
        String carIdParam = request.getParameter("carId");
        String ratingParam = request.getParameter("rating");
        String reviewText = request.getParameter("review");

        try {
            int carId = Integer.parseInt(carIdParam);
            int rating = Integer.parseInt(ratingParam);

            // Validate rating
            if (rating < 1 || rating > 5) {
                response.sendRedirect("rateVehicle.jsp?id=" + carId + "&error=InvalidRating");
                return;
            }

            // Create Review object
            Review review = new Review();
            review.setCarId(carId);
            review.setUsername(username);
            review.setRating(rating);
            review.setReviewText(reviewText);
            review.setReviewDate(new Date());

            // Check if user has already reviewed this car
            ReviewDAO reviewDAO = new ReviewDAO();
            boolean hasReviewed = reviewDAO.hasUserReviewedCar(username, carId);

            boolean success;
            if (hasReviewed) {
                // Update existing review
                // First get the existing review ID
                List<Review> userReviews = reviewDAO.getReviewsByUsername(username);
                int reviewId = -1;
                for (Review r : userReviews) {
                    if (r.getCarId() == carId) {
                        reviewId = r.getId();
                        break;
                    }
                }

                if (reviewId != -1) {
                    review.setId(reviewId);
                    success = reviewDAO.updateReview(review);
                } else {
                    success = false;
                }
            } else {
                // Add new review
                success = reviewDAO.addReview(review);
            }

            if (success) {
                response.sendRedirect("carDetails.jsp?id=" + carId + "&success=RatingSubmitted");
            } else {
                response.sendRedirect("rateVehicle.jsp?id=" + carId + "&error=Failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("vehicleList.jsp?error=InvalidParameters");
        }
    }
}
