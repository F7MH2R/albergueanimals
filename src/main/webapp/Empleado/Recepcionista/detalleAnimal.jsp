<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerAnimalDetail {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h1.titleAnimalDetail, h3.sectionTitle {
            font-size: 28px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 20px;
        }

        .cardAnimalInfo {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            padding: 20px;
            font-size: 16px;
            color: #333;
            text-align: left;
        }

        .tableAnimalDetail {
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
        }

        .tableAnimalDetail th, .tableAnimalDetail td {
            text-align: center;
            padding: 12px;
        }

        .tableAnimalDetail th {
            background-color: #4A665E;
            color: #ffffff;
            font-weight: bold;
        }

        .tableAnimalDetail td {
            color: #333;
        }

        /* Botones personalizados */
        .btn-animal {
            background-color: #4A665E;
            border-color: #4A665E;
            color: #ffffff;
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin: 5px;
        }

        .btn-animal:hover {
            background-color: #333;
            border-color: #333;
        }

        /* Estilos para las imágenes */
        .img-fluid {
            max-height: 200px;
            object-fit: cover;
            border-radius: 8px;
            width: 100%;
        }

        .image-gallery {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerAnimalDetail">
        <h1 class="titleAnimalDetail">Detalle del Animal</h1>

        <!-- Información del animal -->
        <div class="cardAnimalInfo">
            <h5 class="card-title">${animal.nombre}</h5>
            <p>
                <strong>Especie:</strong> ${animal.especie}<br>
                <strong>Raza:</strong> ${animal.raza}<br>
                <strong>Edad:</strong> ${animal.edad} años<br>
                <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
            </p>
        </div>

        <!-- Imágenes del animal -->
        <h3 class="sectionTitle">Imágenes</h3>
        <div class="image-gallery">
            <c:forEach var="imagen" items="${imagenesList}">
                <div class="col-md-4 mb-4">
                    <img src="data:image/${imagen.tipoImagen};base64,${imagen.imagen}" class="img-fluid" alt="${animal.nombre}">
                </div>
            </c:forEach>
        </div>

        <!-- Historial Médico -->
        <h3 class="sectionTitle">Historial Médico</h3>
        <table class="table table-bordered tableAnimalDetail">
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

        <!-- Solicitudes de Adopción -->
        <h3 class="sectionTitle">Solicitudes de Adopción</h3>
        <table class="table table-bordered tableAnimalDetail">
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
                                <button type="submit" class="btn-animal">Ver Solicitud</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Vacunas aplicadas -->
        <h3 class="sectionTitle">Vacunas Aplicadas</h3>
        <table class="table table-bordered tableAnimalDetail">
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
    </div>
</body>
</html>
