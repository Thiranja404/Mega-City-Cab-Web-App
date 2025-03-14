package controller;

import java.sql.SQLException;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Driver;
import service.DriverService;

@Path("/drivers")
public class DriverController {
    private final DriverService driverService = new DriverService();

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addDriver(Driver driver) {
        try {
            // Validate required fields
            if (driver.getName() == null || driver.getName().trim().isEmpty() ||
                driver.getUsername() == null || driver.getPassword() == null) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"status\":\"error\",\"message\":\"Name, username, and password are required\"}")
                        .build();
            }

            String result = driverService.addDriver(driver);
            return Response.status(Response.Status.CREATED)
                    .entity("{\"status\":\"success\",\"message\":\"" + result + "\"}")
                    .build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllDrivers() {
        try {
            List<Driver> drivers = driverService.getAllDrivers();
            return Response.ok(drivers).build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getDriverById(@PathParam("id") int id) {
        try {
            Driver driver = driverService.getDriverById(id);
            if (driver != null) {
                return Response.ok(driver).build();
            } else {
                return Response.status(Response.Status.NOT_FOUND)
                        .entity("{\"status\":\"error\",\"message\":\"Driver not found\"}")
                        .build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateDriver(@PathParam("id") int id, Driver driver) {
        try {
            driver.setId(id);
            String result = driverService.updateDriver(driver);
            return Response.ok("{\"status\":\"success\",\"message\":\"" + result + "\"}").build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteDriver(@PathParam("id") int id) {
        try {
            String result = driverService.deleteDriver(id);
            return Response.ok("{\"status\":\"success\",\"message\":\"" + result + "\"}").build();
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}")
                    .build();
        }
    }
}