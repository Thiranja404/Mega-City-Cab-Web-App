package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Car;

public class CarDAO {
    
    public String addCar(Car car) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO cars (car_number, model, car_type, is_available) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, car.getCarNumber());
            stmt.setString(2, car.getModel());
            stmt.setString(3, car.getCarType());
            stmt.setBoolean(4, car.isIsAvailable());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Car added successfully";
            } else {
                return "Failed to add car";
            }
        }
    }
    
    public List<Car> getAllCars() throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM cars";
        List<Car> cars = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Car car = new Car();
                car.setId(rs.getInt("id"));
                car.setCarNumber(rs.getString("car_number"));
                car.setModel(rs.getString("model"));
                car.setCarType(rs.getString("car_type"));
                car.setIsAvailable(rs.getBoolean("is_available"));
                cars.add(car);
            }
            
            return cars;
        }
    }
    
    public Car getCarById(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM cars WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Car car = new Car();
                car.setId(rs.getInt("id"));
                car.setCarNumber(rs.getString("car_number"));
                car.setModel(rs.getString("model"));
                car.setCarType(rs.getString("car_type"));
                car.setIsAvailable(rs.getBoolean("is_available"));
                return car;
            }
            
            return null;
        }
    }
    
    public String updateCar(Car car) throws SQLException, ClassNotFoundException {
        String query = "UPDATE cars SET car_number = ?, model = ?, car_type = ?, is_available = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, car.getCarNumber());
            stmt.setString(2, car.getModel());
            stmt.setString(3, car.getCarType());
            stmt.setBoolean(4, car.isIsAvailable());
            stmt.setInt(5, car.getId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Car updated successfully";
            } else {
                return "Failed to update car";
            }
        }
    }
    
    public String deleteCar(int id) throws SQLException, ClassNotFoundException {
        String query = "DELETE FROM cars WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Car deleted successfully";
            } else {
                return "Failed to delete car";
            }
        }
    }
}
