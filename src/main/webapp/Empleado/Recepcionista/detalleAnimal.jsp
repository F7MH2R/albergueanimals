<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
<div class="container">
    <h1>Detalle del Animal</h1>

    <!-- Información del animal -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">${animal.nombre}</h5>
            <p>
                <strong>Especie:</strong> ${animal.especie}<br>
                <strong>Raza:</strong> ${animal.raza}<br>
                <strong>Edad:</strong> ${animal.edad} años<br>
                <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
            </p>
        </div>
    </div>

    <!-- Imágenes del animal -->
    <h3>Imágenes</h3>
    <div class="row">
        <c:forEach var="imagen" items="${imagenesList}">
            <div class="col-md-4 mb-4">
                <img src="data:image/${imagen.tipoImagen};base64,${imagen.imagen}" class="img-fluid" alt="${animal.nombre}">
            </div>
        </c:forEach>
    </div>

    <!-- Historial Médico -->
    <h3>Historial Médico</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Fecha</th>
                <th>Tratamiento</th>
                <th>Descripción</th>
                <th>Estado del Tratamiento</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="historial" items="${historialMedicoList}">
                <tr>
                    <td>${historial.fecha}</td>
                    <td>${historial.tratamiento}</td>
                    <td>${historial.descripcion}</td>
                    <td>${historial.estadoTratamiento}</td> <!-- Nuevo campo -->
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Solicitudes de Adopción -->
    <h3>Solicitudes de Adopción</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Fecha de Solicitud</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="solicitud" items="${solicitudesAdopcionList}">
                <tr>
                    <td>${solicitud.fechaSolicitud}</td>
                    <td>${solicitud.estado}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/VerSolicitudServlet" method="get">
                            <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}">
                            <button type="submit" class="btn btn-primary">Ver Solicitud</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Vacunas aplicadas -->
    <h3>Vacunas Aplicadas</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Nombre de la Vacuna</th>
                <th>Fecha de Aplicación</th>
                <th>Mililitros (ml)</th> <!-- Nuevo campo -->
            </tr>
        </thead>
        <tbody>
            <c:forEach var="vacuna" items="${vacunasList}">
                <tr>
                    <td>${vacuna.nombreVacuna}</td>
                    <td>${vacuna.fechaAplicacion}</td>
                    <td>${vacuna.ml}</td> <!-- Nuevo campo -->
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
