<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Cars</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Manage Cars</h2>
        
        <!-- Alerts for feedback -->
        <div class="alert alert-success" id="successAlert" style="display: none;">
            Operation completed successfully
        </div>
        <div class="alert alert-danger" id="errorAlert" style="display: none;">
            Error occurred
        </div>
        
        <!-- Car Form Section -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 id="formTitle">Add New Car</h5>
            </div>
            <div class="card-body">
                <form id="carForm">
                    <input type="hidden" id="carId" value="">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="carNumber" class="form-label">Car Number*</label>
                            <input type="text" class="form-control" id="carNumber" required>
                        </div>
                        <div class="col-md-6">
                            <label for="model" class="form-label">Model*</label>
                            <input type="text" class="form-control" id="model" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="carType" class="form-label">Car Type*</label>
                            <select class="form-select" id="carType" required>
                                <option value="">Select car type</option>
                                <option value="Sedan">Sedan</option>
                                <option value="SUV">SUV</option>
                                <option value="Van">Van</option>
                                <option value="Luxury">Luxury</option>
                                <option value="Compact">Compact</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="isAvailable" class="form-label">Availability*</label>
                            <select class="form-select" id="isAvailable" required>
                                <option value="true">Available</option>
                                <option value="false">Not Available</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end">
                        <button type="button" id="cancelBtn" class="btn btn-secondary me-2" style="display: none;">Cancel</button>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Car List Section -->
        <div class="card">
            <div class="card-header">
                <h5>Car List</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped" id="carsTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Car Number</th>
                                <th>Model</th>
                                <th>Car Type</th>
                                <th>Availability</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be loaded here -->
                        </tbody>
                    </table>
                </div>
                <div id="noDataMessage" class="text-center p-3" style="display: none;">
                    <p>No cars found. Add a new car above.</p>
                </div>
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
                    Are you sure you want to delete this car?
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
            let carToDelete = null;
            const confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            
            // Load cars when page loads
            loadCars();
            
            // Form submission handler
            $('#carForm').submit(function(e) {
                e.preventDefault();
                
                // Validate form
                if (!validateForm()) {
                    return;
                }
                
                // Collect form data
                const carData = {
                    "carNumber": $('#carNumber').val().trim(),
                    "model": $('#model').val().trim(),
                    "carType": $('#carType').val(),
                    "isAvailable": $('#isAvailable').val() === 'true'
                };
                
                if (isEditing) {
                    // Update existing car
                    updateCar($('#carId').val(), carData);
                } else {
                    // Add new car
                    addCar(carData);
                }
            });
            
            // Cancel button handler
            $('#cancelBtn').click(function() {
                resetForm();
            });
            
            // Event delegation for edit buttons
            $(document).on('click', '.edit-btn', function() {
                const carId = $(this).data('id');
                editCar(carId);
            });
            
            // Event delegation for delete buttons
            $(document).on('click', '.delete-btn', function() {
                carToDelete = $(this).data('id');
                // Show confirmation modal
                confirmationModal.show();
            });
            
            // Confirm delete button in modal
            $('#confirmDeleteBtn').click(function() {
                if (carToDelete) {
                    deleteCar(carToDelete);
                    confirmationModal.hide();
                }
            });
            
            // Function to load all cars
            function loadCars() {
                $.ajax({
                    url: 'api/cars',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        let tableBody = $('#carsTable tbody');
                        tableBody.empty();
                        
                        if (data && data.length > 0) {
                            $('#carsTable').show();
                            $('#noDataMessage').hide();
                            
                            $.each(data, function(i, car) {
                                let row = $('<tr>');
                                row.append($('<td>').text(car.id));
                                row.append($('<td>').text(car.carNumber));
                                row.append($('<td>').text(car.model));
                                row.append($('<td>').text(car.carType));
                                
                                // Availability with colored badge
                                const availabilityStatus = car.isAvailable ? 
                                    '<span class="badge bg-success">Available</span>' : 
                                    '<span class="badge bg-danger">Not Available</span>';
                                row.append($('<td>').html(availabilityStatus));
                                
                                // Action buttons
                                let actionCell = $('<td>');
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-primary me-1 edit-btn')
                                        .attr('data-id', car.id)
                                        .html('<i class="bi bi-pencil"></i> Edit')
                                );
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-danger delete-btn')
                                        .attr('data-id', car.id)
                                        .html('<i class="bi bi-trash"></i> Delete')
                                );
                                
                                row.append(actionCell);
                                tableBody.append(row);
                            });
                        } else {
                            $('#carsTable').hide();
                            $('#noDataMessage').show();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr.responseText);
                        showError('Error loading cars: ' + (xhr.responseJSON?.message || error || 'Server error'));
                    }
                });
            }
            
            // Function to add a new car
            function addCar(carData) {
                $.ajax({
                    url: 'api/cars',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(carData),
                    dataType: 'text', // Change to 'text' instead of the default 'json'
                    success: function(response) {
                        showSuccess('Car added successfully');
                        resetForm();
                        loadCars();
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr.responseText);
                        let errorMsg = 'Error adding car';
                        
                        // Simple error handling without trying to parse JSON
                        if (xhr.responseText && xhr.responseText.trim()) {
                            errorMsg += ': ' + xhr.responseText.trim();
                        } else if (error) {
                            errorMsg += ': ' + error;
                        }
                        
                        showError(errorMsg);
                    }
                });
            }
            
            // Function to get car by ID for editing
            function editCar(id) {
                $.ajax({
                    url: 'api/cars/' + id,
                    type: 'GET',
                    dataType: 'json',
                    success: function(car) {
                        // Populate form with car data
                        $('#carId').val(car.id);
                        $('#carNumber').val(car.carNumber);
                        $('#model').val(car.model);
                        $('#carType').val(car.carType);
                        $('#isAvailable').val(car.isAvailable.toString());
                        
                        // Update UI to indicate editing mode
                        $('#formTitle').text('Edit Car');
                        $('#cancelBtn').show();
                        isEditing = true;
                        
                        // Scroll to the form
                        $('html, body').animate({
                            scrollTop: $("#carForm").offset().top - 100
                        }, 500);
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr.responseText);
                        showError('Error fetching car details: ' + (xhr.responseJSON?.message || error || 'Server error'));
                    }
                });
            }
            
            // Function to update an existing car
            function updateCar(id, carData) {
                $.ajax({
                    url: 'api/cars/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(carData),
                    dataType: 'text', // Change to 'text' instead of the default 'json'
                    success: function(response) {
                        showSuccess('Car updated successfully');
                        resetForm();
                        loadCars();
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr.responseText);
                        let errorMsg = 'Error updating car';
                        
                        // Simple error handling without trying to parse JSON
                        if (xhr.responseText && xhr.responseText.trim()) {
                            errorMsg += ': ' + xhr.responseText.trim();
                        } else if (error) {
                            errorMsg += ': ' + error;
                        }
                        
                        showError(errorMsg);
                    }
                });
            }
            
            // Function to delete a car
            function deleteCar(id) {
                $.ajax({
                    url: 'api/cars/' + id,
                    type: 'DELETE',
                    dataType: 'text', // Change to 'text' instead of the default 'json'
                    success: function(response) {
                        showSuccess('Car deleted successfully');
                        loadCars();
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr.responseText);
                        let errorMsg = 'Error deleting car';
                        
                        // Simple error handling without trying to parse JSON
                        if (xhr.responseText && xhr.responseText.trim()) {
                            errorMsg += ': ' + xhr.responseText.trim();
                        } else if (error) {
                            errorMsg += ': ' + error;
                        }
                        
                        showError(errorMsg);
                    }
                });
            }
            
            // Function to validate the form
            function validateForm() {
                let isValid = true;
                
                // Check required fields
                if (!$('#carNumber').val().trim()) {
                    showError('Car number is required');
                    isValid = false;
                }
                
                if (!$('#model').val().trim()) {
                    showError('Model is required');
                    isValid = false;
                }
                
                if (!$('#carType').val()) {
                    showError('Car type is required');
                    isValid = false;
                }
                
                return isValid;
            }
            
            // Function to reset the form
            function resetForm() {
                $('#carForm')[0].reset();
                $('#carId').val('');
                $('#formTitle').text('Add New Car');
                $('#cancelBtn').hide();
                isEditing = false;
            }
            
            // Function to show success message
            function showSuccess(message) {
                $('#successAlert').text(message).fadeIn();
                setTimeout(function() {
                    $('#successAlert').fadeOut();
                }, 3000);
            }
            
            // Function to show error message
            function showError(message) {
                $('#errorAlert').text(message).fadeIn();
                setTimeout(function() {
                    $('#errorAlert').fadeOut();
                }, 5000);
            }
        });
    </script>
</body>
</html>