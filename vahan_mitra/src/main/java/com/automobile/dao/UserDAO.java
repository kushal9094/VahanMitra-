package com.automobile.dao;

import com.automobile.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import java.util.*;

public class UserDAO {
    private static final SessionFactory sessionFactory = new Configuration()
            .configure("hibernate.cfg.xml")
            .addAnnotatedClass(User.class)
            .buildSessionFactory();

    // Method to check if a user exists based on username or email and match the password
    public static boolean checkUser(String usernameOrEmail, String password) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User WHERE username = :identifier OR email = :identifier";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("identifier", usernameOrEmail);
            User user = query.uniqueResult();
            return user != null && user.getPassword().equals(password);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to register a new user
    public static String registerUser(String username, String password, String email) {
        try (Session session = sessionFactory.openSession()) {
            
            // Check if user exists
            if (session.createQuery("FROM User WHERE username = :un OR email = :em", User.class)
                    .setParameter("un", username)
                    .setParameter("em", email)
                    .uniqueResult() != null) {
                return "Username or email already exists.";
            }

            session.beginTransaction();
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password); // Still plain text - consider hashing
            newUser.setEmail(email);
            session.persist(newUser);
            session.getTransaction().commit();
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            return "Registration failed.";
        }
    }

    // Method to update the user's password
    public static String updatePassword(String email, String newPassword) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
    
            // Find user by email
            User user = session.createQuery("FROM User WHERE email = :email", User.class)
                              .setParameter("email", email)
                              .uniqueResult();
    
            if (user == null) {
                return "No user found with this email address";
            }
    
            // Update password
            user.setPassword(newPassword);
            session.update(user);
            transaction.commit();
            
            return "SUCCESS";
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return "Password reset failed: " + e.getMessage();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // Method to fetch all users from the database using Hibernate
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String hql = "FROM User";  // Query to get all users

        try (Session session = sessionFactory.openSession()) {
            Query<User> query = session.createQuery(hql, User.class);
            users = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // Method to delete a user by ID using Hibernate
    public boolean deleteUser(int userId) {
        String hql = "DELETE FROM User WHERE id = :userId";

        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            Query query = session.createQuery(hql);
            query.setParameter("userId", userId);
            int rowsAffected = query.executeUpdate();
            transaction.commit();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
