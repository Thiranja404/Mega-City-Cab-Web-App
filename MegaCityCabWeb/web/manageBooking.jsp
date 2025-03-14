<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Bookings | Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        .admin-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-header {
            border-radius: 10px 10px 0 0 !important;
            background-color: #4b6cb7 !important;
            color: white;
            padding: 1rem 1.5rem;
        }
        .cab-icon {
            font-size: 1.5rem;
            margin-right: 10px;
        }
        .btn-primary {
            background: linear-gradient(to right, #4b6cb7, #182848);
            border: none;
            font-weight: bold;
        }
        .btn-primary:hover {
            background: linear-gradient(to right, #3b5ca8, #0d1a38);
        }
        .btn-success {
            background: linear-gradient(to right, #36d1dc, #5b86e5);
            border: none;
        }
        .btn-success:hover {
            background: linear-gradient(to right, #2bb8c4, #4a6ed4);
        }
        .btn-danger {
            background: linear-gradient(to right, #ff512f, #dd2476);
            border: none;
        }
        .btn-danger:hover {
            background: linear-gradient(to right, #e0472b, #c32069);
        }
        .form-control:focus, .form-select:focus {
            border-color: #4b6cb7;
            box-shadow: 0 0 0 0.25rem rgba(75, 108, 183, 0.25);
        }
        .table {
            background-color: white;
            border-radius: 0 0 10px 10px;
        }
        .badge {
            font-weight: 500;
            padding: 0.5em 0.8em;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card admin-card mb-4">
            <div class="card-header">
                <h3 class="mb-0"><span class="cab-icon">🚕</span> Mega City Cab - Admin Dashboard</h3>
            </div>
            <div class="card-body p-4">
                <h4 class="mb-4 text-muted">Manage Bookings</h4>
                
                <div class="alert alert-success" id="successAlert" style="display: none;">
                    Operation completed successfully
                </div>
                
                <div class="table-responsive">
                    <table class="table table-striped" id="bookingsTable">
                        <thead>
                            <tr>
                                <th>Booking #</th>
                                <th>Customer</th>
                                <th>Phone</th>
                                <th>Pickup</th>
                                <th>Destination</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Assign Driver</th>
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
    </div>

    <!-- Modal for confirmation -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #4b6cb7; color: white;">
                    <h5 class="modal-title" id="confirmationModalLabel">Confirm Action</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: brightness(0) invert(1);"></button>
                </div>
                <div class="modal-body" id="modalMessage">
                    Are you sure you want to proceed?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmActionBtn">Confirm</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            let drivers = [];
            let currentBookingId = null;
            let currentAction = null;
            const confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            
            // Load all bookings
            loadBookings();
            
            // Load all available drivers for dropdown
            loadDrivers();
            
            // Set up auto-refresh (every 30 seconds)
            setInterval(loadBookings, 30000);
            
            function loadBookings() {
                $.ajax({
                    url: 'api/bookings',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        let tableBody = $('#bookingsTable tbody');
                        tableBody.empty();
                        
                        $.each(data, function(i, booking) {
                            let row = $('<tr>');
                            row.append($('<td>').text(booking.bookingNumber));
                            row.append($('<td>').text(booking.customerName));
                            row.append($('<td>').text(booking.customerTelephone));
                            row.append($('<td>').text(booking.currentLocation));
                            row.append($('<td>').text(booking.destination));
                            row.append($('<td>').text('LKR ' + booking.amount.toFixed(2)));
                            
                            // Status cell with appropriate styling
                            let statusCell = $('<td>');
                            let statusBadgeClass = 'badge bg-secondary';
                            
                            if (booking.status === 'pending') {
                                statusBadgeClass = 'badge bg-warning text-dark';
                            } else if (booking.status === 'assigned') {
                                statusBadgeClass = 'badge bg-info text-dark';
                            } else if (booking.status === 'completed') {
                                statusBadgeClass = 'badge bg-success';
                            } else if (booking.status === 'cancelled') {
                                statusBadgeClass = 'badge bg-danger';
                            }
                            
                            statusCell.html($('<span>').addClass(statusBadgeClass).text(booking.status));
                            row.append(statusCell);
                            
                            // Driver assignment dropdown
                            let driverCell = $('<td>');
                            if (booking.status === 'pending' || booking.status === 'assigned') {
                                let driverSelect = $('<select>').addClass('form-select form-select-sm driver-select')
                                    .attr('data-booking-id', booking.id);
                                
                                driverSelect.append($('<option>').val('').text('-- Select Driver --'));
                                
                                // Add driver options if drivers are available
                                if (drivers.length > 0) {
                                    $.each(drivers, function(i, driver) {
                                        let option = $('<option>')
                                            .val(driver.id)
                                            .text(driver.name + ' (' + driver.licenseNumber + ')');
                                            
                                        // Select current driver if assigned
                                        if (booking.driverId && booking.driverId == driver.id) {
                                            option.prop('selected', true);
                                        }
                                        
                                        driverSelect.append(option);
                                    });
                                }
                                
                                driverCell.append(driverSelect);
                            } else if (booking.driverName) {
                                driverCell.text(booking.driverName);
                            } else {
                                driverCell.text('-');
                            }
                            row.append(driverCell);
                            
                            // Action buttons
                            let actionCell = $('<td>');
                            
                            if (booking.status === 'pending') {
                                // Pending bookings can be approved or cancelled
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-success me-1 approve-btn')
                                        .attr('data-booking-id', booking.id)
                                        .text('Approve')
                                );
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-danger cancel-btn')
                                        .attr('data-booking-id', booking.id)
                                        .text('Cancel')
                                );
                            } else if (booking.status === 'assigned') {
                                // Assigned bookings can be marked as completed or cancelled
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-success me-1 complete-btn')
                                        .attr('data-booking-id', booking.id)
                                        .text('Complete')
                                );
                                actionCell.append(
                                    $('<button>').addClass('btn btn-sm btn-danger cancel-btn')
                                        .attr('data-booking-id', booking.id)
                                        .text('Cancel')
                                );
                            } else {
                                actionCell.text('-');
                            }
                            
                            row.append(actionCell);
                            tableBody.append(row);
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('Error loading bookings:', error);
                        // Don't show the error to the user
                    }
                });
            }
            
            function loadDrivers() {
                $.ajax({
                    url: 'api/drivers',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        drivers = data;
                        loadBookings(); // Reload bookings to populate driver dropdowns
                    },
                    error: function(xhr, status, error) {
                        console.error('Error loading drivers:', error);
                        // Don't show the error to the user
                    }
                });
            }
            
            // Event handler for driver selection change
            $(document).on('change', '.driver-select', function() {
                let driverId = $(this).val();
                let bookingId = $(this).data('booking-id');
                
                if (driverId) {
                    // Show confirmation modal
                    currentBookingId = bookingId;
                    currentAction = function() {
                        assignDriver(bookingId, driverId);
                    };
                    $('#modalMessage').text('Are you sure you want to assign this driver to the booking?');
                    confirmationModal.show();
                }
            });
            
            // Event handler for approve button
            $(document).on('click', '.approve-btn', function() {
                let bookingId = $(this).data('booking-id');
                currentBookingId = bookingId;
                currentAction = function() {
                    updateBookingStatus(bookingId, 'approved');
                };
                $('#modalMessage').text('Are you sure you want to approve this booking?');
                confirmationModal.show();
            });
            
            // Event handler for cancel button
            $(document).on('click', '.cancel-btn', function() {
                let bookingId = $(this).data('booking-id');
                currentBookingId = bookingId;
                currentAction = function() {
                    updateBookingStatus(bookingId, 'cancelled');
                };
                $('#modalMessage').text('Are you sure you want to cancel this booking?');
                confirmationModal.show();
            });
            
            // Event handler for complete button
            $(document).on('click', '.complete-btn', function() {
                let bookingId = $(this).data('booking-id');
                currentBookingId = bookingId;
                currentAction = function() {
                    updateBookingStatus(bookingId, 'completed');
                };
                $('#modalMessage').text('Are you sure you want to mark this booking as completed?');
                confirmationModal.show();
            });
            
            // Confirm action button in modal
            $('#confirmActionBtn').click(function() {
                if (currentAction) {
                    try {
                        currentAction();
                    } catch (err) {
                        console.error('Error executing action:', err);
                    }
                    confirmationModal.hide();
                }
            });
            
            function assignDriver(bookingId, driverId) {
                $.ajax({
                    url: 'api/bookings/' + bookingId + '/assign/' + driverId,
                    type: 'PUT',
                    success: function(response) {
                        showSuccess('Driver assigned successfully');
                        loadBookings(); // Refresh the table
                    },
                    error: function(xhr, status, error) {
                        console.error('Error assigning driver:', error);
                        // Don't show error to user, just refresh to show current state
                        loadBookings();
                    }
                });
            }
            
            function updateBookingStatus(bookingId, status) {
                $.ajax({
                    url: 'api/bookings/' + bookingId + '/status/' + status,
                    type: 'PUT',
                    success: function(response) {
                        showSuccess('Booking status updated successfully');
                        loadBookings(); // Refresh the table
                    },
                    error: function(xhr, status, error) {
                        console.error('Error updating booking status:', error);
                        // Don't show error to user, just refresh to show current state
                        loadBookings();
                    }
                });
            }
            
            function showSuccess(message) {
                $('#successAlert').text(message).show();
                setTimeout(function() {
                    $('#successAlert').fadeOut();
                }, 3000);
            }
        });
    </script>
</body>
</html>