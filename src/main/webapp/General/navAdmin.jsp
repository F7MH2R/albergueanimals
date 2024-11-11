<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tu Página</title>
    <style>
       

        /* General font settings */
        body, nav, .welcome-message, .menu-left li a {
            font-family: Arial, sans-serif;
            font-size: 20px;
            color: #4A665E; /* Usar el mismo color que en otras páginas */
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #F0EEED;
        }

        /* Navbar styling */
        nav {
            background-color: #4A665E; /* Color verde de la navbar */
            padding: 10px;
            display: flex;
            align-items: center;
        }

        /* Logo styling */
        nav img {
            width: 80px; 
            height: 80px; 
            border-radius: 50%; 
            margin-right: 40px; 
            margin-left: 40px;
        }

        /* Welcome message styling */
        .welcome-message {
            list-style-type: none;
            margin: 0;
            padding: 0;
            color: #FACECA; /* Color claro que combina con el fondo */
            display: flex;
            align-items: center;
        }

        /* Menu styling */
        .menu-left {
            list-style-type: none;
            margin-right: 25px;
            padding: 0;
            display: flex;
            align-items: center;
            margin-left: auto;
        }

        .menu-left li {
            margin-right: 20px;
        }

        .menu-left li a {
            color: white; /* Mantener blanco para los links */
            text-decoration: none;
            padding: 8px 16px;
            transition: color 0.3s;
            border-radius: 4px;
        }

        .menu-left li a:hover {
            color: #cccccc;
        }

    </style>
</head>
<body>
    <nav>
        <!-- Imagen y mensaje de bienvenida alineados a la izquierda -->
        <img src="img/logo.jpg" alt="Logo">
        <ul class="welcome-message">
            <li>Bienvenido, <%= usuario.getNombreCompleto() %> (Administrador)</li>
        </ul>

        <!-- Menú de navegación alineado a la derecha -->
        <ul class="menu-left">
            <li><a href="<%= request.getContextPath() %>/HomeAdminServlet">Inicio</a></li>
            <li><a href="<%= request.getContextPath() %>/GestionUsuariosServlet">Gestión de Usuarios</a></li>
            <li><a href="<%= request.getContextPath() %>/ReportesServlet">Reportes</a></li>
            <li><a href="<%= request.getContextPath() %>/LogoutServlet">Cerrar Sesión</a></li>
        </ul>
    </nav>
</body>
</html>


