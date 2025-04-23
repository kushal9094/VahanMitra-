package com.automobile.dao;

import com.automobile.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class UserDAO {
    private static final SessionFactory sessionFactory = new Configuration()
            .configure("hibernate.cfg.xml")
            .addAnnotatedClass(User.class)
            .buildSessionFactory();

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
}