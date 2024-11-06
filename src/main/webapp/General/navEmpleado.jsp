<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelos.Usuarios" %>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
%>

<nav>
    <ul>
        <li>Bienvenido, <%= usuario.getNombreCompleto() %> (Empleado)</li>
        <li><a href="../Empleado/HomeEmpleado.jsp">Inicio</a></li>
        <li><a href="../Empleado/RegistroAnimales.jsp">Registro de Animales</a></li>
        <li><a href="../Empleado/HistorialMedico.jsp">Historial Médico</a></li>
         <li><a href="<%= request.getContextPath()%>/LogoutServlet">Cerrar Sesión</a></li>
    </ul>
</nav>
