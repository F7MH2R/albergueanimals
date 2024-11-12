<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Adopción</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos principales */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerAdoptionForm {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .titleAdoptionForm {
            font-size: 28px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-label {
            font-size: 16px;
            color: #4A665E;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .btn-submit {
            background-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            cursor: pointer;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: #333;
        }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function buscarCliente() {
            const nombreCliente = document.getElementById("nombreAdoptante").value;
            $.ajax({
                url: "${pageContext.request.contextPath}/BuscarClienteServlet",
                type: "GET",
                data: { nombre: nombreCliente },
                success: function(response) {
                    if (response) {
                        $("#correo").val(response.correo);
                        $("#telefono").val(response.telefono);
                        $("#direccion").val(response.direccion);
                    }
                },
                error: function() {
                    console.log("Error al buscar el cliente.");
                }
            });
        }
    </script>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerAdoptionForm">
        <h2 class="titleAdoptionForm">Formulario de Adopción</h2>
        <form action="${pageContext.request.contextPath}/RegistrarAdopcionServlet" method="post">
            <label class="form-label">Nombre del Adoptante:</label>
            <input type="text" id="nombreAdoptante" name="nombreAdoptante" onblur="buscarCliente()" class="form-control" required>

            <label class="form-label">Correo Electrónico:</label>
            <input type="email" id="correo" name="correo" class="form-control" required>

            <label class="form-label">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" class="form-control" maxlength="8" pattern="\d{8}" title="Debe contener solo números y no más de 8 dígitos" required>

            <label class="form-label">Dirección:</label>
            <input type="text" id="direccion" name="direccion" class="form-control" required>

            <button type="submit" class="btn-submit">Enviar Solicitud de Adopción</button>
        </form>
    </div>
</body>
</html>
