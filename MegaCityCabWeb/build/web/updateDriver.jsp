<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Driver - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h4 class="mb-0">Update Driver</h4>
                    </div>
                    <div class="card-body">
                        <form id="updateDriverForm">
                            <input type="hidden" id="driverId">
                            <div class="mb-3">
                                <label for="name" class="form-label">Driver Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="licenseNumber" class="form-label">License Number</label>
                                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="form-label">Telephone</label>
                                <input type="tel" class="form-control" id="telephone" name="telephone" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="carId" class="form-label">Car ID (leave empty for no assignment)</label>
                                <input type="number" class="form-control" id="carId" name="carId">
                            </div>
                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="window.location.href='manageDrivers.jsp'">Cancel</button>
                                <button type="submit" class="btn btn-warning">Update Driver</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Get driver ID from URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const driverId = urlParams.get('id');
            
            if (driverId) {
                document.getElementById('driverId').value = driverId;
                fetchDriverDetails(driverId);
            } else {
                alert('No driver ID provided. Please select a driver to update.');
                window.location.href = 'manageDrivers.jsp';
            }
        });
        
        function fetchDriverDetails(id) {
            fetch(`http://localhost:8080/MegaCityCabWeb/api/drivers/${id}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Driver not found');
                    }
                    return response.json();
                })
                .then(driver => {
                    document.getElementById('name').value = driver.name;
                    document.getElementById('licenseNumber').value = driver.licenseNumber;
                    document.getElementById('telephone').value = driver.telephone;
                    document.getElementById('address').value = driver.address;
                    
                    if (driver.carId) {
                        document.getElementById('carId').value = driver.carId;
                    }
                })
                .catch(error => {
                    alert('Error fetching driver details: ' + error.message);
                    window.location.href = 'manageDrivers.jsp';
                });
        }
        
        document.getElementById('updateDriverForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const driverId = document.getElementById('driverId').value;
            const carIdInput = document.getElementById('carId').value;
            
            const driver = {
                name: document.getElementById('name').value,
                licenseNumber: document.getElementById('licenseNumber').value,
                telephone: document.getElementById('telephone').value,
                address: document.getElementById('address').value
            };
            
            // Only add carId if it's not empty
            if (carIdInput.trim() !== '') {
                driver.carId = parseInt(carIdInput);
            }
            
            fetch(`http://localhost:8080/MegaCityCabWeb/api/drivers/${driverId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(driver)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(error => {
                        throw new Error(error.message || 'Failed to update driver');
                    });
                }
                return response.json();
            })
            .then(data => {
                alert(data.message || 'Driver updated successfully');
                window.location.href = 'manageDrivers.jsp';
            })
            .catch(error => {
                console.error('Error updating driver:', error);
                alert('Error: ' + error.message);
            });
        });
    </script>
</body>
</html>