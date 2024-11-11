<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Confirmación de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        .body-confirmacion-adopcion {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container-confirmacion {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .title-confirmacion {
            font-size: 32px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .text-confirmacion {
            font-size: 18px;
            color: #666666;
            margin-bottom: 30px;
        }

        .btn-volver {
            background-color: #4A665E;
            border: none;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn-volver:hover {
            background-color: #3B534D;
        }
    </style>
</head>
<body class="body-confirmacion-adopcion">
    <%-- Incluir la barra de navegación --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container-confirmacion">
        <h2 class="title-confirmacion">Solicitud de Adopción Enviada</h2>
        <p class="text-confirmacion">Tu solicitud de adopción ha sido enviada con éxito. Nos pondremos en contacto contigo pronto.</p>
        <a href="${pageContext.request.contextPath}/HomeClienteServlet" class="btn-volver">Volver al Inicio</a>
    </div>
</body>
</html>
