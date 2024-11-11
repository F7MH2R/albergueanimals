<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio Empleado - Recepcionista</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerRecep {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
            text-align: center;
        }

        .titleRecep {
            font-size: 32px;
            color: #4A665E;
            margin-bottom: 20px;
        }

        .textRecep {
            color: #666;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .card-containerRecep {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .cardRecep {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 300px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .cardRecep:hover {
            transform: translateY(-5px);
        }

        .cardRecep h3 {
            font-size: 24px;
            color: #4A665E;
            margin-bottom: 10px;
        }

        .cardRecep p {
            color: #666;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .cardRecep a {
            font-size: 16px;
            display: inline-block;
            padding: 10px 20px;
            color: #ffffff;
            background-color: #4A665E;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .cardRecep a:hover {
            background-color: #333;
        }

        .cardRecep .icon {
            font-size: 50px;
            color: #FACECA;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerRecep">
        <h1 class="titleRecep">Bienvenido, querido empleado</h1>
        <p class="textRecep">Accede a las opciones de gestión disponibles para el personal de recepción.</p>

        <div class="card-containerRecep">
            <!-- Tarjeta para Registrar Animal -->
            <div class="cardRecep">
                <i class="fas fa-plus-square icon"></i>
                <h3>Registrar Animal</h3>
                <p>Registra nuevos animales en el sistema.</p>
                <a href="${pageContext.request.contextPath}/RegistrarAnimalServlet">Ir a Registro de Animales</a>
            </div>

            <!-- Tarjeta para Lista de Animales -->
            <div class="cardRecep">
                <i class="fas fa-list icon"></i>
                <h3>Lista de Animales</h3>
                <p>Consulta la lista completa de animales disponibles.</p>
                <a href="${pageContext.request.contextPath}/AnimalsServlet">Ver Lista de Animales</a>
            </div>

            <!-- Tarjeta para Animales Adoptados -->
            <div class="cardRecep">
                <i class="fas fa-paw icon"></i>
                <h3>Animales Adoptados</h3>
                <p>Revisa el historial de animales que han sido adoptados.</p>
                <a href="${pageContext.request.contextPath}/AnimalsAdoptedServlet">Ver Animales Adoptados</a>
            </div>
        </div>
    </div>
</body>
</html>
