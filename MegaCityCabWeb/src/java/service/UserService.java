package service;

import dao.UserDAO;
import java.sql.SQLException;
import java.util.List;
import model.LoginRequest;
import model.LoginResponse;
import model.User;

public class UserService {
    private final UserDAO userDAO;
    
    public UserService() {
        userDAO = new UserDAO();
    }
    
    public LoginResponse login(LoginRequest request) throws SQLException, ClassNotFoundException {
        return userDAO.login(request);
    }
    
    public String registerUser(User user) throws SQLException, ClassNotFoundException {
        return userDAO.registerUser(user);
    }
    
    public User getUserById(int id) throws SQLException, ClassNotFoundException {
        return userDAO.getUserById(id);
    }
    
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        return userDAO.getAllUsers();
    }
}