<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Confirmación de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <%-- Incluir la barra de navegación --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container mt-4">
        <h2>Solicitud de Adopción Enviada</h2>
        <p>Tu solicitud de adopción ha sido enviada con éxito. Nos pondremos en contacto contigo pronto.</p>
        <a href="${pageContext.request.contextPath}/HomeClienteServlet" class="btn btn-primary">Volver al Inicio</a>
    </div>
</body>
</html>

