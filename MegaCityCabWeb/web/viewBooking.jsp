<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>My Bookings</h2>
        <table class="table table-striped" id="bookingsTable">
            <thead>
                <tr>
                    <th>Booking Number</th>
                    <th>Customer Name</th>
                    <th>Pickup Location</th>
                    <th>Destination</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <!-- Data will be loaded here -->
            </tbody>
        </table>
    </div>

    <script>
        $(document).ready(function() {
            // Get the user ID from session
            const userId = <%= session.getAttribute("userId") %>;
            
            // Load bookings for this user - FIXED ENDPOINT
            $.ajax({
                url: 'api/bookings/customer/' + userId,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    let tableBody = $('#bookingsTable tbody');
                    tableBody.empty();
                    
                    $.each(data, function(i, booking) {
                        let row = $('<tr>');
                        row.append($('<td>').text(booking.bookingNumber));
                        row.append($('<td>').text(booking.customerName));
                        row.append($('<td>').text(booking.pickupLocation));
                        row.append($('<td>').text(booking.destination));
                        row.append($('<td>').text('LKR' + booking.amount.toFixed(2)));
                        row.append($('<td>').text(booking.status));
                        tableBody.append(row);
                    });
                },
                error: function(xhr, status, error) {
                    alert('Error loading bookings: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                }
            });
        });
    </script>
</body>
</html>