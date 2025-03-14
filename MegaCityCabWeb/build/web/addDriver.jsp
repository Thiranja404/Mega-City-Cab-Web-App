<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Driver - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Add New Driver</h4>
                    </div>
                    <div class="card-body">
                        <form id="addDriverForm">
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
                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="window.location.href='manageDrivers.jsp'">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add Driver</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('addDriverForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const driver = {
                name: document.getElementById('name').value,
                licenseNumber: document.getElementById('licenseNumber').value,
                telephone: document.getElementById('telephone').value,
                address: document.getElementById('address').value
            };
            
            fetch('http://localhost:8080/MegaCityCabWeb/api/drivers', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(driver)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(error => {
                        throw new Error(error.message || 'Failed to add driver');
                    });
                }
                return response.json();
            })
            .then(data => {
                alert(data.message || 'Driver added successfully');
                window.location.href = 'manageDrivers.jsp';
            })
            .catch(error => {
                console.error('Error adding driver:', error);
                alert('Error: ' + error.message);
            });
        });
    </script>
</body>
</html>