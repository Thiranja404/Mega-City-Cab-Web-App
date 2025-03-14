package service;

import dao.CarDAO;
import java.sql.SQLException;
import java.util.List;
import model.Car;

public class CarService {
    private final CarDAO carDAO;
    
    public CarService() {
        carDAO = new CarDAO();
    }
    
    public String addCar(Car car) throws SQLException, ClassNotFoundException {
        return carDAO.addCar(car);
    }
    
    public List<Car> getAllCars() throws SQLException, ClassNotFoundException {
        return carDAO.getAllCars();
    }
    
    public Car getCarById(int id) throws SQLException, ClassNotFoundException {
        return carDAO.getCarById(id);
    }
    
    public String updateCar(Car car) throws SQLException, ClassNotFoundException {
        return carDAO.updateCar(car);
    }
    
    public String deleteCar(int id) throws SQLException, ClassNotFoundException {
        return carDAO.deleteCar(id);
    }
}