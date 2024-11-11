<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <%-- Incluir la barra de navegación --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container mt-4">
        <h2>Formulario de Adopción</h2>
        
        <form action="${pageContext.request.contextPath}/RegistrarAdopcionCliServlet" method="post">
            <%-- ID del Animal (Oculto) --%>
            <input type="hidden" name="idAnimal" value="${animal.idAnimal}">

            <h3>Datos del Animal</h3>
            <p><strong>Nombre:</strong> ${animal.nombre}</p>
            <p><strong>Especie:</strong> ${animal.especie}</p>
            <p><strong>Raza:</strong> ${animal.raza}</p>

            <h3>Datos del Adoptante</h3>
            <label>Nombre del Adoptante:</label>
            <input type="text" name="nombreAdoptante" value="${cliente.nombreCompleto}" readonly><br>

            <label>Correo Electrónico:</label>
            <input type="email" name="correo" value="${cliente.correo}" readonly><br>

            <label>Teléfono:</label>
            <input type="text" name="telefono" required><br>

            <label>Dirección:</label>
            <input type="text" name="direccion" required><br>

            <button type="submit" class="btn btn-success mt-3">Enviar Solicitud de Adopción</button>
        </form>
    </div>
</body>
</html>
