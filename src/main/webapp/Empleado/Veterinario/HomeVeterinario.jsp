<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Home Veterinario</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Estilos principales */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        #veterinario-home {
            margin: 50px;
            min-height: 600px;
            background-color: #F0EEED;
            text-align: center;
        }

  

        .card-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            font-size: 26px;
            color: #4A665E;
            margin-bottom: 15px;
        }

        .card p {
            color: #666;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .card a {
            font-size: 18px;
            display: inline-block;
            padding: 10px 20px;
            color: #ffffff;
            background-color: #4A665E;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .card a:hover {
            background-color: #333;
        }

        .icon {
            font-size: 60px;
            color: #FACECA;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>

    <div id="veterinario-home">
     

        <div class="card-container">
            <div class="card">
                <i class="fas fa-paw icon"></i>
                <h3>Lista de Animales</h3>
                <p>Accede a la lista de animales para ver y gestionar sus detalles médicos.</p>
                <a href="<%= request.getContextPath() %>/VeterinarioAnimalsServlet">Ir a Lista de Animales</a>
            </div>
        </div>
    </div>

</body>
</html>
