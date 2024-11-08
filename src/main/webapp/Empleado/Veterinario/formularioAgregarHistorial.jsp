<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Historial Médico</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
           <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>
<div class="container">
    <h2>Añadir Historial Médico</h2>
    <form action="${pageContext.request.contextPath}/AgregarHistorialMedicoServlet" method="post">
        <input type="hidden" name="idAnimal" value="${idAnimal}">
        
        <div class="mb-3">
            <label for="tratamiento" class="form-label">Tratamiento</label>
            <input type="text" class="form-control" id="tratamiento" name="tratamiento" required>
        </div>
        
        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
        </div>
        
        <div class="mb-3">
            <label for="estadoTratamiento" class="form-label">Estado del Tratamiento</label>
            <select class="form-select" id="estadoTratamiento" name="estadoTratamiento" required>
                <option value="" disabled selected>Seleccionar estado</option>
                <option value="Completado">Completado</option>
                <option value="En Progreso">En Progreso</option>
                <option value="Pendiente">Pendiente</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-primary">Guardar Historial</button>
    </form>
</div>
</body>
</html>
