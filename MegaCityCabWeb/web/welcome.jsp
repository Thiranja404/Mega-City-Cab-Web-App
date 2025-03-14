<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header Styles */
        .header {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }

        .logo {
            font-weight: 700;
            font-size: 1.5rem;
            color: #0d6efd;
        }

        /* Hero Section Styles */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), url('/api/placeholder/1200/800') center/cover no-repeat;
            color: #fff;
            padding: 80px 0;
            text-align: center;
            flex-grow: 1;
        }

        .hero-content {
            max-width: 600px;
            margin: 0 auto;
        }

        .hero-title {
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        /* Feature Icons */
        .feature-icons {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 50px;
            margin-bottom: 40px;
        }

        .feature-icon {
            text-align: center;
            width: 90px;
        }

        .icon-circle {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

        .icon-circle:hover {
            background-color: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
        }

        .icon-circle i {
            font-size: 28px;
            color: #fff;
        }

        .feature-icon p {
            font-size: 0.9rem;
            margin: 0;
        }

        /* Auth Buttons */
        .auth-buttons {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 30px;
        }

        .auth-button {
            display: inline-block;
            text-align: center;
            text-decoration: none;
            color: #fff;
            transition: all 0.3s ease;
        }

        .auth-button:hover {
            transform: translateY(-5px);
            color: #fff;
        }

        .auth-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-size: 24px;
        }

        .login-icon {
            background-color: #0d6efd;
        }

        .register-icon {
            background-color: #6c757d;
        }

        .auth-button:hover .auth-icon {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        /* Feature Pills */
        .feature-pills {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 40px;
        }

        .feature-pill {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50px;
            padding: 8px 16px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            backdrop-filter: blur(5px);
        }

        .feature-pill i {
            margin-right: 5px;
        }

        /* Footer Styles */
        .footer {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            font-size: 0.9rem;
        }

        /* Responsive Adjustments */
        @media (max-width: 576px) {
            .hero-title {
                font-size: 2rem;
            }
            .hero-subtitle {
                font-size: 1rem;
            }
            .feature-icons {
                gap: 15px;
            }
            .icon-circle {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="logo">
                <i class="fas fa-taxi"></i> Mega City Cab
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">Your Daily Travel Partner</h1>
                <p class="hero-subtitle">Fast, reliable, and affordable transportation at your fingertips</p>
                
                <!-- Feature Icons -->
                <div class="feature-icons">
                    <div class="feature-icon">
                        <div class="icon-circle">
                            <i class="fas fa-car"></i>
                        </div>
                        <p>Fast Rides</p>
                    </div>
                    <div class="feature-icon">
                        <div class="icon-circle">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <p>Best Rates</p>
                    </div>
                    <div class="feature-icon">
                        <div class="icon-circle">
                            <i class="fas fa-clock"></i>
                        </div>
                        <p>24/7 Service</p>
                    </div>
                </div>
                
                <!-- Auth Buttons -->
                <div class="auth-buttons">
                    <a href="login.jsp" class="auth-button">
                        <div class="auth-icon login-icon">
                            <i class="fas fa-sign-in-alt"></i>
                        </div>
                        <span>Login</span>
                    </a>
                    <a href="register.jsp" class="auth-button">
                        <div class="auth-icon register-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <span>Register</span>
                    </a>
                </div>
                
                <!-- Feature Pills -->
                <div class="feature-pills">
                    <div class="feature-pill">
                        <i class="fas fa-star"></i> Top Rated Service
                    </div>
                    <div class="feature-pill">
                        <i class="fas fa-shield-alt"></i> Safe & Secure
                    </div>
                    <div class="feature-pill">
                        <i class="fas fa-map-marker-alt"></i> City-wide Coverage
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>