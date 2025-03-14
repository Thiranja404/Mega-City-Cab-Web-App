package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.LoginRequest;
import model.LoginResponse;
import model.User;

public class UserDAO {
    
    public LoginResponse login(LoginRequest request) throws SQLException, ClassNotFoundException {
    String query = "SELECT * FROM users WHERE username = ? AND password = ?";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setString(1, request.getUsername());
        stmt.setString(2, request.getPassword());
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            int id = rs.getInt("id");
            String userType = rs.getString("user_type");
            String name = rs.getString("name");
            Integer driverId = rs.getObject("driver_id") != null ? rs.getInt("driver_id") : null;
            
            return new LoginResponse(true, "Login successful", id, userType, name, driverId);
        } else {
            return new LoginResponse(false, "Invalid username or password", 0, "", "", null);
        }
    }
}
    
    public String registerUser(User user) throws SQLException, ClassNotFoundException {
        String checkExisting = "SELECT COUNT(*) FROM users WHERE username = ?";
        String insertQuery = "INSERT INTO users (username, password, user_type, name, address, nic, telephone) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkExisting)) {
            
            checkStmt.setString(1, user.getUsername());
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            
            if (count > 0) {
                return "Username already exists";
            }
            
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
                insertStmt.setString(1, user.getUsername());
                insertStmt.setString(2, user.getPassword());
                insertStmt.setString(3, user.getUserType());
                insertStmt.setString(4, user.getName());
                insertStmt.setString(5, user.getAddress());
                insertStmt.setString(6, user.getNic());
                insertStmt.setString(7, user.getTelephone());
                
                int affectedRows = insertStmt.executeUpdate();
                
                if (affectedRows > 0) {
                    return "User registered successfully";
                } else {
                    return "Failed to register user";
                }
            }
        }
    }
    
    public User getUserById(int id) throws SQLException, ClassNotFoundException {
    String query = "SELECT * FROM users WHERE id = ?";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(""); // Don't return password
            user.setUserType(rs.getString("user_type"));
            user.setName(rs.getString("name"));
            user.setAddress(rs.getString("address"));
            user.setNic(rs.getString("nic"));
            user.setTelephone(rs.getString("telephone"));
            
            // Set driver_id if not null
            if (rs.getObject("driver_id") != null) {
                user.setDriverId(rs.getInt("driver_id"));
            }
            
            return user;
        }
        
        return null;
    }
}
    
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
    String query = "SELECT * FROM users";
    List<User> users = new ArrayList<>();
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {
        
        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(""); // Don't return password
            user.setUserType(rs.getString("user_type"));
            user.setName(rs.getString("name"));
            user.setAddress(rs.getString("address"));
            user.setNic(rs.getString("nic"));
            user.setTelephone(rs.getString("telephone"));
            
            // Set driver_id if not null
            if (rs.getObject("driver_id") != null) {
                user.setDriverId(rs.getInt("driver_id"));
            }
            
            users.add(user);
        }
        
        return users;
    }
}
}
