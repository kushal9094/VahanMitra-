package com.automobile.servlet;

import com.automobile.dao.ReviewDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteReviewServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in or is admin
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        boolean isAdmin = session.getAttribute("admin") != null;

        if (username == null && !isAdmin) {
            response.sendRedirect("login.jsp?error=LoginRequired");
            return;
        }

        // Get review ID from request parameter
        String reviewIdParam = request.getParameter("id");
        if (reviewIdParam == null || reviewIdParam.isEmpty()) {
            reviewIdParam = request.getParameter("reviewId"); // Try alternate parameter name
        }

        if (reviewIdParam != null && !reviewIdParam.isEmpty()) {
            try {
                int reviewId = Integer.parseInt(reviewIdParam);
                ReviewDAO reviewDAO = new ReviewDAO();

                boolean success;
                if (isAdmin) {
                    // Admin can delete any review
                    success = reviewDAO.deleteReviewByAdmin(reviewId);
                } else {
                    // Regular user can only delete their own reviews
                    success = reviewDAO.deleteReview(reviewId, username);
                }

                if (success) {
                    if (isAdmin) {
                        response.sendRedirect("viewAllReviews.jsp?success=true");
                    } else {
                        response.sendRedirect("myReviews.jsp?success=ReviewDeleted");
                    }
                } else {
                    if (isAdmin) {
                        response.sendRedirect("viewAllReviews.jsp?error=DeleteFailed");
                    } else {
                        response.sendRedirect("myReviews.jsp?error=DeleteFailed");
                    }
                }

            } catch (NumberFormatException e) {
                if (isAdmin) {
                    response.sendRedirect("viewAllReviews.jsp?error=InvalidReviewId");
                } else {
                    response.sendRedirect("myReviews.jsp?error=InvalidReviewId");
                }
            }
        } else {
            if (isAdmin) {
                response.sendRedirect("viewAllReviews.jsp?error=MissingReviewId");
            } else {
                response.sendRedirect("myReviews.jsp?error=MissingReviewId");
            }
        }
    }
}
