package controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Booking;
import service.BookingService;

@Path("/bookings")
public class BookingController {
    private final BookingService bookingService = new BookingService();
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createBooking(Booking booking) {
        try {
            String result = bookingService.createBooking(booking);
            return Response.status(Response.Status.CREATED).entity(result).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllBookings() {
        try {
            List<Booking> bookings = bookingService.getAllBookings();
            return Response.ok(bookings, MediaType.APPLICATION_JSON).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @GET
    @Path("/customer/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBookingsByCustomerId(@PathParam("id") int customerId) {
        try {
            List<Map<String, Object>> bookings = bookingService.getBookingsByCustomerId(customerId);
            return Response.ok(bookings, MediaType.APPLICATION_JSON).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBookingById(@PathParam("id") int id) {
        try {
            Booking booking = bookingService.getBookingById(id);
            if (booking != null) {
                return Response.ok(booking, MediaType.APPLICATION_JSON).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Booking not found").build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @GET
    @Path("/number/{bookingNumber}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBookingByNumber(@PathParam("bookingNumber") String bookingNumber) {
        try {
            Booking booking = bookingService.getBookingByNumber(bookingNumber);
            if (booking != null) {
                return Response.ok(booking, MediaType.APPLICATION_JSON).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND).entity("Booking not found").build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @PUT
    @Path("/{id}/status/{status}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateBookingStatus(@PathParam("id") int id, @PathParam("status") String status) {
        try {
            String result = bookingService.updateBookingStatus(id, status);
            return Response.ok(result).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
    
    @PUT
    @Path("/{bookingId}/assign/{driverId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response assignDriverToBooking(@PathParam("bookingId") int bookingId, @PathParam("driverId") int driverId) {
        try {
            String result = bookingService.assignDriverToBooking(bookingId, driverId);
            return Response.ok(result).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
}