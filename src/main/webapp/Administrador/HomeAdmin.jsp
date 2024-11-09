<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");

    if (usuario == null) {
        request.getRequestDispatcher("/General/login.jsp").forward(request, response);
        return;
    }

    String rol = usuario.getRol();
%>

<%-- Incluir el archivo de navegación adecuado --%>
<jsp:include page="<%= (rol.equals("Administrador") ? "../General/navAdmin.jsp" : 
                     (rol.equals("Empleado") ? "../General/navEmpleado.jsp" : 
                     "../General/navCliente.jsp")) %>" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Home - Administrador</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Estilos principales */
        #admin-home {
            margin: 50px;
            min-height: 600px;
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
        }

        #admin-home .welcome-message {
            padding: 40px;
            font-size: 40px;
            color: #333;
            display: flex;
            justify-content: center;
            width: 100%;
            text-align: center;
        }

        #admin-home .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px;
            flex-wrap: wrap;
        }

        #admin-home .card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 450px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        #admin-home .card:hover {
            transform: translateY(-5px);
        }

        #admin-home .card h3 {
            font-size: 30px;
            color: #4A665E;
            margin-bottom: 15px;
        }

        #admin-home .card p {
            color: #666;
            font-size: 20px;
            margin-bottom: 20px;
        }

        #admin-home .card a {
            font-size: 20px;
            display: inline-block;
            padding: 10px 20px;
            color: #ffffff;
            background-color: #4A665E;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        #admin-home .card a:hover {
            background-color: #333;
        }

        .card .icon {
            font-size: 70px;
            color: #FACECA;
            margin-bottom: 15px;
        }

        /* Media queries para dispositivos más pequeños */
        @media (max-width: 768px) {
            #admin-home {
                margin: 20px;
            }

            #admin-home .welcome-message {
                font-size: 30px;
                padding: 20px;
            }

            #admin-home .card-container {
                
                flex-direction: column;
                align-items: center;
            }

            #admin-home .card {
                width: 100%;
                max-width: 350px; 
            }

            #admin-home .card h3 {
                font-size: 24px;
            }

            #admin-home .card p,
            #admin-home .card a {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>

    <div id="admin-home">
        <div class="welcome-message">
            Bienvenido Administrador, <%= usuario.getNombreCompleto() %>
        </div>

        <div class="card-container">
            <div class="card">
                <i class="fas fa-users icon"></i>
                <h3>Gestión de Usuarios</h3>
                <p>Administra y controla los usuarios de la plataforma.</p>
                <a href="<%= request.getContextPath() %>/GestionUsuariosServlet">Ir a Gestión de Usuarios</a>
            </div>
            
            <div class="card">
                <i class="fas fa-chart-line icon"></i>
                <h3>Reportes</h3>
                <p>Consulta y genera reportes de actividades y estadísticas.</p>
                <a href="<%= request.getContextPath() %>/ReportesServlet">Ir a Reportes</a>
            </div>
        </div>
    </div>

</body>
</html>

