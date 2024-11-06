<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <div class="container">
        <h1 class="my-4 text-danger">Ocurrió un Error</h1>
        <p>Lo sentimos, algo salió mal mientras procesábamos su solicitud.</p>
        <p>Por favor, inténtelo de nuevo más tarde o contacte al administrador si el problema persiste.</p>
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary">Volver a la Página de Inicio</a>
    </div>
</body>
</html>
