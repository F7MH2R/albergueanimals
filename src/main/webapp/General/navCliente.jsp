<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Navbar Cliente</title>
    <style>
        /* Estilos generales para la barra de navegación del cliente */
        .bodynavcliente {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #F0EEED;
        }

        .navcliente {
            background-color: #4A665E; /* Color verde oscuro */
            height: 100px; /* Aumenta la altura */
            padding: 20px 40px; /* Aumenta el espacio interior */
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra para resaltar */
        }

        .navcliente img {
            width: 70px; /* Aumenta el tamaño del logo */
            height: 70px;
            border-radius: 50%;
            margin-right: 20px;
        }

        .welcome-message-cliente {
            font-size: 22px; /* Aumenta el tamaño del texto */
            color: #FACECA; /* Color claro para el texto */
            display: flex;
            align-items: center;
        }

        .menu-cliente {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .menu-cliente li {
            margin-right: 30px; /* Aumenta el espacio entre los enlaces */
        }

        .menu-cliente li a {
            color: #FFFFFF; /* Mantiene el color blanco */
            text-decoration: none;
            padding: 12px 20px; /* Aumenta el padding para un botón más grande */
            font-size: 18px; /* Aumenta el tamaño del texto */
            font-weight: bold;
            border-radius: 8px; /* Bordes más redondeados */
            background-color: transparent; /* Sin fondo */
            transition: background-color 0.3s ease; /* Animación de hover */
        }

        .menu-cliente li a:hover {
            background-color: #3B554D; /* Color al pasar el cursor */
        }
    </style>
</head>
<body class="bodynavcliente">
    <nav class="navcliente">
        <!-- Logo y mensaje de bienvenida -->
        <div class="welcome-message-cliente">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo">
            Bienvenido, <%= usuario.getNombreCompleto() %> (Cliente)
        </div>

        <!-- Menú de navegación -->
        <ul class="menu-cliente">
            <li><a href="<%= request.getContextPath() %>/HomeClienteServlet">Inicio</a></li> <!-- Enlace al inicio -->
            <li><a href="<%= request.getContextPath() %>/MisAdopcionesServlet">Mis Adopciones</a></li>
            <li><a href="<%= request.getContextPath() %>/LogoutServlet">Cerrar Sesión</a></li>
        </ul>
    </nav>
</body>
</html>
