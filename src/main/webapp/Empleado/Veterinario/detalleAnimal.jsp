<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos principales */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerDetAnim {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
        }

        h1.titleDetAnim {
            font-size: 32px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .cardDetAnim {
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .cardDetAnim .card-body {
            padding: 20px;
            text-align: left;
        }

        .cardDetAnim .card-title {
            font-size: 24px;
            color: #4A665E;
            margin-bottom: 10px;
        }

        .tableDetAnim {
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        .tableDetAnim th, .tableDetAnim td {
            padding: 10px;
            text-align: center;
            border: none;
        }

        .tableDetAnim th {
            background-color: #4A665E;
            color: #ffffff;
            font-weight: bold;
        }

        .tableDetAnim td {
            color: #333;
        }

        /* Botones personalizados */
        .botonDetAnim {
            font-size: 16px;
            padding: 10px 20px;
            margin-top: 10px;
            border-radius: 5px;
            text-decoration: none;
            color: #ffffff;
            background-color: #4A665E; /* Color verde corporativo */
            border: none;
            transition: background-color 0.3s;
        }

        .botonDetAnim:hover {
            background-color: #3B534D; /* Tono más oscuro de verde para el hover */
        }

        /* Imágenes */
        .img-fluid {
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>

    <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>

    <div class="containerDetAnim">
        <h1 class="titleDetAnim">Detalle del Animal</h1>

        <!-- Información del animal -->
        <div class="cardDetAnim">
            <div class="card-body">
                <h5 class="card-title">${animal.nombre}</h5>
                <p>
                    <strong>Especie:</strong> ${animal.especie}<br>
                    <strong>Raza:</strong> ${animal.raza}<br>
                    <strong>Edad:</strong> ${animal.edad} años<br>
                    <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                    <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                </p>
                <form action="${pageContext.request.contextPath}/CambiarEstadoSaludServlet" method="post">
                    <input type="hidden" name="idAnimal" value="${animal.idAnimal}">
                    <select name="nuevoEstadoSalud" class="form-select" required>
                        <option value="" disabled selected>Seleccionar nuevo estado</option>
                        <option value="Saludable">Saludable</option>
                        <option value="En Tratamiento">En Tratamiento</option>
                        <option value="En Recuperación">En Recuperación</option>
                    </select>
                    <button type="submit" class="botonDetAnim">Cambiar Estado de Salud</button>
                </form>
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
        <table class="table table-bordered tableDetAnim">
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
                        <td>${historial.estadoTratamiento}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <form action="${pageContext.request.contextPath}/AgregarHistorialMedicoServlet" method="get">
            <input type="hidden" name="idAnimal" value="${animal.idAnimal}">
            <button type="submit" class="botonDetAnim">Añadir Historial Médico</button>
        </form>

        <!-- Solicitudes de Adopción -->
        <h3>Solicitudes de Adopción</h3>
        <table class="table table-bordered tableDetAnim">
            <thead>
                <tr>
                    <th>Fecha de Solicitud</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="solicitud" items="${solicitudesAdopcionList}">
                    <tr>
                        <td>${solicitud.fechaSolicitud}</td>
                        <td>${solicitud.estado}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Vacunas aplicadas -->
        <h3>Vacunas Aplicadas</h3>
        <table class="table table-bordered tableDetAnim">
            <thead>
                <tr>
                    <th>Nombre de la Vacuna</th>
                    <th>Fecha de Aplicación</th>
                    <th>Mililitros (ml)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vacuna" items="${vacunasList}">
                    <tr>
                        <td>${vacuna.nombreVacuna}</td>
                        <td>${vacuna.fechaAplicacion}</td>
                        <td>${vacuna.ml}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <form action="${pageContext.request.contextPath}/AgregarVacunaServlet" method="get">
            <input type="hidden" name="idAnimal" value="${animal.idAnimal}">
            <input type="hidden" name="especie" value="${animal.especie}">
            <button type="submit" class="botonDetAnim">Añadir Vacuna Aplicada</button>
        </form>
    </div>
</body>
</html>
