<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Adopción</title>
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
    <h2>Formulario de Adopción</h2>
    <form action="${pageContext.request.contextPath}/RegistrarAdopcionServlet" method="post">
        <label>Nombre del Adoptante:</label>
        <input type="text" id="nombreAdoptante" name="nombreAdoptante" onblur="buscarCliente()" required><br>

        <label>Correo Electrónico:</label>
        <input type="email" id="correo" name="correo"><br>

        <label>Teléfono:</label>
        <input type="text" id="telefono" name="telefono"><br>

        <label>Dirección:</label>
        <input type="text" id="direccion" name="direccion"><br>

        <button type="submit">Enviar Solicitud de Adopción</button>
    </form>
</body>
</html>
