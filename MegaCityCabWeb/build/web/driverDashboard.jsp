<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Driver Dashboard - Mega City Cab</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <style>
        .navbar-brand {
            font-weight: bold;
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.35em 0.65em;
        }
        .booking-card {
            transition: all 0.3s ease;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Mega City Cab - Driver Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <span class="nav-link">Welcome! Driver</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutBtn">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-success" id="successAlert" style="display: none;">
                    Operation completed successfully
                </div>
                <div class="alert alert-danger" id="errorAlert" style="display: none;">
                    Error occurred
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Your Assigned Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="row" id="bookingsContainer">
                            <!-- Bookings will be loaded here -->
                            <div class="col-12 text-center py-4" id="noBookingsMessage">
                                <p class="text-muted">No bookings assigned to you at the moment.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">Completed Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped" id="completedBookingsTable">
                                <thead>
                                    <tr>
                                        <th>Booking Number</th>
                                        <th>Customer</th>
                                        <th>Pickup Location</th>
                                        <th>Destination</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Completed bookings will be loaded here -->
                                </tbody>
                            </table>
                            <div class="text-center py-3" id="noCompletedBookingsMessage">
                                <p class="text-muted">No completed bookings yet.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for confirmation -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Confirm Action</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Get driver information from session
            const driverId = <%= session.getAttribute("userId") %>;
            const driverName = "<%= session.getAttribute("userName") %>";
            
            $('#driverName').text(driverName);
            
            let currentBookingId = null;
            let currentAction = null;
            const confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            
            // Load assigned bookings on page load
            loadAssignedBookings();
            loadCompletedBookings();
            
            // Load assigned bookings
            function loadAssignedBookings() {
                $.ajax({
                    url: 'api/bookings',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        const assignedBookings = data.filter(booking => 
                            booking.driverId === driverId && booking.status === 'assigned');
                        
                        if (assignedBookings.length > 0) {
                            $('#noBookingsMessage').hide();
                            
                            const bookingsContainer = $('#bookingsContainer');
                            bookingsContainer.empty();
                            
                            $.each(assignedBookings, function(i, booking) {
                                const bookingCard = $(`
                                    <div class="col-md-6 col-lg-4 mb-4">
                                        <div class="card booking-card h-100">
                                            <div class="card-header d-flex justify-content-between align-items-center">
                                                <span class="fw-bold">${booking.bookingNumber}</span>
                                                <span class="badge bg-info text-dark status-badge">${booking.status}</span>
                                            </div>
                                            <div class="card-body">
                                                <h5 class="card-title">${booking.customerName}</h5>
                                                <p class="card-text">
                                                    <i class="bi bi-telephone"></i> ${booking.customerTelephone}<br>
                                                    <strong>From:</strong> ${booking.currentLocation}<br>
                                                    <strong>To:</strong> ${booking.destination}<br>
                                                    <strong>Amount:</strong> LKR ${booking.amount.toFixed(2)}
                                                </p>
                                            </div>
                                            <div class="card-footer">
                                                <div class="d-flex justify-content-between">
                                                    <button class="btn btn-success complete-btn" data-booking-id="${booking.id}">
                                                        <i class="bi bi-check-circle"></i> Complete
                                                    </button>
                                                    <button class="btn btn-danger cancel-btn" data-booking-id="${booking.id}">
                                                        <i class="bi bi-x-circle"></i> Cancel
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                `);
                                
                                bookingsContainer.append(bookingCard);
                            });
                        } else {
                            $('#noBookingsMessage').show();
                        }
                    },
                    error: function(xhr, status, error) {
                        showError('Error loading bookings: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Load completed bookings
            function loadCompletedBookings() {
                $.ajax({
                    url: 'api/bookings',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data) {
                        const completedBookings = data.filter(booking => 
                            booking.driverId === driverId && 
                            (booking.status === 'completed' || booking.status === 'cancelled'));
                        
                        const completedTable = $('#completedBookingsTable tbody');
                        completedTable.empty();
                        
                        if (completedBookings.length > 0) {
                            $('#noCompletedBookingsMessage').hide();
                            
                            $.each(completedBookings, function(i, booking) {
                                let statusBadgeClass = 'badge bg-success';
                                
                                if (booking.status === 'cancelled') {
                                    statusBadgeClass = 'badge bg-danger';
                                }
                                
                                const row = $(`
                                    <tr>
                                        <td>${booking.bookingNumber}</td>
                                        <td>${booking.customerName}</td>
                                        <td>${booking.currentLocation}</td>
                                        <td>${booking.destination}</td>
                                        <td>LKR ${booking.amount.toFixed(2)}</td>
                                        <td><span class="${statusBadgeClass}">${booking.status}</span></td>
                                    </tr>
                                `);
                                
                                completedTable.append(row);
                            });
                        } else {
                            $('#noCompletedBookingsMessage').show();
                        }
                    },
                    error: function(xhr, status, error) {
                        showError('Error loading completed bookings: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
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
            
            // Confirm action button in modal
            $('#confirmActionBtn').click(function() {
                if (currentAction) {
                    currentAction();
                    confirmationModal.hide();
                }
            });
            
            // Handle booking status update
            function updateBookingStatus(bookingId, status) {
                $.ajax({
                    url: 'api/bookings/' + bookingId + '/status/' + status,
                    type: 'PUT',
                    success: function(response) {
                        showSuccess('Booking status updated successfully');
                        // Refresh both tables
                        loadAssignedBookings();
                        loadCompletedBookings();
                    },
                    error: function(xhr, status, error) {
                        showError('Error updating booking status: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    }
                });
            }
            
            // Handle logout
            $('#logoutBtn').click(function(e) {
                e.preventDefault();
                $.ajax({
                    url: 'api/auth/logout',
                    type: 'POST',
                    success: function() {
                        window.location.href = 'login.jsp';
                    },
                    error: function() {
                        // Redirect anyway on error
                        window.location.href = 'login.jsp';
                    }
                });
            });
            
            // Show success message
            function showSuccess(message) {
                $('#successAlert').text(message).show();
                setTimeout(function() {
                    $('#successAlert').fadeOut();
                }, 3000);
            }
            
            // Show error message
            function showError(message) {
                $('#errorAlert').text(message).show();
                setTimeout(function() {
                    $('#errorAlert').fadeOut();
                }, 3000);
            }
            
            // Set up auto-refresh every 30 seconds
            setInterval(function() {
                loadAssignedBookings();
                loadCompletedBookings();
            }, 30000);
        });
    </script>
</body>
</html>