<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Navegación Veterinario</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">NAV LOGO</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <!-- Enlace para ver lista de animales en formato tarjeta -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/VeterinarioAnimalsServlet">Lista de Animales</a>
                    </li>

                    <!-- Enlace para gestionar historial médico -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/GestionHistorialServlet">Gestionar Historial Médico</a>
                    </li>

                    <!-- Enlace para registrar vacunas -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/RegistrarVacunaServlet">Registrar Vacunas</a>
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
