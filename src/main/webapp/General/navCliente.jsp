<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
%>

<nav>
    <ul>
        <li>Bienvenido, <%= usuario.getNombreCompleto() %> (Cliente)</li>
        <li><a href="../Cliente/HomeCliente.jsp">Inicio</a></li>
        <li><a href="../Cliente/SolicitarAdopcion.jsp">Solicitar Adopción</a></li>
        <li><a href="../Cliente/MisSolicitudes.jsp">Mis Solicitudes</a></li>
        <li><a href="<%= request.getContextPath()%>/LogoutServlet">Cerrar Sesión</a></li>
    </ul>
</nav>
