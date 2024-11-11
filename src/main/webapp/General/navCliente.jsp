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
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navcliente img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 20px;
        }

        .welcome-message-cliente {
            font-size: 18px;
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
            margin-right: 20px;
        }

        .menu-cliente li a {
            color: #FFFFFF; /* Mantiene el color blanco */
            text-decoration: none;
            padding: 8px 16px;
            font-weight: bold;
            border-radius: 5px;
            transition: none; /* Elimina cualquier transición */
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
