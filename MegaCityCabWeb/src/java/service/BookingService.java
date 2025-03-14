package service;

import dao.BookingDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import model.Booking;

public class BookingService {
    private final BookingDAO bookingDAO;
    
    public BookingService() {
        bookingDAO = new BookingDAO();
    }
    
    public String createBooking(Booking booking) throws SQLException, ClassNotFoundException {
        return bookingDAO.createBooking(booking);
    }
    
    public List<Booking> getAllBookings() throws SQLException, ClassNotFoundException {
        return bookingDAO.getAllBookings();
    }
    
    public List<Map<String, Object>> getBookingsByCustomerId(int customerId) throws SQLException, ClassNotFoundException {
        return bookingDAO.getBookingsByCustomerId(customerId);
    }
    
    public Booking getBookingById(int id) throws SQLException, ClassNotFoundException {
        return bookingDAO.getBookingById(id);
    }
    
    public Booking getBookingByNumber(String bookingNumber) throws SQLException, ClassNotFoundException {
        return bookingDAO.getBookingByNumber(bookingNumber);
    }
    
    public String updateBookingStatus(int id, String status) throws SQLException, ClassNotFoundException {
        return bookingDAO.updateBookingStatus(id, status);
    }
    
    public String assignDriverToBooking(int bookingId, int driverId) throws SQLException, ClassNotFoundException {
        return bookingDAO.assignDriverToBooking(bookingId, driverId);
    }
}