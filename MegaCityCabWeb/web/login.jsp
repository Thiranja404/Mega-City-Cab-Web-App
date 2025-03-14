<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
        }
        .login-card {
            border-radius: 10px;
            border: none;
        }
        .card-header {
            border-radius: 10px 10px 0 0 !important;
            background-color: #4b6cb7 !important;
        }
        .btn-login {
            background: linear-gradient(to right, #4b6cb7, #182848);
            border: none;
            font-weight: bold;
        }
        .btn-login:hover {
            background: linear-gradient(to right, #3b5ca8, #0d1a38);
        }
        .form-control:focus {
            border-color: #4b6cb7;
            box-shadow: 0 0 0 0.25rem rgba(75, 108, 183, 0.25);
        }
        .register-link {
            color: #4b6cb7;
            font-weight: 500;
        }
        .register-link:hover {
            color: #182848;
        }
        .cab-icon {
            font-size: 2rem;
            margin-right: 10px;
        }
    </style>
</head>
<body class="d-flex align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow login-card">
                    <div class="card-header py-3 text-white text-center">
                        <h3 class="mb-0"><span class="cab-icon">🚕</span> Mega City Cab</h3>
                    </div>
                    <div class="card-body p-4">
                        <h5 class="text-center mb-4 text-muted">Sign in to your account</h5>
                        <form id="loginForm">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 py-2 btn-login">Login</button>
                        </form>
                        <div class="mt-4 text-center">
                            <a href="register.jsp" class="register-link text-decoration-none">Don't have an account? Register here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.getElementById('loginForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            fetch('http://localhost:8080/MegaCityCabWeb/api/auth/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Redirect based on user type
                    switch(data.userType) {
                        case 'customer':
                            window.location.href = 'customerDashboard.jsp';
                            break;
                        case 'driver':
                            window.location.href = 'driverDashboard.jsp';
                            break;
                        case 'manager':
                            window.location.href = 'managerDashboard.jsp';
                            break;
                        default:
                            window.location.href = 'customerDashboard.jsp'; // Default fallback
                            break;
                    }
                } else {
                    alert('Login failed: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Login failed: Server error');
            });
        });
    </script>
</body>
</html>