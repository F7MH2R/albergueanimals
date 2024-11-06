<%@page import="modelos.Usuarios"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>
    <div class="container">
        <h1>Gestión de Usuarios</h1>
        
        <a href="<%= request.getContextPath()%>/AgregarUsuarioServlet">Agregar Nuevo Usuario</a>
        
        <h2>Lista de Usuarios</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre de Usuario</th>
                    <th>Nombre Completo</th>
                    <th>Email</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${listaUsuarios}">
                    <tr>
                        <td>${usuario.idUsuario}</td>
                        <td>${usuario.nombreUsuario}</td>
                        <td>${usuario.nombreCompleto}</td>
                        <td>${usuario.correo}</td>
                        <td>${usuario.rol}</td>
                        <td><c:choose>
                            <c:when test="${usuario.estado}">Activo</c:when>
                            <c:otherwise>Inactivo</c:otherwise>
                        </c:choose></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/EditarUsuarioServlet?id=${usuario.idUsuario}" class="btn btn-warning">Editar</a>
                            <a href="${pageContext.request.contextPath}/CambiarEstadoUsuarioServlet?id=${usuario.idUsuario}" class="btn btn-secondary">
                                <c:choose>
                                    <c:when test="${usuario.estado}">Desactivar</c:when>
                                    <c:otherwise>Activar</c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>

