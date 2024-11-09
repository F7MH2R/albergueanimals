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
<style>
        /* Estilos principales */
        body {
            background-color: #ECECEC;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            
        }

        .container {
           margin-left: 400px;
            margin-top: 50px;
            margin-bottom: 50px;
            max-width: 1075px;
            background-color: #F7F7F7;
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h1, h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 36px;
        }

        h2 {
            font-size: 28px;
            color: #4A665E;
        }

        /* Botón para agregar usuario */
        a.btn-primary {
            display: inline-block;
            margin-bottom: 20px;
            font-size: 18px;
            color: #fff;
            background-color: #4A665E;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        a.btn-primary:hover {
            background-color: #333;
        }

        /* Estilo de tabla */
        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .table th {
            background-color: #FACECA;
            color: #333;
            font-size: 20px;
            text-align: center;
        }

        .table td {
            font-size: 18px;
            color: #666;
            text-align: center;
            padding: 15px;
        }

        /* Botones de acción */
        .btn-warning, .btn-secondary {
            font-size: 18px;
            color: #fff;
            padding: 8px 12px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-warning {
            background-color: #F0AD4E;
        }

        .btn-warning:hover {
            background-color: #D0893B;
        }

        .btn-secondary {
            background-color: #6C757D;
        }

        .btn-secondary:hover {
            background-color: #545B62;
        }
    </style>
<body>
    <div class="container">
        <h1>Gestión de Usuarios</h1>
        
        <a class="btn btn-primary" href="<%= request.getContextPath()%>/AgregarUsuarioServlet">Agregar Nuevo Usuario</a>
        
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

