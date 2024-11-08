<%-- 
    Document   : footer
    Created on : Nov 2, 2024, 12:25:59 PM
    Author     : BLACK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>Footer</title>
    </head>
    <body>
        <footer class="bg-dark text-white text-center py-4 mt-auto">
            <div class="container">
                <!-- Footer Row -->
                <div class="row">
                    <!-- About Us Section -->
                    <div class="col-md-4">
                        <h5>About Us</h5>
                        <p>Providing the best services with a focus on customer satisfaction.</p>
                    </div>
                    <!-- Quick Links Section -->
                    <div class="col-md-4">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="home.jsp" class="text-white text-decoration-none">Home</a></li>
                            <li><a href="services.jsp" class="text-white text-decoration-none">Services</a></li>
                            <li><a href="contact.jsp" class="text-white text-decoration-none">Contact</a></li>
                            <li><a href="about.jsp" class="text-white text-decoration-none">About</a></li>
                        </ul>
                    </div>
                    <!-- Contact Section -->
                    <div class="col-md-4">
                        <h5>Contact</h5>
                        <p><i class="fas fa-envelope"></i> support@example.com</p>
                        <p><i class="fas fa-phone"></i> +1 234 567 890</p>
                        <p><i class="fas fa-map-marker-alt"></i> 123 Main Street, City, Country</p>
                    </div>
                </div>
                <!-- Footer Bottom -->
                <div class="row mt-3">
                    <div class="col">
                        <p>&copy; 2024 Your Company. All rights reserved.</p>
                        <p>
                            Follow us:
                            <a href="https://facebook.com" class="text-white text-decoration-none"><i class="fab fa-facebook"></i> Facebook</a>,
                            <a href="https://twitter.com" class="text-white text-decoration-none"><i class="fab fa-twitter"></i> Twitter</a>,
                            <a href="https://instagram.com" class="text-white text-decoration-none"><i class="fab fa-instagram"></i> Instagram</a>.
                        </p>
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
