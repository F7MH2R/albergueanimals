<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesión</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="path/to/bootstrap.css"> <!-- Cambia el path a tu archivo CSS de Bootstrap -->
    <style>
        /* General background and font settings */
        body {
            background-color: #F0EEED;
            font-family: Arial, sans-serif;
            
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin-top: 150px;
            margin-left: 600px;
        }

        /* Container styling */
        .container {
            max-width: 600px; /* Ajuste del ancho del contenedor */
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Logo styling */
        .logo {
            max-width: 200px;
            margin-bottom: 20px;
            border-radius: 50%; 
        }

        /* Header styling */
        h2 {
            font-size: 35px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        /* Error message styling */
        .alert-danger {
            color: #fff;
            background-color: #FACECA;
            border-color: #FACECA;
        }

        /* Form control styling */
        .form-group label {
            font-size: 20px;
            color: #4A665E;
            display: block;
            margin-bottom: 10px;
            margin-top: 10px;
            text-align: left;
        }

        .form-control {
            font-size: 16px;
            color: #333;
            border: 1px solid #4A665E;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        /* Button styling */
        .btn-primary {
            margin-bottom: 20px;
            font-size: 18px;
            color: #fff;
            background-color: #4A665E;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #333;
        }

        /* Link styling */
        p a {
            color: #4A665E;
            font-size: 16px;
            text-decoration: none;
        }

        p a:hover {
            color: #333;
        }

        /* Additional margin for spacing */
        .mt-3 {
            margin-top: 20px !important;
        }

        .mt-4 {
            margin-top: 40px !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="img/logo.jpg" alt="Logo" class="logo"> <!-- Cambia el path a la ubicación real de tu logo -->
        <h2>Iniciar Sesión</h2>
        
        <%-- Mostrar mensaje de error si existe --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Nombre de Usuario:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Contraseña:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block mt-3">Ingresar</button>
        </form>
        <p class="text-center mt-3">
            <a href="/AgregarUsuarioCliServlet">¿No tienes una cuenta? Regístrate</a>
        </p>
    </div>
</body>
</html>
