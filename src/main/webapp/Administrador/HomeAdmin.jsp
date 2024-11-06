<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");

    if (usuario == null) {
        request.getRequestDispatcher("/General/login.jsp").forward(request, response);
        return;
    }

    String rol = usuario.getRol();
%>

<%-- Incluir el archivo de navegación adecuado --%>
<jsp:include page="<%= (rol.equals("Administrador") ? "../General/navAdmin.jsp" : 
                     (rol.equals("Empleado") ? "../General/navEmpleado.jsp" : 
                     "../General/navCliente.jsp")) %>" />

<h1>Bienvenido a la página de inicio del Administrador</h1>
