<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Home Cliente</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>

    <%-- Incluir el navbar para el cliente --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container mt-4">
        <h1>Bienvenido, Cliente</h1>
        <p>Esta es la página de inicio para los clientes.</p>
        
        <h2 class="my-4">Animales</h2>

        <div class="row">
            <%-- Recorre animalesList para mostrar cada animal --%>
            <c:forEach var="animal" items="${animalesList}">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <!-- Mostrar imagen del animal en Base64 si existe en imagenesMap -->
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
                            <a href="${pageContext.request.contextPath}/DetalleAnimalServlet?idAnimal=${animal.idAnimal}" class="btn btn-primary">Ver Detalle</a>
                            <a href="${pageContext.request.contextPath}/FormularioAdopcionCliServlet?idAnimal=${animal.idAnimal}" class="btn btn-success">Solicitar Adopción</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>
    