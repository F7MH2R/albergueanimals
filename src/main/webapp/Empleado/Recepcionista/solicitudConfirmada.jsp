<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Solicitud Confirmada</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerConfirmacion {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .titleConfirmacion {
            font-size: 32px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .textConfirmacion {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btnRegresar {
            background-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            display: inline-block;
        }

        .btnRegresar:hover {
            background-color: #333;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerConfirmacion">
        <h1 class="titleConfirmacion">Solicitud de Adopción Registrada</h1>
        <p class="textConfirmacion">La solicitud de adopción ha sido registrada exitosamente. Nos pondremos en contacto con el adoptante para confirmar los siguientes pasos.</p>
        <a href="${pageContext.request.contextPath}/AnimalsServlet" class="btnRegresar">Lista de Animales</a>
    </div>
</body>
</html>
