<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle de la Solicitud de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
      <%-- Incluir la barra de navegación para el recepcionista --%>
        <jsp:include page="navbarRecepcionista.jsp" />
<div class="container">
    <h1>Detalle de la Solicitud de Adopción</h1>

    <!-- Información del Adoptante -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Información del Adoptante</h5>
            <p>
                <strong>Nombre:</strong> ${adoptante.nombre}<br>
                <strong>Correo:</strong> ${adoptante.correo}<br>
                <strong>Teléfono:</strong> ${adoptante.telefono}<br>
                <strong>Dirección:</strong> ${adoptante.direccion}
            </p>
        </div>
    </div>

    <!-- Información de la Solicitud -->
    <h3>Información de la Solicitud</h3>
    <p>
        <strong>Fecha de Solicitud:</strong> ${solicitud.fechaSolicitud}<br>
        <strong>Estado:</strong> ${solicitud.estado}
    </p>

    <!-- Formulario para Cambiar el Estado de la Solicitud -->
    <form action="${pageContext.request.contextPath}/ActualizarEstadoSolicitudServlet" method="post">
        <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}">
        <input type="hidden" name="idAnimal" value="${solicitud.idAnimal}">
        <input type="hidden" name="idAdoptante" value="${solicitud.idAdoptante}">
        <div class="form-group">
            <label for="estado">Cambiar Estado</label>
            <select class="form-control" id="estado" name="estado">
                <option value="Pendiente" ${solicitud.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                <option value="Aprobada" ${solicitud.estado == 'Aprobada' ? 'selected' : ''}>Aprobada</option>
                <option value="Rechazada" ${solicitud.estado == 'Rechazada' ? 'selected' : ''}>Rechazada</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Actualizar Estado</button>
    </form>
</div>
</body>
</html>
