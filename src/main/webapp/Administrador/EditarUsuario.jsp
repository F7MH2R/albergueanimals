<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>

<%
    // Verificar el usuario actual de la sesión para mostrar la barra de navegación
    Usuarios usuarioSesion = (Usuarios) session.getAttribute("usuario");

    if (usuarioSesion == null) {
        // Redirige a la página de login si el usuario no ha iniciado sesión
        request.getRequestDispatcher("/General/login.jsp").forward(request, response);
        return;
    }

    // Determinar el rol del usuario de la sesión
    String rol = usuarioSesion.getRol();

    // Obtener el usuario que se desea editar desde el request
    Usuarios usuario = (Usuarios) request.getAttribute("usuario");
%>

<%-- Incluir la barra de navegación basada en el rol del usuario actual --%>
<jsp:include page="<%= (rol.equals("Administrador") ? "../General/navAdmin.jsp" : 
                     (rol.equals("Empleado") ? "../General/navEmpleado.jsp" : 
                     "../General/navCliente.jsp")) %>" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <style>
        /* General background and font settings */
        body {
            background-color: #F0EEED;
            
        }

        /* Container styling */
        .container {
            margin-left: 600px;
            margin-top: 100px;
            max-width: 600px;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Header styling */
        h2 {
            font-size: 30px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        /* Error message styling */
        .error-message {
            color: #D9534F;
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Label styling */
        label {
            font-size: 18px;
            color: #4A665E;
            display: block;
            margin-bottom: 5px;
            text-align: left;
        }

        /* Form control styling */
        .form-control {
            font-size: 16px;
            color: #333;
            border: 1px solid #4A665E;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 15px;
        }

        /* Button styling */
        button[type="submit"] {
            font-size: 18px;
            color: #fff;
            background-color: #4A665E;
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        button[type="submit"]:hover {
            background-color: #333;
        }
    </style>
    <script>
        function toggleEmpleadoFields(rol) {
            const empleadoFields = document.getElementById("empleadoFields");
            empleadoFields.style.display = rol === "Empleado" ? "block" : "none";
        }

        function validateForm() {
            // Validación de que los campos no estén vacíos
            const fields = ["nombreUsuario", "contrasena", "nombreCompleto", "correo", "telefono"];
            for (let i = 0; i < fields.length; i++) {
                const field = document.getElementsByName(fields[i])[0];
                if (field.value.trim() === "") {
                    alert("Por favor, completa todos los campos.");
                    field.focus();
                    return false;
                }
            }

            // Validación del número de teléfono (exactamente 8 dígitos)
            const telefono = document.getElementsByName("telefono")[0].value;
            const telefonoPattern = /^\d{8}$/;
            if (!telefonoPattern.test(telefono)) {
                alert("El número de teléfono debe tener exactamente 8 dígitos.");
                document.getElementsByName("telefono")[0].focus();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Editar Usuario</h2>
        
        <%-- Mostrar mensaje de error si existe --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/EditarUsuarioServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>">
            
            <label for="nombreUsuario">Nombre de Usuario:</label>
            <input type="text" id="nombreUsuario" name="nombreUsuario" value="<%= usuario.getNombreUsuario() %>" class="form-control" required>
            
            <label for="contrasena">Contraseña:</label>
            <input type="password" id="contrasena" name="contrasena" value="<%= usuario.getContrasena() %>" class="form-control" required>
            
            <label for="nombreCompleto">Nombre Completo:</label>
            <input type="text" id="nombreCompleto" name="nombreCompleto" value="<%= usuario.getNombreCompleto() %>" class="form-control" required>
            
            <label for="correo">Email:</label>
            <input type="email" id="correo" name="correo" value="<%= usuario.getCorreo() %>" class="form-control" required>
            
            <label for="rol">Rol:</label>
            <select id="rol" name="rol" class="form-control" required onchange="toggleEmpleadoFields(this.value)">
                <option value="Administrador" <%= usuario.getRol().equals("Administrador") ? "selected" : "" %>>Administrador</option>
                <option value="Empleado" <%= usuario.getRol().equals("Empleado") ? "selected" : "" %>>Empleado</option>
                <option value="Cliente" <%= usuario.getRol().equals("Cliente") ? "selected" : "" %>>Cliente</option>
            </select>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" value="<%= usuario.getTelefono() %>" class="form-control" required maxlength="8" pattern="\d{8}" title="El número de teléfono debe tener exactamente 8 dígitos.">

            <div id="empleadoFields" style="<%= usuario.getRol().equals("Empleado") ? "" : "display: none;" %>">
                <label for="puesto">Puesto:</label>
                <select id="puesto" name="puesto" class="form-control">
                    <option value="Veterinario" <%= "Veterinario".equals(usuario.getPuesto()) ? "selected" : "" %>>Veterinario</option>
                    <option value="Recepcionista" <%= "Recepcionista".equals(usuario.getPuesto()) ? "selected" : "" %>>Recepcionista</option>
                    <option value="Cuidador" <%= "Cuidador".equals(usuario.getPuesto()) ? "selected" : "" %>>Cuidador</option>
                    <option value="Auxiliar" <%= "Auxiliar".equals(usuario.getPuesto()) ? "selected" : "" %>>Auxiliar</option>
                    <option value="Asistente" <%= "Asistente".equals(usuario.getPuesto()) ? "selected" : "" %>>Asistente</option>
                </select>
            </div>
            
            <button type="submit">Guardar Cambios</button>
        </form>
    </div>
</body>
</html>

