<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Exitoso</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .containerExito {
            max-width: 600px;
            margin: auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .alert-heading {
            color: #4A665E;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .alert-success {
            background-color: #DFF5E0;
            border-color: #B8E6C1;
            color: #4A665E;
            padding: 30px;
            border-radius: 8px;
        }

        p {
            font-size: 18px;
            color: #666;
        }

        .btnExito {
            background-color: #4A665E;
            color: #ffffff;
            font-size: 18px;
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            transition: background-color 0.3s;
            text-decoration: none;
            margin-top: 20px;
        }

        .btnExito:hover {
            background-color: #333;
        }

        hr {
            border-top: 1px solid #B8E6C1;
        }
    </style>
</head>
<body>
    <div class="containerExito">
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading">¡Registro Exitoso!</h4>
            <p>El animal se ha registrado correctamente en el sistema.</p>
            <hr>
            <a href="${pageContext.request.contextPath}/InicioRecepcionistaServlet" class="btnExito">Volver al Inicio</a>
        </div>
    </div>
</body>
</html>
