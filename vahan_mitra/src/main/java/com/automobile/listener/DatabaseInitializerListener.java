package com.automobile.listener;

import com.automobile.util.DatabaseInitializer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Application listener that initializes the database when the application starts.
 */
public class DatabaseInitializerListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializerListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.log(Level.INFO, "Initializing database...");
        DatabaseInitializer.initialize();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do here
    }
}
