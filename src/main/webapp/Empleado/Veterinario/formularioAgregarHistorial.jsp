<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Historial Médico</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos principales */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerHistorial {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 28px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: bold;
            color: #4A665E;
            margin-bottom: 8px; /* Espacio entre la etiqueta y el campo */
            display: block;
        }

        .form-control, .form-select {
            border-radius: 5px;
            border: 1px solid #cccccc;
            margin-bottom: 20px; /* Espacio entre los campos */
        }

        .btnGuardarHistorial {
            background-color: #4A665E; /* Verde corporativo */
            border-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            transition: background-color 0.3s;
            width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }

        .btnGuardarHistorial:hover {
            background-color: #3B534D; /* Tono más oscuro de verde */
            border-color: #3B534D;
        }
    </style>
</head>
<body>

    <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>

    <div class="containerHistorial">
        <h2>Añadir Historial Médico</h2>
        <form action="${pageContext.request.contextPath}/AgregarHistorialMedicoServlet" method="post">
            <input type="hidden" name="idAnimal" value="${idAnimal}">
            
            <div class="mb-3">
                <label for="tratamiento" class="form-label">Tratamiento</label>
                <input type="text" class="form-control" id="tratamiento" name="tratamiento" required>
            </div>
            
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
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
            
            <button type="submit" class="btnGuardarHistorial">Guardar Historial</button>
        </form>
    </div>

</body>
</html>
