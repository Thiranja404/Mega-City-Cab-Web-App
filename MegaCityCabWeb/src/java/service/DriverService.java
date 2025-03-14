package service;

import dao.DriverDAO;
import java.sql.SQLException;
import java.util.List;
import model.Driver;

public class DriverService {
    private final DriverDAO driverDAO;

    public DriverService() {
        driverDAO = new DriverDAO();
    }

    public String addDriver(Driver driver) throws SQLException, ClassNotFoundException {
        return driverDAO.addDriver(driver);
    }

    public List<Driver> getAllDrivers() throws SQLException, ClassNotFoundException {
        return driverDAO.getAllDrivers();
    }

    public Driver getDriverById(int id) throws SQLException, ClassNotFoundException {
        return driverDAO.getDriverById(id);
    }

    public String updateDriver(Driver driver) throws SQLException, ClassNotFoundException {
        return driverDAO.updateDriver(driver);
    }

    public String deleteDriver(int id) throws SQLException, ClassNotFoundException {
        return driverDAO.deleteDriver(id);
    }
}