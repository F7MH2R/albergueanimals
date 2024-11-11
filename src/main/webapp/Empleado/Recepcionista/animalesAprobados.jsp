<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Animales Adoptados</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerAnimalesAdoptados {
            max-width: 1200px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .titleAnimalesAdoptados {
            font-size: 32px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .cardAnimalAdoptado {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
            text-align: center;
            max-width: 350px;
            margin: 0 auto;
        }

        .cardAnimalAdoptado:hover {
            transform: translateY(-5px);
        }

        .card-img-top {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            height: 200px;
            object-fit: cover;
            width: 100%;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 24px;
            color: #4A665E;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card-text {
            color: #666;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .btn-comprobante {
            background-color: #4A665E;
            border-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            transition: background-color 0.3s;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-comprobante:hover {
            background-color: #333;
            border-color: #333;
        }
    </style>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerAnimalesAdoptados">
        <h1 class="titleAnimalesAdoptados">Animales Adoptados</h1>
        <div class="row">
            <c:forEach var="animal" items="${animalesAprobadosList}">
                <div class="col-md-4 mb-4 d-flex justify-content-center">
                    <div class="cardAnimalAdoptado">
                        <c:choose>
                            <c:when test="${imagenesMap[animal.idAnimal] != null}">
                                <img src="data:image/${imagenesMap[animal.idAnimal].tipoImagen};base64,${imagenesMap[animal.idAnimal].imagen}" class="card-img-top" alt="${animal.nombre}">
                            </c:when>
                            <c:otherwise>
                                <img src="default-image.jpg" class="card-img-top" alt="Sin imagen">
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body">
                            <h5 class="card-title">${animal.nombre}</h5>
                            <p class="card-text">
                                <strong>Especie:</strong> ${animal.especie}<br>
                                <strong>Raza:</strong> ${animal.raza}<br>
                                <strong>Edad:</strong> ${animal.edad} años<br>
                                <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                                <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                            </p>
                            <a href="${pageContext.request.contextPath}/GenerarComprobanteServlet?idAnimal=${animal.idAnimal}" class="btn btn-comprobante">Ver Comprobante</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
