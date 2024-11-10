<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Home Cliente</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
</head>
<body>

    <%-- Incluir el navbar para el cliente --%>
    <jsp:include page="../General/navCliente.jsp" />

    <div class="container mt-4">
        <h1>Bienvenido, Cliente</h1>
        <p>Esta es la página de inicio para los clientes.</p>
        
        <!-- Aquí puedes agregar más contenido específico del Home del Veterinario -->
    </div>

     <%-- Incluir el footer para el cliente --%>
    <jsp:include page="../General/footer.jsp" />
</body>
</html>