<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        .body-formulario-adopcion {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container-formulario-adopcion {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .title-formulario-adopcion {
            font-size: 28px;
            color: #4A665E;
            margin-bottom: 20px;
            text-align: center;
        }

        .section-title {
            font-size: 24px;
            color: #4A665E;
            margin-top: 20px;
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 16px;
            color: #4A665E;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: #666;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .readonly-input {
            background-color: #f8f9fa;
            cursor: not-allowed;
        }

        .btn-success-formulario-adopcion {
            background-color: #4A665E; /* Color verde oscuro que usaste en otros JSP */
            border-color: #4A665E;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: none;
        }

        .btn-success-formulario-adopcion:hover {
            background-color: #3B534D; /* Sutil cambio para el hover */
            border-color: #3B534D;
        }

        .animal-info {
            font-size: 16px;
            color: #666;
            margin-bottom: 10px;
        }

        .animal-info strong {
            color: #4A665E;
        }
    </style>
</head>
<body class="body-formulario-adopcion">
    
    <%-- Incluir la barra de navegación --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container-formulario-adopcion">
        <h2 class="title-formulario-adopcion">Formulario de Adopción</h2>
        
        <form action="${pageContext.request.contextPath}/RegistrarAdopcionCliServlet" method="post">
            <%-- ID del Animal (Oculto) --%>
            <input type="hidden" name="idAnimal" value="${animal.idAnimal}">

            <h3 class="section-title">Datos del Animal</h3>
            <p class="animal-info"><strong>Nombre:</strong> ${animal.nombre}</p>
            <p class="animal-info"><strong>Especie:</strong> ${animal.especie}</p>
            <p class="animal-info"><strong>Raza:</strong> ${animal.raza}</p>

            <h3 class="section-title">Datos del Adoptante</h3>
            <div class="form-group">
                <label>Nombre del Adoptante:</label>
                <input type="text" name="nombreAdoptante" value="${cliente.nombreCompleto}" readonly class="readonly-input">
            </div>

            <div class="form-group">
                <label>Correo Electrónico:</label>
                <input type="email" name="correo" value="${cliente.correo}" readonly class="readonly-input">
            </div>

            <div class="form-group">
                <label>Teléfono:</label>
                <input type="text" name="telefono" required>
            </div>

            <div class="form-group">
                <label>Dirección:</label>
                <input type="text" name="direccion" required>
            </div>

            <button type="submit" class="btn-success-formulario-adopcion">Enviar Solicitud de Adopción</button>
        </form>
    </div>

</body>
</html>
