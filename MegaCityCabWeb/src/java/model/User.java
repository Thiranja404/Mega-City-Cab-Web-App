package model;

public class User {
    private int id;
    private String username;
    private String password;
    private String userType; // "admin", "customer", "driver"
    private String name;
    private String address;
    private String nic;
    private String telephone;
    private Integer driverId;
    
    public User() {
    }

    public User(int id, String username, String password, String userType, String name, String address, String nic, String telephone) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.userType = userType;
        this.name = name;
        this.address = address;
        this.nic = nic;
        this.telephone = telephone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    public Integer getDriverId() {
        return driverId;
    }

    public void setDriverId(Integer driverId) {
        this.driverId = driverId;
    }
}