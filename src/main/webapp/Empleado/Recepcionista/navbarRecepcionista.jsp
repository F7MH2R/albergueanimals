<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Navegación Recepcionista</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Recepción</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <!-- Enlace para registrar animales -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/RegistrarAnimalServlet">Registrar Animal</a>
                    </li>

                    <!-- Enlace para gestionar adopciones -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GestionAdopcionesServlet">Gestionar Adopciones</a>
                    </li>

                    <!-- Enlace para ver lista de animales en formato tarjeta -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/AnimalsServlet">Lista de Animales</a>
                    </li>

                    <!-- Enlace para ver lista de animales adoptados -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/AnimalsAdoptedServlet">Animales Adoptados</a>
                    </li>
                </ul>

                <!-- Opciones del usuario (Cerrar sesión, etc.) -->
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</body>
</html>
