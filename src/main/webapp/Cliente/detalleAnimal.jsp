<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalles del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>

    <%-- Incluir el navbar para el cliente --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container mt-4">
        <h1>Detalles del Animal</h1>

        <div class="card">
            <c:choose>
                <c:when test="${imagen != null}">
                    <img src="data:image/${imagen.tipoImagen};base64,${imagen.imagen}" class="card-img-top" alt="${animal.nombre}">
                </c:when>
                <c:otherwise>
                    <img src="default-image.jpg" class="card-img-top" alt="Sin imagen">
                </c:otherwise>
            </c:choose>

            <div class="card-body">
                <h2 class="card-title">${animal.nombre}</h2>
                <p class="card-text">
                    <strong>Especie:</strong> ${animal.especie}<br>
                    <strong>Raza:</strong> ${animal.raza}<br>
                    <strong>Edad:</strong> ${animal.edad} años<br>
                    <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                    <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                </p>
                <a href="${pageContext.request.contextPath}/FormularioAdopcionCliServlet?idAnimal=${animal.idAnimal}" class="btn btn-success">Solicitar Adopción</a>
                <a href="${pageContext.request.contextPath}/HomeClienteServlet" class="btn btn-secondary">Regresar</a>
            </div>
        </div>
    </div>

    <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>
