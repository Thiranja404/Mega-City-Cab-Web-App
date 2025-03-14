<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Drivers</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Manage Drivers</h2>
        
        <!-- Alerts for feedback -->
        <div class="alert alert-success" id="successAlert" style="display: none;">
            Operation completed successfully
        </div>
        <div class="alert alert-danger" id="errorAlert" style="display: none;">
            Error occurred
        </div>
        
        <!-- Driver Form Section -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 id="formTitle">Add New Driver</h5>
            </div>
            <div class="card-body">
                <form id="driverForm">
                    <input type="hidden" id="driverId" value="">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="driverName" class="form-label">Driver Name*</label>
                            <input type="text" class="form-control" id="driverName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="licenseNumber" class="form-label">License Number*</label>
                            <input type="text" class="form-control" id="licenseNumber" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="telephone" class="form-label">Telephone*</label>
                            <input type="tel" class="form-control" id="telephone" required>
                        </div>
                        <div class="col-md-6">
                            <label for="address" class="form-label">Address*</label>
                            <input type="text" class="form-control" id="address" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username*</label>
                            <input type="text" class="form-control" id="username" required>
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password*</label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end">
                        <button type="button" id="cancelBtn" class="btn btn-secondary me-2" style="display: none;">Cancel</button>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Driver List Section -->
        <div class="card">
            <div class="card-header">
                <h5>Driver List</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped" id="driversTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>License Number</th>
                            <th>Telephone</th>
                            <th>Address</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Data will be loaded here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Confirm Action</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalMessage">
                    Are you sure you want to delete this driver?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            let isEditing = false;
            let driverToDelete = null;
            const confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            
            // Load drivers when page loads
            loadDrivers();
            
            // Form submission handler
            $('#driverForm').submit(function(e) {
                e.preventDefault();
                
                // Validate form
                if (!validateForm()) {
                    return;
                }
                
                // Collect form data
                const driverData = {
                    name: $('#driverName').val(),
                    licenseNumber: $('#licenseNumber').val(),
                    telephone: $('#telephone').val(),
                    address: $('#address').val(),
                    username: $('#username').val(), // New field
                    password: $('#password').val()  // New field
                };
                
                if (isEditing) {
                    // Update existing driver
                    updateDriver($('#driverId').val(), driverData);
                } else {
                    // Add new driver
                    addDriver(driverData);
                }
            });
            
            // Cancel button handler
            $('#cancelBtn').click(function() {
                resetForm();
            });
            
            // Event delegation for edit buttons
            $(document).on('click', '.edit-btn', function() {
                const driverId = $(this).data('id');
                editDriver(driverId);
            });
            
            // Event delegation for delete buttons
            $(document).on('click', '.delete-btn', function() {
                driverToDelete = $(this).data('id');
                // Show confirmation modal
                confirmationModal.show();
            });
            
            // Confirm delete button in modal
            $('#confirmDeleteBtn').click(function() {
                if (driverToDelete) {
                    deleteDriver(driverToDelete);
                    confirmationModal.hide();
                }
            });
            
            // Function to load all drivers
            function loadDrivers() {
                $.ajax({
                    url: 'api/drivers',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        let tableBody = $('#driversTable tbody');
                        tableBody.empty();
                        
                        $.each(data, function(i, driver) {
                            let row = $('<tr>');
                            row.append($('<td>').text(driver.id));
                            row.append($('<td>').text(driver.name));
                            row.append($('<td>').text(driver.licenseNumber));
                            row.append($('<td>').text(driver.telephone));
                            row.append($('<td>').text(driver.address));
                            
                            // Action buttons
                            let actionCell = $('<td>');
                            actionCell.append(
                                $('<button>').addClass('btn btn-sm btn-primary me-1 edit-btn')
                                    .attr('data-id', driver.id)
                                    .html('<i class="bi bi-pencil"></i> Edit')
                            );
                            actionCell.append(
                                $('<button>').addClass('btn btn-sm btn-danger delete-btn')
                                    .attr('data-id', driver.id)
                                    .html('<i class="bi bi-trash"></i> Delete')
                            );
                            
                            row.append(actionCell);
                            tableBody.append(row);
                        });
                    },
                    error: function(xhr, status, error) {
                        showError('Error loading drivers: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Function to add a new driver
            function addDriver(driverData) {
                $.ajax({
                    url: 'api/drivers',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(driverData),
                    success: function(response) {
                        showSuccess('Driver added successfully');
                        resetForm();
                        loadDrivers();
                    },
                    error: function(xhr, status, error) {
                        showError('Error adding driver: ' + xhr.responseJSON?.message || error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Function to get driver by ID for editing
            function editDriver(id) {
                $.ajax({
                    url: 'api/drivers/' + id,
                    type: 'GET',
                    dataType: 'json',
                    success: function(driver) {
                        // Populate form with driver data
                        $('#driverId').val(driver.id);
                        $('#driverName').val(driver.name);
                        $('#licenseNumber').val(driver.licenseNumber);
                        $('#telephone').val(driver.telephone);
                        $('#address').val(driver.address);
                        $('#username').val(driver.username); // New field
                        $('#password').val(driver.password); // New field
                        
                        // Update UI to indicate editing mode
                        $('#formTitle').text('Edit Driver');
                        $('#cancelBtn').show();
                        isEditing = true;
                        
                        // Scroll to the form
                        $('html, body').animate({
                            scrollTop: $("#driverForm").offset().top - 100
                        }, 500);
                    },
                    error: function(xhr, status, error) {
                        showError('Error fetching driver details: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Function to update an existing driver
            function updateDriver(id, driverData) {
                $.ajax({
                    url: 'api/drivers/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(driverData),
                    success: function(response) {
                        showSuccess('Driver updated successfully');
                        resetForm();
                        loadDrivers();
                    },
                    error: function(xhr, status, error) {
                        showError('Error updating driver: ' + xhr.responseJSON?.message || error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Function to delete a driver
            function deleteDriver(id) {
                $.ajax({
                    url: 'api/drivers/' + id,
                    type: 'DELETE',
                    success: function(response) {
                        showSuccess('Driver deleted successfully');
                        loadDrivers();
                    },
                    error: function(xhr, status, error) {
                        showError('Error deleting driver: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Function to validate the form
            function validateForm() {
                let isValid = true;
                
                // Check required fields
                if (!$('#driverName').val().trim()) {
                    showError('Driver name is required');
                    isValid = false;
                }
                
                if (!$('#licenseNumber').val().trim()) {
                    showError('License number is required');
                    isValid = false;
                }
                
                if (!$('#telephone').val().trim()) {
                    showError('Telephone is required');
                    isValid = false;
                }
                
                if (!$('#address').val().trim()) {
                    showError('Address is required');
                    isValid = false;
                }
                
                if (!$('#username').val().trim()) {
                    showError('Username is required');
                    isValid = false;
                }
                
                if (!$('#password').val().trim()) {
                    showError('Password is required');
                    isValid = false;
                }
                
                return isValid;
            }
            
            // Function to reset the form
            function resetForm() {
                $('#driverForm')[0].reset();
                $('#driverId').val('');
                $('#formTitle').text('Add New Driver');
                $('#cancelBtn').hide();
                isEditing = false;
            }
            
            // Function to show success message
            function showSuccess(message) {
                $('#successAlert').text(message).show();
                setTimeout(function() {
                    $('#successAlert').fadeOut();
                }, 3000);
            }
            
            // Function to show error message
            function showError(message) {
                $('#errorAlert').text(message).show();
                setTimeout(function() {
                    $('#errorAlert').fadeOut();
                }, 3000);
            }
        });
    </script>
</body>
</html>