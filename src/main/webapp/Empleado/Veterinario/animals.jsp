<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Animales</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerAnim {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
        }

        h1.titleAnim {
            font-size: 32px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .cardAnim {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
            text-align: center;
            width: 100%;
            max-width: 350px;
            height: 550px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .cardAnim:hover {
            transform: translateY(-5px);
        }

        .cardAnim img {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            height: 250px;
            object-fit: cover;
            width: 100%;
        }

        .cardAnim .default-img {
            height: 250px;
            width: 100%;
            background-color: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #888;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        .cardBodyAnim {
            padding: 20px;
            flex-grow: 1;
        }

        .cardTitleAnim {
            font-size: 24px;
            color: #4A665E;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .cardTextAnim {
            color: #666;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .btnAnim {
            background-color: #4A665E;
            border-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
            margin-top: auto;
        }

        .btnAnim:hover {
            background-color: #333;
            border-color: #333;
        }
    </style>
</head>
<body>

    <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>

    <div class="containerAnim">
        <h1 class="titleAnim">Animales</h1>
        <div class="row">
            <c:forEach var="animal" items="${animalesList}">
                <div class="col-md-4 d-flex justify-content-center">
                    <div class="cardAnim">
                        <!-- Mostrar imagen del animal en Base64 o una imagen predeterminada -->
                        <c:choose>
                            <c:when test="${imagenesMap[animal.idAnimal] != null}">
                                <img src="data:image/${imagenesMap[animal.idAnimal].tipoImagen};base64,${imagenesMap[animal.idAnimal].imagen}"
                                     class="card-img-top" alt="${animal.nombre}">
                            </c:when>
                            <c:otherwise>
                                <div class="default-img">Sin Imagen</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="cardBodyAnim">
                            <h5 class="cardTitleAnim">${animal.nombre}</h5>
                            <p class="cardTextAnim">
                                <strong>Especie:</strong> ${animal.especie}<br>
                                <strong>Raza:</strong> ${animal.raza}<br>
                                <strong>Edad:</strong> ${animal.edad} años<br>
                                <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                                <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                            </p>
                            <a href="${pageContext.request.contextPath}/VerHistorialVeterinarioServlet?idAnimal=${animal.idAnimal}" class="btnAnim">Ver Detalle</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>
