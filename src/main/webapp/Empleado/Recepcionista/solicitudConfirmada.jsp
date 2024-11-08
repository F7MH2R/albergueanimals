<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Solicitud Confirmada</title>
        <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    </head>
    <body>
          <%-- Incluir la barra de navegación para el recepcionista --%>
        <jsp:include page="navbarRecepcionista.jsp" />
        <div class="container">
            <h1 class="my-4">Solicitud de Adopción Registrada</h1>
            <p>La solicitud de adopción ha sido registrada exitosamente. Nos pondremos en contacto con el adoptante para confirmar los siguientes pasos.</p>
            <a class="nav-link" href="${pageContext.request.contextPath}/AnimalsServlet">Lista de Animales</a>
        </div>
    </body>
</html>
