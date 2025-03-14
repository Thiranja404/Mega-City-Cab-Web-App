<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.2s;
        }
        .dashboard-card:hover {
            transform: scale(1.03);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="bg-primary text-white p-3 rounded shadow">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2 class="mb-0">Mega City Cab - Manager Dashboard</h2>
                        <a href="login.jsp" class="btn btn-outline-light">Logout</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Dashboard Cards -->
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow dashboard-card">
                    <div class="card-body text-center p-4">
                        <div class="card-icon text-primary">📋</div>
                        <h4>Bookings</h4>
                        <p class="text-muted">View and manage all customer bookings</p>
                        <a href="manageBooking.jsp" class="btn btn-primary w-100">Manage Bookings</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow dashboard-card">
                    <div class="card-body text-center p-4">
                        <div class="card-icon text-success">🚕</div>
                        <h4>Cars</h4>
                        <p class="text-muted">Manage vehicle fleet and maintenance</p>
                        <a href="manageCars.jsp" class="btn btn-success w-100">Manage Cars</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow dashboard-card">
                    <div class="card-body text-center p-4">
                        <div class="card-icon text-warning">👤</div>
                        <h4>Drivers</h4>
                        <p class="text-muted">Manage driver profiles and assignments</p>
                        <a href="manageDrivers.jsp" class="btn btn-warning w-100">Manage Drivers</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="text-center text-muted py-3">
                    <small>© 2025 Mega City Cab Service. All rights reserved.</small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>