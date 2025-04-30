# VahanMitra - Vehicle Information and Rating System

VahanMitra is a comprehensive web application for vehicle information management and user ratings. It allows users to browse vehicles by fuel type (petrol, diesel, electric, hybrid), view detailed information, and submit reviews. Administrators can manage vehicles and users through an intuitive interface.

## Features

### User Features
- **User Authentication**: Secure login and registration system
- **Vehicle Browsing**: Browse vehicles with filtering by fuel type (petrol, diesel, electric, hybrid)
- **Vehicle Details**: View comprehensive information about each vehicle
- **User Reviews**: Submit and manage reviews for vehicles
- **User Profile**: Personalized user profile with review history and statistics
- **Responsive Design**: Optimized for all device sizes

### Admin Features
- **Admin Dashboard**: Centralized management interface
- **Vehicle Management**: Add, edit, and delete vehicles
- **User Management**: Create, edit, and delete user accounts
- **Review Moderation**: Manage user reviews
- **Statistics**: View system statistics and reports

## Project Structure

```
vahan_mitra/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── automobile/
│   │   │           ├── dao/         # Data Access Objects
│   │   │           ├── listener/    # Application Listeners
│   │   │           ├── model/       # Data Models
│   │   │           ├── servlet/     # Servlets for handling requests
│   │   │           └── util/        # Utility classes
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   └── web.xml          # Web application configuration
│   │   │   ├── addCar.jsp           # Add vehicle form
│   │   │   ├── adminDashboard.jsp   # Admin dashboard
│   │   │   ├── adminNavbar.jsp      # Admin navigation bar
│   │   │   ├── carDetails.jsp       # Vehicle details page
│   │   │   ├── createUser.jsp       # Create user form
│   │   │   ├── editCar.jsp          # Edit vehicle form
│   │   │   ├── editUser.jsp         # Edit user form
│   │   │   ├── index.jsp            # Home page
│   │   │   ├── login.jsp            # Login page
│   │   │   ├── manageUsers.jsp      # User management page
│   │   │   ├── myReviews.jsp        # User reviews page
│   │   │   ├── navbar.jsp           # User navigation bar
│   │   │   ├── profile.jsp          # User profile page
│   │   │   ├── signup.jsp           # Registration page
│   │   │   ├── vehicleList.jsp      # Vehicle listing page
│   │   │   └── viewAllCars.jsp      # Admin vehicle management page
│   │   └── resources/               # Static resources
└── pom.xml                          # Maven configuration file
```

## Technology Stack

- **Frontend**: JSP, HTML5, CSS3, JavaScript
- **Backend**: Java Servlets, JDBC
- **Database**: PostgreSQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat

## Database Schema

The application uses the following main tables:

- **users**: Stores user information
- **cars**: Stores vehicle information
- **reviews**: Stores user reviews for vehicles

## Setup Instructions

### Prerequisites

- JDK 8 or higher
- Maven 3.6 or higher
- PostgreSQL 12 or higher
- Apache Tomcat 7 or higher

### Installation Steps (Windows)

1. **Clone the repository**
   ```
   git clone https://github.com/yourusername/VahanMitra.git
   cd VahanMitra
   ```

2. **Configure the database**
   - Create a PostgreSQL database named `automobile_ratings`
   - Update database credentials in `src/main/java/com/automobile/dao/UserDAO.java` and other DAO files if needed
   - The application will automatically create the required tables on startup

3. **Build the application**
   ```
   apache-maven-3.9.6\bin\mvn.cmd clean package
   ```

4. **Run the application**
   ```
   apache-maven-3.9.6\bin\mvn.cmd tomcat7:run
   ```

5. **Access the application**
   - Open a web browser and navigate to `http://localhost:9093/vahan_mitra/`
   - Default admin credentials: admin/admin
   - You can register a new user account from the signup page

## Usage Guide

### For Users

1. **Register/Login**: Create an account or log in with existing credentials
2. **Browse Vehicles**: View all vehicles or filter by fuel type
3. **View Details**: Click on a vehicle to see detailed information
4. **Submit Reviews**: Rate and review vehicles you have experience with
5. **Manage Profile**: Update your profile information and view your review history

### For Administrators

1. **Login**: Use admin credentials to access the admin dashboard
2. **Manage Vehicles**: Add, edit, or delete vehicles from the system
3. **Manage Users**: Create, edit, or delete user accounts
4. **Moderate Reviews**: View and manage user reviews
5. **System Settings**: Configure application settings


"# VAAHANMITRA" 
