<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
%>

<nav>
    <ul>
        <li>Bienvenido, <%= usuario.getNombreCompleto()%> (Administrador)</li>
        <li><a href="<%= request.getContextPath() %>/HomeAdminServlet">Inicio</a></li>
        <li><a href="<%= request.getContextPath() %>/GestionUsuariosServlet">Gestión de Usuarios</a></li>
        <li><a href="<%= request.getContextPath() %>/ReportesServlet">Reportes</a></li>
        <li><a href="<%= request.getContextPath()%>/LogoutServlet">Cerrar Sesión</a></li>
    </ul>
</nav>
