package model;

public class Car {
    private int id;
    private String carNumber;
    private String model;
    private String carType;
    private boolean isAvailable;
    
    public Car() {
    }

    public Car(int id, String carNumber, String model, String carType, boolean isAvailable) {
        this.id = id;
        this.carNumber = carNumber;
        this.model = model;
        this.carType = carType;
        this.isAvailable = isAvailable;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public boolean isIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
}