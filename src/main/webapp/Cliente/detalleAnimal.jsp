<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalles del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        .body-detalles-animal {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container-detalles-animal {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .title-detalles-animal {
            font-size: 32px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .card-detalles-animal {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-detalles-animal img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .card-body-detalles-animal {
            padding: 15px;
            text-align: left;
        }

        .card-title-detalles-animal {
            font-size: 24px;
            color: #4A665E;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .card-text-detalles-animal {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .btn-success-detalles-animal,
        .btn-secondary-detalles-animal {
            background-color: #4A665E; /* Verde oscuro */
            border-color: #4A665E;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
            margin: 5px;
            text-decoration: none;
            display: inline-block;
            transition: none;
        }

        .btn-success-detalles-animal:hover,
        .btn-secondary-detalles-animal:hover {
            background-color: #3B534D;
            border-color: #3B534D;
            color: #ffffff;
            text-decoration: none; /* Evita el subrayado en hover */
        }
    </style>
</head>
<body class="body-detalles-animal">

    <%-- Incluir el navbar para el cliente --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container-detalles-animal">
        <h1 class="title-detalles-animal">Detalles del Animal</h1>

        <div class="card-detalles-animal">
            <c:choose>
                <c:when test="${imagen != null}">
                    <img src="data:image/${imagen.tipoImagen};base64,${imagen.imagen}" class="card-img-top" alt="${animal.nombre}">
                </c:when>
                <c:otherwise>
                    <img src="default-image.jpg" class="card-img-top" alt="Sin imagen">
                </c:otherwise>
            </c:choose>

            <div class="card-body-detalles-animal">
                <h2 class="card-title-detalles-animal">${animal.nombre}</h2>
                <p class="card-text-detalles-animal">
                    <strong>Especie:</strong> ${animal.especie}<br>
                    <strong>Raza:</strong> ${animal.raza}<br>
                    <strong>Edad:</strong> ${animal.edad} años<br>
                    <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                    <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                </p>
                <a href="${pageContext.request.contextPath}/FormularioAdopcionCliServlet?idAnimal=${animal.idAnimal}" class="btn-success-detalles-animal">Solicitar Adopción</a>
                <a href="${pageContext.request.contextPath}/HomeClienteServlet" class="btn-secondary-detalles-animal">Regresar</a>
            </div>
        </div>
    </div>

    <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>
