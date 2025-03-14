<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Booking - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function calculateAmount() {
            const currentLocation = document.getElementById('currentLocation').value;
            const destination = document.getElementById('destination').value;

            if (currentLocation && destination) {
                // Simulate amount calculation (replace with actual logic)
                const amount = 500; // Fixed amount for demo purposes
                document.getElementById('amount').innerText = "Estimated Amount: LKR " + amount;
            } else {
                document.getElementById('amount').innerText = "";
            }
        }

        function submitBooking() {
            const customerName = document.getElementById('customerName').value;
            const customerTelephone = document.getElementById('customerTelephone').value;
            const currentLocation = document.getElementById('currentLocation').value;
            const destination = document.getElementById('destination').value;

            if (!customerName || !customerTelephone || !currentLocation || !destination) {
                alert("Please fill out all fields.");
                return;
            }

            // Fetch customerId from session (logged-in user's ID)
            const customerId = <%= session.getAttribute("userId") %>;

            const booking = {
                customerId: customerId,
                customerName: customerName,
                customerTelephone: customerTelephone,
                currentLocation: currentLocation,
                destination: destination,
                status: "pending" // Default status
            };

            fetch('http://localhost:8080/MegaCityCabWeb/api/bookings', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(booking)
            })
            .then(response => response.text())
            .then(data => {
                alert(data);
                if (data.includes("successfully")) {
                    window.location.href = 'customerDashboard.jsp'; // Redirect to dashboard after successful booking
                }
            })
            .catch(error => console.error('Error:', error));
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Create Booking</h3>
                    </div>
                    <div class="card-body">
                        <form id="createBookingForm" onsubmit="event.preventDefault(); submitBooking();">
                            <div class="mb-3">
                                <label for="customerName" class="form-label">Customer Name</label>
                                <input type="text" class="form-control" id="customerName" required>
                            </div>
                            <div class="mb-3">
                                <label for="customerTelephone" class="form-label">Telephone</label>
                                <input type="text" class="form-control" id="customerTelephone" required>
                            </div>
                            <div class="mb-3">
                                <label for="currentLocation" class="form-label">Pickup Location</label>
                                <input type="text" class="form-control" id="currentLocation" required oninput="calculateAmount()">
                            </div>
                            <div class="mb-3">
                                <label for="destination" class="form-label">Destination</label>
                                <input type="text" class="form-control" id="destination" required oninput="calculateAmount()">
                            </div>
                            <div class="mb-3">
                                <p id="amount" class="text-success"></p>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Create Booking</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>