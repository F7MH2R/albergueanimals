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

        .containerConfirmation {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .titleConfirmation {
            font-size: 28px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .textConfirmation {
            color: #666;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .btn-return {
            background-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            display: inline-block;
        }

        .btn-return:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <div class="containerConfirmation">
        <h1 class="titleConfirmation">Solicitud de Adopción Registrada</h1>
        <p class="textConfirmation">La solicitud de adopción ha sido registrada exitosamente. Nos pondremos en contacto con el adoptante para confirmar los siguientes pasos.</p>
        <a class="btn-return" href="${pageContext.request.contextPath}/AnimalsServlet">Volver a la Lista de Animales</a>
    </div>
</body>
</html>
