<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Registro Exitoso</title>
        <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    </head>
    <body>
        <div class="container mt-5">
            <div class="alert alert-success" role="alert">
                <h4 class="alert-heading">¡Registro Exitoso!</h4>
                <p>El animal se ha registrado correctamente en el sistema.</p>
                <hr>
                <a href="${pageContext.request.contextPath}/InicioRecepcionistaServlet" class="btn btn-primary">Volver al Inicio</a>
            </div>
        </div>
    </body>
</html>
