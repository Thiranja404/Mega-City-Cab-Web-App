package model;

public class LoginResponse {
    private boolean success;
    private String message;
    private int userId;
    private String userType;
    private String name;
    private Integer driverId; // Added driver_id field
    
    public LoginResponse() {
    }

    public LoginResponse(boolean success, String message, int userId, String userType, String name, Integer driverId) {
        this.success = success;
        this.message = message;
        this.userId = userId;
        this.userType = userType;
        this.name = name;
        this.driverId = driverId;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public Integer getDriverId() {
        return driverId;
    }

    public void setDriverId(Integer driverId) {
        this.driverId = driverId;
    }
}