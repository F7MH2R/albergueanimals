<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Animales</title>
        <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    </head>
    <body>
          <%-- Incluir la barra de navegación para el recepcionista --%>
        <jsp:include page="navbarRecepcionista.jsp" />
        <div class="container">
            <h1 class="my-4">Animales</h1>
            <div class="row">
                <c:forEach var="animal" items="${animalesList}">
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <!-- Mostrar imagen del animal en Base64 -->
                            <c:choose>
                                <c:when test="${imagenesMap[animal.idAnimal] != null}">
                                    <img src="data:image/${imagenesMap[animal.idAnimal].tipoImagen};base64,${imagenesMap[animal.idAnimal].imagen}"
                                         class="card-img-top" alt="${animal.nombre}">
                                </c:when>
                                <c:otherwise>
                                    <img src="default-image.jpg" class="card-img-top" alt="Sin imagen">
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body">
                                <h5 class="card-title">${animal.nombre}</h5>
                                <p class="card-text">
                                    <strong>Especie:</strong> ${animal.especie}<br>
                                    <strong>Raza:</strong> ${animal.raza}<br>
                                    <strong>Edad:</strong> ${animal.edad} años<br>
                                    <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                                    <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                                </p>
                                <a href="${pageContext.request.contextPath}/VerHistorialServlet?idAnimal=${animal.idAnimal}" class="btn btn-primary">Ver Detalle</a>
                                <a href="${pageContext.request.contextPath}/FormularioAdopcionServlet?idAnimal=${animal.idAnimal}" class="btn btn-success">Solicitud de Adopción</a>
                                <!-- Botón para actualizar información -->
                                <a href="${pageContext.request.contextPath}/ActualizarAnimalServlet?idAnimal=${animal.idAnimal}" class="btn btn-warning">Actualizar Información</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
