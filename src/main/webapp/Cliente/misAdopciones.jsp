<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Adopciones</title>
    <style>
        .body-misadopciones {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container-misadopciones {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .title-misadopciones {
            font-size: 36px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .card-misadopciones {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-misadopciones h3 {
            font-size: 24px;
            color: #4A665E;
        }

        .card-misadopciones p {
            font-size: 16px;
            color: #666;
            margin: 5px 0;
        }

        .btn-comprobante {
            background-color: #4A665E;
            border: none;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-comprobante:hover {
            background-color: #3B534D;
        }

        .btn-primary-misadopciones {
            background-color: #4A665E;
            border: none;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        .btn-primary-misadopciones:hover {
            background-color: #3B534D;
        }

        .img-misadopciones {
            max-width: 150px;
            margin-top: 10px;
            border-radius: 8px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body class="body-misadopciones">
    
    <%-- Incluir el navbar para el cliente, asegurando que su ruta y logo estén correctos --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container-misadopciones">
        <h2 class="title-misadopciones">Mis Adopciones</h2>

        <c:forEach var="solicitud" items="${solicitudesList}">
            <div class="card-misadopciones">
                <h3>${solicitud.nombreAnimal} (${solicitud.especie})</h3>
                <p><strong>Raza:</strong> ${solicitud.raza}</p>
                <p><strong>Edad:</strong> ${solicitud.edad} años</p>
                <p><strong>Estado de Salud:</strong> ${solicitud.estadoSalud}</p>
                <p><strong>Fecha de Solicitud:</strong> ${solicitud.fechaSolicitud}</p>
                <p><strong>Estado de Solicitud:</strong> ${solicitud.estado}</p>

                <c:if test="${solicitud.imagenUrl != null}">
                    <img src="data:image/jpeg;base64,${solicitud.imagenUrl}" alt="${solicitud.nombreAnimal}" class="img-misadopciones"/>
                </c:if>

                <c:if test="${solicitud.estado == 'Aprobado'}">
                    <form action="DescargarComprobanteServlet" method="post" style="display: inline;">
                        <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitud}" />
                        <button type="submit" class="btn-comprobante">Descargar Comprobante</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
        
        <form action="${pageContext.request.contextPath}/HomeClienteServlet" method="get" style="display: inline;">
            <button type="submit" class="btn-primary-misadopciones">Volver al Home Cliente</button>
        </form>
    </div>

    <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>
