<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Adopciones</title>
</head>
<body>
    <h2>Mis Adopciones</h2>

    <c:forEach var="solicitud" items="${solicitudesList}">
        <div style="border: 1px solid #ddd; padding: 15px; margin-bottom: 10px;">
            <h3>${solicitud.nombreAnimal} (${solicitud.especie})</h3>
            <p><strong>Raza:</strong> ${solicitud.raza}</p>
            <p><strong>Edad:</strong> ${solicitud.edad} años</p>
            <p><strong>Estado de Salud:</strong> ${solicitud.estadoSalud}</p>
            <p><strong>Fecha de Solicitud:</strong> ${solicitud.fechaSolicitud}</p>
            <p><strong>Estado de Solicitud:</strong> ${solicitud.estado}</p>

            <c:if test="${solicitud.imagenUrl != null}">
                <img src="data:image/jpeg;base64,${solicitud.imagenUrl}" alt="${solicitud.nombreAnimal}" style="max-width: 150px;"/>
            </c:if>

            <c:if test="${solicitud.estado == 'Aprobada'}">
                <form action="DescargarComprobanteServlet" method="post">
                    <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}" />
                    <button type="submit">Descargar Comprobante</button>
                </form>
            </c:if>
        </div>
    </c:forEach>
</body>
</html>

