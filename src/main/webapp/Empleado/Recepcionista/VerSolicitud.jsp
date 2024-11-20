<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle de la Solicitud de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerSolicitud {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .titleSolicitud {
            font-size: 32px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .cardAdoptante, .infoSolicitud {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .cardAdoptante h5, .infoSolicitud h3 {
            font-size: 24px;
            color: #4A665E;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .cardAdoptante p, .infoSolicitud p {
            color: #666;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .form-group label {
            font-weight: bold;
            color: #4A665E;
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            border-radius: 5px;
            border-color: #ccc;
            padding: 10px;
            font-size: 16px;
        }

        .btn-success {
            background-color: #4A665E;
            border-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-success:hover {
            background-color: #333;
            border-color: #333;
        }

        .btn-secondary {
            background-color: #ccc;
            border-color: #ccc;
            color: #333;
            font-size: 16px;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        .btn-secondary:hover {
            background-color: #999;
            border-color: #999;
        }
    </style>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerSolicitud">
        <h1 class="titleSolicitud">Detalle de la Solicitud de Adopción</h1>

        <!-- Información del Adoptante -->
        <div class="cardAdoptante">
            <h5>Información del Adoptante</h5>
            <p>
                <strong>Nombre:</strong> ${adoptante.nombre}<br>
                <strong>Correo:</strong> ${adoptante.correo}<br>
                <strong>Teléfono:</strong> ${adoptante.telefono}<br>
                <strong>Dirección:</strong> ${adoptante.direccion}
            </p>
        </div>

        <!-- Información de la Solicitud -->
        <div class="infoSolicitud">
            <h3>Información de la Solicitud</h3>
            <p>
                <strong>Fecha de Solicitud:</strong> ${solicitud.fechaSolicitud}<br>
                <strong>Estado:</strong> ${solicitud.estado}
            </p>
        </div>

        <!-- Formulario para Cambiar el Estado de la Solicitud -->
        <form action="${pageContext.request.contextPath}/ActualizarEstadoSolicitudServlet" method="post">
            <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}">
            <input type="hidden" name="idAnimal" value="${solicitud.idAnimal}">
            <input type="hidden" name="idAdoptante" value="${solicitud.idAdoptante}">
            <div class="form-group">
                <label for="estado">Cambiar Estado</label>
                <select class="form-control" id="estado" name="estado" required>
                    <option value="Pendiente" ${solicitud.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                    <option value="Aprobado" ${solicitud.estado == 'Aprobado' ? 'selected' : ''}>Aprobado</option>
                    <option value="Rechazado" ${solicitud.estado == 'Rechazado' ? 'selected' : ''}>Rechazado</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success mt-3">Actualizar Estado</button>
        </form>
    </div>
</body>
</html>
