<%@page import="modelos.Usuarios"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");

    if (usuario == null) {
        // Redirige a la página de login si el usuario no ha iniciado sesión
        request.getRequestDispatcher("/General/login.jsp").forward(request, response);
        return;
    }

    String rol = usuario.getRol();
%>

<%-- Incluir la barra de navegación específica del rol --%>
<jsp:include page="<%= (rol.equals("Administrador") ? "../General/navAdmin.jsp" : 
                     (rol.equals("Empleado") ? "../General/navEmpleado.jsp" : 
                     "../General/navCliente.jsp")) %>" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Nuevo Usuario</title>
    <script>
        function toggleEmpleadoFields() {
            const rol = document.getElementById("rol").value;
            const puestoField = document.getElementById("puestoField");
            puestoField.style.display = rol === "Empleado" ? "block" : "none";
        }
    </script>
</head>
<body>
    <h1>Agregar Nuevo Usuario</h1>
    <form action="<%= request.getContextPath() %>/AgregarUsuarioServlet" method="post">
        <label for="nombreUsuario">Nombre de Usuario:</label>
        <input type="text" id="nombreUsuario" name="nombreUsuario" required><br>

        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required><br>

        <label for="nombreCompleto">Nombre Completo:</label>
        <input type="text" id="nombreCompleto" name="nombreCompleto" required><br>

        <label for="correo">Correo:</label>
        <input type="email" id="correo" name="correo" required><br>

        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" name="telefono"><br>

        <label for="rol">Rol:</label>
        <select id="rol" name="rol" onchange="toggleEmpleadoFields()" required>
            <option value="Administrador">Administrador</option>
            <option value="Empleado">Empleado</option>
            <option value="Cliente">Cliente</option>
        </select><br>

        <div id="puestoField" style="display: none;">
            <label for="puesto">Puesto:</label>
            <select id="puesto" name="puesto">
                <option value="Veterinario">Veterinario</option>
                <option value="Recepcionista">Recepcionista</option>
                <option value="Cuidador">Cuidador</option>
                <option value="Auxiliar">Auxiliar</option>
                <option value="Asistente">Asistente</option>
            </select><br>
        </div>

        <input type="submit" value="Agregar Usuario">
    </form>
    <a href="<%= request.getContextPath() %>/GestionUsuariosServlet">Volver a Gestión de Usuarios</a>
</body>
</html>
