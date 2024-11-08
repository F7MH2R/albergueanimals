<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Vacuna Aplicada</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <script>
        const vacunasPorEspecie = {
            "Perro": ["Rabia", "Parvovirus", "Moquillo"],
            "Gato": ["Rabia", "Leucemia Felina", "Panleucopenia"],
            "Conejo": ["Enfermedad Hemorrágica Viral", "Mixomatosis"]
        };

        function actualizarVacunas() {
            const especie = document.getElementById("especie").value;
            const vacunaSelect = document.getElementById("nombreVacuna");

            vacunaSelect.innerHTML = ""; // Limpiar opciones

            if (especie in vacunasPorEspecie) {
                vacunasPorEspecie[especie].forEach(vacuna => {
                    const option = document.createElement("option");
                    option.value = vacuna;
                    option.textContent = vacuna;
                    vacunaSelect.appendChild(option);
                });
            }
        }

        // Ejecutar al cargar la página para preseleccionar las opciones basadas en la especie
        window.onload = function () {
            actualizarVacunas();
        };
    </script>
</head>
<body>
           <%-- Incluir el navbar para el veterinario --%>
    <%@ include file="navbarVeterinario.jsp" %>
<div class="container">
    <h2>Añadir Vacuna Aplicada</h2>
    <form action="${pageContext.request.contextPath}/AgregarVacunaServlet" method="post">
        <input type="hidden" name="idAnimal" value="${idAnimal}">

        <div class="mb-3">
            <label for="especie" class="form-label">Especie</label>
            <select id="especie" name="especie" class="form-select" onchange="actualizarVacunas()" required disabled>
                <option value="" disabled>Seleccione una especie</option>
                <option value="Perro" ${param.especie == 'Perro' ? 'selected' : ''}>Perro</option>
                <option value="Gato" ${param.especie == 'Gato' ? 'selected' : ''}>Gato</option>
                <option value="Conejo" ${param.especie == 'Conejo' ? 'selected' : ''}>Conejo</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="nombreVacuna" class="form-label">Nombre de la Vacuna</label>
            <select id="nombreVacuna" name="nombreVacuna" class="form-select" required>
                <option value="" disabled selected>Seleccione una vacuna</option>
                <!-- Las opciones se llenarán automáticamente según la especie seleccionada -->
            </select>
        </div>

        <div class="mb-3">
            <label for="ml" class="form-label">Cantidad (ml)</label>
            <select id="ml" name="ml" class="form-select" required>
                <option value="" disabled selected>Seleccione la cantidad</option>
                <option value="0.5">0.5 ml</option>
                <option value="1.0">1.0 ml</option>
                <option value="1.5">1.5 ml</option>
                <option value="2.0">2.0 ml</option>
                <option value="2.5">2.5 ml</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Guardar Vacuna</button>
    </form>
</div>
</body>
</html>
