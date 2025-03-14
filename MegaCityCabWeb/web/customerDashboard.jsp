<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7));
            color: white;
            padding: 100px 0;
            margin-bottom: 30px;
        }
        .feature-card {
            transition: transform 0.3s;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .action-section {
            background-color: #f8f9fa;
            padding: 50px 0;
            margin: 30px 0;
        }
        .contact-info i {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #0d6efd;
        }
        .footer {
            background-color: #343a40;
            color: white;
            padding: 30px 0;
        }
        .icon-placeholder {
            font-size: 4rem;
            color: #0d6efd;
            margin-bottom: 1rem;
        }
        .map-placeholder {
            background-color: #e9ecef;
            height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.25rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-taxi me-2"></i>
                Mega City Cab
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>
                <a href="login.jsp" class="btn btn-outline-light">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1>Welcome to Mega City Cab Services</h1>
            <p class="lead">Your reliable partner for comfortable and safe rides across the city</p>
        </div>
    </section>

    <!-- Section 1: Main Actions -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-md-6">
                <div class="card feature-card shadow mb-4">
                    <div class="card-body text-center p-5">
                        <div class="icon-placeholder">
                            <i class="fas fa-taxi"></i>
                        </div>
                        <h3>Need a ride?</h3>
                        <p>Book a cab now and get to your destination safely and comfortably.</p>
                        <a href="createBooking.jsp" class="btn btn-primary btn-lg">
                            <i class="fas fa-taxi"></i> Book Now
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card feature-card shadow mb-4">
                    <div class="card-body text-center p-5">
                        <div class="icon-placeholder">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <h3>Track Your Rides</h3>
                        <p>View all your past, ongoing and upcoming bookings in one place.</p>
                        <a href="viewBooking.jsp" class="btn btn-success btn-lg">
                            <i class="fas fa-list"></i> View Bookings
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 2: About Us -->
    <section id="about" class="action-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 mb-4 mb-md-0">
                    <div class="text-center p-4 bg-white rounded shadow">
                        <i class="fas fa-car-side icon-placeholder"></i>
                        <h4>Our Fleet</h4>
                        <p>Modern, well-maintained vehicles for your comfort</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <h2>About Mega City Cab</h2>
                    <p>Founded in 2015, Mega City Cab has been providing reliable, safe, and comfortable transportation services to residents and visitors of Mega City.</p>
                    <p>Our fleet consists of modern, well-maintained vehicles operated by professional, background-checked drivers to ensure your safety and comfort.</p>
                    <p>We pride ourselves on punctuality, cleanliness, and customer satisfaction, making us the preferred choice for transportation in Mega City.</p>
                    <div class="mt-3">
                        <span class="badge bg-primary p-2 m-1">24/7 Service</span>
                        <span class="badge bg-primary p-2 m-1">Professional Drivers</span>
                        <span class="badge bg-primary p-2 m-1">Clean Vehicles</span>
                        <span class="badge bg-primary p-2 m-1">GPS Tracking</span>
                        <span class="badge bg-primary p-2 m-1">Competitive Rates</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3: Contact and Address Info -->
    <section id="contact" class="container mb-5">
        <h2 class="text-center mb-4">Contact Us</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <h3>Get In Touch</h3>
                        <ul class="list-unstyled contact-info">
                            <li class="mb-3">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>123 Colombo 07, <br>Downtown, Wijerama Mawatha</span>
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-phone"></i>
                                <span>033 0000000</span>
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-envelope"></i>
                                <span>info@megacitycab.com</span>
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-clock"></i>
                                <span>Available 24/7, 365 days</span>
                            </li>
                        </ul>
                        <div class="mt-4">
                            <h4>Follow Us</h4>
                            <div class="d-flex">
                                <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-facebook-f"></i></a>
                                <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="btn btn-outline-primary me-2"><i class="fab fa-instagram"></i></a>
                                <a href="#" class="btn btn-outline-primary"><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card shadow h-100">
                    <div class="card-body">
                        <h3>Our Location</h3>
                        <div class="map-placeholder">
                            <i class="fas fa-map-marked-alt fa-4x text-secondary"></i>
                        </div>
                        <p class="mb-1"><strong>Main Office:</strong> 123, Colombo 07</p>
                        <p class="mb-1"><strong>Landmarks:</strong> Near Central Station, opposite City Mall</p>
                        <p><strong>Operating Areas:</strong> All Cities around Colombo District</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Mega City Cab</h5>
                    <p>Your trusted transportation partner in Mega City since 2015.</p>
                </div>
                <div class="col-md-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="createBooking.jsp" class="text-white">Book a Cab</a></li>
                        <li><a href="viewBooking.jsp" class="text-white">My Bookings</a></li>
                        <li><a href="#about" class="text-white">About Us</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Support</h5>
                    <ul class="list-unstyled">
                        <li><a href="#contact" class="text-white">Contact Us</a></li>
                        <li><a href="#" class="text-white">FAQ</a></li>
                        <li><a href="#" class="text-white">Terms of Service</a></li>
                        <li><a href="#" class="text-white">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
            <hr class="bg-light">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 Mega City Cab. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>