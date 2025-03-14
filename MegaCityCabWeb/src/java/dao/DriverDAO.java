package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Driver;

public class DriverDAO {

    public String addDriver(Driver driver) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    try {
        conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false); // Start transaction

        // Insert into users table
        String userQuery = "INSERT INTO users (username, password, user_type, name) VALUES (?, ?, ?, ?)";
        int userId = 0;
        try (PreparedStatement userStmt = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS)) {
            userStmt.setString(1, driver.getUsername());
            userStmt.setString(2, driver.getPassword());
            userStmt.setString(3, "driver"); // Default userType for drivers
            userStmt.setString(4, driver.getName()); // Include name in users table

            int userAffectedRows = userStmt.executeUpdate();
            if (userAffectedRows == 0) {
                conn.rollback();
                return "Failed to add user";
            }
            
            // Get the auto-generated user ID
            try (ResultSet generatedKeys = userStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                } else {
                    conn.rollback();
                    return "Failed to get user ID";
                }
            }

            // Insert into drivers table
            String driverQuery = "INSERT INTO drivers (name, license_number, telephone, address) VALUES (?, ?, ?, ?)";
            try (PreparedStatement driverStmt = conn.prepareStatement(driverQuery, Statement.RETURN_GENERATED_KEYS)) {
                driverStmt.setString(1, driver.getName());
                driverStmt.setString(2, driver.getLicenseNumber());
                driverStmt.setString(3, driver.getTelephone());
                driverStmt.setString(4, driver.getAddress());

                int driverAffectedRows = driverStmt.executeUpdate();
                if (driverAffectedRows == 0) {
                    conn.rollback();
                    return "Failed to add driver";
                }
                
                // Get the auto-generated driver ID
                int driverId = 0;
                try (ResultSet generatedKeys = driverStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        driverId = generatedKeys.getInt(1);
                    } else {
                        conn.rollback();
                        return "Failed to get driver ID";
                    }
                }
                
                // Update the user with the driver_id
                String updateUserQuery = "UPDATE users SET driver_id = ? WHERE id = ?";
                try (PreparedStatement updateUserStmt = conn.prepareStatement(updateUserQuery)) {
                    updateUserStmt.setInt(1, driverId);
                    updateUserStmt.setInt(2, userId);
                    
                    int updateAffectedRows = updateUserStmt.executeUpdate();
                    if (updateAffectedRows == 0) {
                        conn.rollback();
                        return "Failed to update user with driver ID";
                    }
                }
            }

            conn.commit(); // Commit transaction
            return "Driver added successfully";
        }
    } catch (SQLException e) {
        if (conn != null) {
            conn.rollback();
        }
        throw e;
    } finally {
        if (conn != null) {
            conn.setAutoCommit(true); // Reset auto-commit
            conn.close();
        }
    }
}

    public List<Driver> getAllDrivers() throws SQLException, ClassNotFoundException {
        String query = "SELECT id, name, license_number, telephone, address FROM drivers";
        List<Driver> drivers = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setName(rs.getString("name"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setTelephone(rs.getString("telephone"));
                driver.setAddress(rs.getString("address"));
                drivers.add(driver);
            }

            return drivers;
        }
    }

    public Driver getDriverById(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT id, name, license_number, telephone, address FROM drivers WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Driver driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setName(rs.getString("name"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setTelephone(rs.getString("telephone"));
                driver.setAddress(rs.getString("address"));
                return driver;
            }

            return null;
        }
    }

    public String updateDriver(Driver driver) throws SQLException, ClassNotFoundException {
        String query = "UPDATE drivers SET name = ?, license_number = ?, telephone = ?, address = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, driver.getName());
            stmt.setString(2, driver.getLicenseNumber());
            stmt.setString(3, driver.getTelephone());
            stmt.setString(4, driver.getAddress());
            stmt.setInt(5, driver.getId());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                return "Driver updated successfully";
            } else {
                return "Driver not found or no changes made";
            }
        }
    }

    public String deleteDriver(int id) throws SQLException, ClassNotFoundException {
        String query = "DELETE FROM drivers WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                return "Driver deleted successfully";
            } else {
                return "Driver not found";
            }
        }
    }
}