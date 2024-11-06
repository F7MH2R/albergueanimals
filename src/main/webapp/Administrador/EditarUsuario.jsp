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

<h2>Editar Usuario</h2>
<form action="<%= request.getContextPath() %>/EditarUsuarioServlet" method="post">
    <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>">
    
    <label>Nombre de Usuario:</label>
    <input type="text" name="nombreUsuario" value="<%= usuario.getNombreUsuario() %>" required><br>
    
    <label>Contraseña:</label>
    <input type="password" name="contrasena" value="<%= usuario.getContrasena() %>" required><br>
    
    <label>Nombre Completo:</label>
    <input type="text" name="nombreCompleto" value="<%= usuario.getNombreCompleto() %>" required><br>
    
    <label>Email:</label>
    <input type="email" name="correo" value="<%= usuario.getCorreo() %>" required><br>
    
    <label>Rol:</label>
    <select name="rol" required onchange="toggleEmpleadoFields(this.value)">
        <option value="Administrador" <%= usuario.getRol().equals("Administrador") ? "selected" : "" %>>Administrador</option>
        <option value="Empleado" <%= usuario.getRol().equals("Empleado") ? "selected" : "" %>>Empleado</option>
        <option value="Cliente" <%= usuario.getRol().equals("Cliente") ? "selected" : "" %>>Cliente</option>
    </select><br>

    <label>Teléfono:</label>
    <input type="text" name="telefono" value="<%= usuario.getTelefono() %>" required><br>
    
    <div id="empleadoFields" style="<%= usuario.getRol().equals("Empleado") ? "" : "display: none;" %>">
        <label>Puesto:</label>
        <select name="puesto">
            <option value="Veterinario" <%= "Veterinario".equals(usuario.getPuesto()) ? "selected" : "" %>>Veterinario</option>
            <option value="Recepcionista" <%= "Recepcionista".equals(usuario.getPuesto()) ? "selected" : "" %>>Recepcionista</option>
            <option value="Cuidador" <%= "Cuidador".equals(usuario.getPuesto()) ? "selected" : "" %>>Cuidador</option>
            <option value="Auxiliar" <%= "Auxiliar".equals(usuario.getPuesto()) ? "selected" : "" %>>Auxiliar</option>
            <option value="Asistente" <%= "Asistente".equals(usuario.getPuesto()) ? "selected" : "" %>>Asistente</option>
        </select><br>
    </div>
    
    <button type="submit">Guardar Cambios</button>
</form>

<script>
    function toggleEmpleadoFields(rol) {
        const empleadoFields = document.getElementById("empleadoFields");
        empleadoFields.style.display = rol === "Empleado" ? "block" : "none";
    }
</script>
