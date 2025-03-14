package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import model.Booking;

public class BookingDAO {
    
    public String createBooking(Booking booking) throws SQLException, ClassNotFoundException {
        String insertQuery = "INSERT INTO bookings (booking_number, customer_id, customer_name, " +
                            "customer_address, customer_telephone, current_location, destination, " +
                            "status, amount) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
            
            // Generate a unique booking number
            booking.setBookingNumber("BK" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
            
            stmt.setString(1, booking.getBookingNumber());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setString(3, booking.getCustomerName());
            stmt.setString(4, booking.getCustomerAddress());
            stmt.setString(5, booking.getCustomerTelephone());
            stmt.setString(6, booking.getCurrentLocation());
            stmt.setString(7, booking.getDestination());
            stmt.setString(8, "pending"); // Initial status
            stmt.setDouble(9, calculateAmount(booking.getCurrentLocation(), booking.getDestination()));
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Booking created successfully with booking number: " + booking.getBookingNumber();
            } else {
                return "Failed to create booking";
            }
        }
    }
    
    private double calculateAmount(String currentLocation, String destination) {
        // Simple calculation for demo purposes
        // In a real app, you'd use distance calculation algorithms
        return 500.0; // Fixed rate for simplicity
    }
    
    public List<Booking> getAllBookings() throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM bookings";
        List<Booking> bookings = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                bookings.add(booking);
            }
            
            return bookings;
        }
    }
    
    public List<Map<String, Object>> getBookingsByCustomerId(int customerId) throws SQLException, ClassNotFoundException {
        String query = "SELECT booking_number, customer_name, current_location, destination, amount, status " + 
                      "FROM bookings WHERE customer_id = ?";
        List<Map<String, Object>> bookingsList = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("bookingNumber", rs.getString("booking_number"));
                booking.put("customerName", rs.getString("customer_name"));
                booking.put("pickupLocation", rs.getString("current_location"));
                booking.put("destination", rs.getString("destination"));
                booking.put("amount", rs.getDouble("amount"));
                booking.put("status", rs.getString("status"));
                
                bookingsList.add(booking);
            }
            
            return bookingsList;
        }
    }
    
    public Booking getBookingById(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM bookings WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBooking(rs);
            }
            
            return null;
        }
    }
    
    public Booking getBookingByNumber(String bookingNumber) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM bookings WHERE booking_number = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, bookingNumber);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBooking(rs);
            }
            
            return null;
        }
    }
    
    public String updateBookingStatus(int id, String status) throws SQLException, ClassNotFoundException {
        String query = "UPDATE bookings SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, id);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Booking status updated successfully";
            } else {
                return "Failed to update booking status";
            }
        }
    }
    
    public String assignDriverToBooking(int bookingId, int driverId) throws SQLException, ClassNotFoundException {
        String query = "UPDATE bookings SET driver_id = ?, status = 'assigned' WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, driverId);
            stmt.setInt(2, bookingId);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                return "Driver assigned successfully";
            } else {
                return "Failed to assign driver";
            }
        }
    }
    
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setId(rs.getInt("id"));
        booking.setBookingNumber(rs.getString("booking_number"));
        booking.setCustomerId(rs.getInt("customer_id"));
        booking.setCustomerName(rs.getString("customer_name"));
        booking.setCustomerAddress(rs.getString("customer_address"));
        booking.setCustomerTelephone(rs.getString("customer_telephone"));
        booking.setCurrentLocation(rs.getString("current_location"));
        booking.setDestination(rs.getString("destination"));
        booking.setDriverId(rs.getInt("driver_id"));
        booking.setStatus(rs.getString("status"));
        booking.setAmount(rs.getDouble("amount"));
        return booking;
    }
}