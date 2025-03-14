package controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/help")
public class HelpController {
    
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response getHelp() {
        String helpText = "Mega City Cab API Usage Guide\n\n" +
                "Authentication:\n" +
                "POST /api/auth/login - Login with username and password\n" +
                "POST /api/auth/register - Register a new user\n\n" +
                
                "User Management:\n" +
                "GET /api/users - Get all users\n" +
                "GET /api/users/{id} - Get a user by ID\n\n" +
                
                "Booking Management:\n" +
                "POST /api/bookings - Create a new booking\n" +
                "GET /api/bookings - Get all bookings\n" +
                "GET /api/bookings/{id} - Get a booking by ID\n" +
                "GET /api/bookings/number/{bookingNumber} - Get a booking by booking number\n" +
                "GET /api/bookings/customer/{id} - Get bookings by customer ID\n" +
                "PUT /api/bookings/{id}/status/{status} - Update booking status\n" +
                "PUT /api/bookings/{bookingId}/assign/{driverId} - Assign a driver to a booking\n\n" +
                
                "Car Management:\n" +
                "POST /api/cars - Add a new car\n" +
                "GET /api/cars - Get all cars\n" +
                "GET /api/cars/{id} - Get a car by ID\n" +
                "PUT /api/cars/{id} - Update a car\n" +
                "DELETE /api/cars/{id} - Delete a car\n\n" +
                
                "Driver Management:\n" +
                "POST /api/drivers - Add a new driver\n" +
                "GET /api/drivers - Get all drivers\n" +
                "GET /api/drivers/{id} - Get a driver by ID\n" +
                "GET /api/drivers/user/{userId} - Get a driver by user ID\n" +
                "PUT /api/drivers/{id} - Update a driver\n" +
                "DELETE /api/drivers/{id} - Delete a driver\n";
        
        return Response.ok(helpText).build();
    }
}
