package controller;

import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.LoginRequest;
import model.LoginResponse;
import service.UserService;

@Path("/auth")
public class AuthController {
    private final UserService userService = new UserService();

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(LoginRequest request, @Context HttpServletRequest httpRequest) {
        try {
            LoginResponse response = userService.login(request);
            if (response.isSuccess()) {
                // Store userId in the session
                HttpSession session = httpRequest.getSession();
                session.setAttribute("userId", response.getUserId()); // Store the logged-in user's ID
                session.setAttribute("userType", response.getUserType()); // Optionally store user type
                session.setAttribute("name", response.getName()); // Optionally store user's name

                return Response.ok(response, MediaType.APPLICATION_JSON).build();
            } else {
                return Response.status(Response.Status.UNAUTHORIZED).entity(response).build();
            }
        } catch (SQLException | ClassNotFoundException e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Error: " + e.getMessage())
                    .build();
        }
    }
}