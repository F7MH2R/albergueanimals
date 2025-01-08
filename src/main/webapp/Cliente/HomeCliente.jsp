<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Home Cliente</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        .bodyclientehome {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container-cliente {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-top: 30px;
            text-align: center;
        }

        .title-cliente {
            font-size: 36px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .subtitle-cliente {
            font-size: 28px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .card-cliente {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            text-align: left;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-cliente:hover {
            transform: translateY(-5px);
        }

        .card-cliente img {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            height: 250px;
            object-fit: cover;
            width: 100%;
        }

        .card-body-cliente {
            padding: 15px;
            flex-grow: 1;
        }

        .card-title-cliente {
            font-size: 22px;
            color: #4A665E;
            font-weight: bold;
        }

        .card-text-cliente {
            font-size: 16px;
            color: #666;
            margin-bottom: 15px;
        }

        .btn-clientehome {
            background-color: #4A665E;
            border-color: #4A665E;
            color: #ffffff;
            padding: 8px 16px;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
            width: 100%;
            margin-bottom: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-clientehome:hover {
            background-color: #6B847A;
            border-color: #6B847A;
            color: #ffffff;
            text-decoration: none;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
    </style>
    <script>
        // Script para filtrar las tarjetas de animales
        function buscarAnimales() {
            const input = document.getElementById("buscador").value.toLowerCase();
            const cards = document.querySelectorAll(".card-cliente");
            
            cards.forEach(card => {
                const nombre = card.querySelector(".card-title-cliente").textContent.toLowerCase();
                if (nombre.includes(input)) {
                    card.parentElement.style.display = "block";
                } else {
                    card.parentElement.style.display = "none";
                }
            });
        }
    </script>
</head>
<body class="bodyclientehome">

    <%-- Incluir el navbar para el cliente --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container-cliente mt-4">
        <h1 class="title-cliente">Bienvenido, Cliente</h1>
        <p>Esta es la página de inicio para los clientes.</p>
        
        <h2 class="subtitle-cliente my-4">Animales</h2>

        <%-- Barra de búsqueda --%>
        <div class="mb-4">
            <input type="text" id="buscador" class="form-control" placeholder="Buscar por nombre de animal..." onkeyup="buscarAnimales()">
        </div>

        <div class="row">
            <%-- Recorre animalesList para mostrar cada animal --%>
            <c:forEach var="animal" items="${animalesList}">
                <div class="col-md-4 mb-4">
                    <div class="card-cliente">
                        <!-- Mostrar imagen del animal en Base64 si existe en imagenesMap -->
                        <c:choose>
                            <c:when test="${imagenesMap[animal.idAnimal] != null}">
                                <img src="data:image/${imagenesMap[animal.idAnimal].tipoImagen};base64,${imagenesMap[animal.idAnimal].imagen}"
                                     class="card-img-top" alt="${animal.nombre}">
                            </c:when>
                            <c:otherwise>
                                <img src="default-image.jpg" class="card-img-top" alt="Sin imagen">
                            </c:otherwise>
                        </c:choose>

                        <div class="card-body-cliente">
                            <h5 class="card-title-cliente">${animal.nombre}</h5>
                            <p class="card-text-cliente">
                                <strong>Especie:</strong> ${animal.especie}<br>
                                <strong>Raza:</strong> ${animal.raza}<br>
                                <strong>Edad:</strong> ${animal.edad} años<br>
                                <strong>Estado de Salud:</strong> ${animal.estadoSalud}<br>
                                <strong>Fecha de Ingreso:</strong> ${animal.fechaIngreso}
                            </p>
                            <a href="${pageContext.request.contextPath}/DetalleAnimalServlet?idAnimal=${animal.idAnimal}" class="btn-clientehome">Ver Detalle</a>
                            <a href="${pageContext.request.contextPath}/FormularioAdopcionCliServlet?idAnimal=${animal.idAnimal}" class="btn-clientehome">Solicitar Adopción</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>
