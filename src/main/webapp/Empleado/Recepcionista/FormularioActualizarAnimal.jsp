<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Información del Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 28px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-label {
            color: #4A665E;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-control {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
        }

        .form-control:focus {
            border-color: #4A665E;
            box-shadow: 0 0 5px rgba(74, 102, 94, 0.5);
        }

        .btn-primary {
            background-color: #4A665E;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #3B534D;
        }

        .my-3 {
            color: #4A665E;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }

        .mb-3 {
            margin-bottom: 20px;
        }

        label {
            display: block;
        }
    </style>
    <script>
        const especiesYrazas = {
            "Perro": ["Labrador", "Bulldog", "Pastor Alemán", "Poodle", "Salchicha"],
            "Gato": ["Siames", "Persa", "Angora", "Bengala", "Siberiano"],
            "Conejo": ["Angora", "Holland Lop", "Lionhead", "Rex"]
        };

        function actualizarRazas() {
            const especie = document.getElementById("especie").value;
            const razaSelect = document.getElementById("raza");

            razaSelect.innerHTML = "";

            if (especie in especiesYrazas) {
                especiesYrazas[especie].forEach(raza => {
                    const option = document.createElement("option");
                    option.value = raza;
                    option.textContent = raza;
                    razaSelect.appendChild(option);
                });
            }
        }

        window.onload = function() {
            actualizarRazas();
            document.getElementById("raza").value = "${raza}";
        };
    </script>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />
    
    <div class="container">
        <h1>Actualizar Información del Animal</h1>
        <form action="${pageContext.request.contextPath}/ActualizarAnimalServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="idAnimal" value="${idAnimal}">
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Animal</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="${nombre}" required>
            </div>
            
            <div class="mb-3">
                <label for="especie" class="form-label">Especie</label>
                <select class="form-control" id="especie" name="especie" onchange="actualizarRazas()" required>
                    <option value="Perro" ${especie == 'Perro' ? 'selected' : ''}>Perro</option>
                    <option value="Gato" ${especie == 'Gato' ? 'selected' : ''}>Gato</option>
                    <option value="Conejo" ${especie == 'Conejo' ? 'selected' : ''}>Conejo</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="raza" class="form-label">Raza</label>
                <select class="form-control" id="raza" name="raza" required>
                    <option value="">Seleccione una raza</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="edad" class="form-label">Edad</label>
                <input type="number" class="form-control" id="edad" name="edad" value="${edad}" min="0" required>
            </div>
            
            <div class="mb-3">
                <label for="estadoSalud" class="form-label">Estado de Salud</label>
                <select class="form-control" id="estadoSalud" name="estadoSalud" required>
                    <option value="Saludable" ${estadoSalud == 'Saludable' ? 'selected' : ''}>Saludable</option>
                    <option value="En recuperación" ${estadoSalud == 'En recuperación' ? 'selected' : ''}>En recuperación</option>
                    <option value="En tratamiento" ${estadoSalud == 'En tratamiento' ? 'selected' : ''}>En tratamiento</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="fechaIngreso" class="form-label">Fecha de Ingreso</label>
                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" value="${fechaIngreso}" readonly required>
            </div>

            <h5 class="my-3">Actualizar Imágenes del Animal</h5>
            <c:forEach var="i" begin="1" end="1">
                <div class="mb-3">
                    <label class="form-label">Imagen ${i}</label>
                    <input type="file" class="form-control" name="imagen${i}" accept="image/*">
                </div>
            </c:forEach>

            <button type="submit" class="btn-primary">Actualizar Animal</button>
        </form>
    </div>
</body>
</html>
