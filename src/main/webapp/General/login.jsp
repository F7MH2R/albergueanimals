<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesi�n</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="path/to/bootstrap.css"> <!-- Cambia el path a tu archivo CSS de Bootstrap -->
</head>
<body>
    <div class="container">
        <h2 class="text-center mt-4">Iniciar Sesi�n</h2>
        
        <%-- Mostrar mensaje de error si existe --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Nombre de Usuario:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Contrase�a:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block mt-3">Ingresar</button>
        </form>
        <p class="text-center mt-3">
            <a href="Cliente/Register.jsp">�No tienes una cuenta? Reg�strate</a>
        </p>
    </div>
</body>
</html>
