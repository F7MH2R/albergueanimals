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
8
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Nuevo Usuario</title>
    <style>
        /* General background and font settings */
        body {
            background-color: #F0EEED;
        }

        /* Container styling */
        .container {
            margin-left: 500px;
            margin-top: 150px;
            max-width: 800px;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        /* Header styling */
        .titulo {
            font-size: 35px;
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
            font-size: 20px;
            color: #4A665E;
            display: block;
            margin-bottom: 5px;
        }

        /* Form control styling */
        .form-control {
            font-size: 20px;
            color: #333;
            border: 1px solid #4A665E;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        /* Form layout styling */
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
            width: 100%;
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        /* Button styling */
        input[type="submit"] {
            font-size: 20px;
            color: #fff;
            background-color: #4A665E;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #333;
        }

        /* Link styling */
        .a2 {
            color: #4A665E;
            font-size: 20px;
            text-decoration: none;
            display: block;
            margin-top: 20px;
        }

        a:hover {
            color: #333;
        }

        /* Toggle field styling */
        #puestoField {
            margin-top: 10px;
            display: none;
        }
    </style>
    <script>
        function toggleEmpleadoFields() {
            const rol = document.getElementById("rol").value;
            const puestoField = document.getElementById("puestoField");
            puestoField.style.display = rol === "Empleado" ? "block" : "none";
        }

        function validateForm() {
            // Validación de que los campos no estén vacíos
            const fields = ["nombreUsuario", "contrasena", "nombreCompleto", "correo", "telefono"];
            for (let i = 0; i < fields.length; i++) {
                const field = document.getElementById(fields[i]);
                if (field.value.trim() === "") {
                    alert("Por favor, completa todos los campos.");
                    field.focus();
                    return false;
                }
            }

            // Validación del número de teléfono (exactamente 8 dígitos)
            const telefono = document.getElementById("telefono").value;
            const telefonoPattern = /^\d{8}$/;
            if (!telefonoPattern.test(telefono)) {
                alert("El número de teléfono debe tener exactamente 8 dígitos.");
                document.getElementById("telefono").focus();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1 class="titulo">Agregar Nuevo Usuario</h1>

        <%-- Mostrar mensaje de error si existe --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/AgregarUsuarioServlet" method="post" onsubmit="return validateForm()">
            <div class="form-row">
                <div class="form-group">
                    <label for="nombreUsuario">Nombre de Usuario:</label>
                    <input type="text" id="nombreUsuario" name="nombreUsuario" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" class="form-control" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="nombreCompleto">Nombre Completo:</label>
                    <input type="text" id="nombreCompleto" name="nombreCompleto" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="correo">Correo:</label>
                    <input type="email" id="correo" name="correo" class="form-control" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" class="form-control" required maxlength="8" pattern="\d{8}" title="El número de teléfono debe tener exactamente 8 dígitos.">
                </div>
                <div class="form-group">
                    <label for="rol">Rol:</label>
                    <select id="rol" name="rol" class="form-control" onchange="toggleEmpleadoFields()" required>
                        <option value="Administrador">Administrador</option>
                        <option value="Empleado">Empleado</option>
                        <option value="Cliente">Cliente</option>
                    </select>
                </div>
            </div>

            <div id="puestoField" class="form-group">
                <label for="puesto">Puesto:</label>
                <select id="puesto" name="puesto" class="form-control">
                    <option value="Veterinario">Veterinario</option>
                    <option value="Recepcionista">Recepcionista</option>
                    <option value="Cuidador">Cuidador</option>
                    <option value="Auxiliar">Auxiliar</option>
                    <option value="Asistente">Asistente</option>
                </select>
            </div>

            <input type="submit" value="Agregar Usuario">
        </form>
        <a class="a2" href="<%= request.getContextPath() %>/GestionUsuariosServlet">Volver a Gestión de Usuarios</a>
    </div>
</body>
</html>
