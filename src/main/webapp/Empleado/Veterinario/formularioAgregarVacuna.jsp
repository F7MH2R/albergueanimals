<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Vacuna Aplicada</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos principales */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerVacuna {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 28px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: bold;
            color: #4A665E;
            margin-bottom: 8px; /* Espacio entre la etiqueta y el campo */
            display: block;
        }

        .form-control, .form-select {
            border-radius: 5px;
            border: 1px solid #cccccc;
            margin-bottom: 20px; /* Espacio entre los campos */
        }

        .btnGuardarVacuna {
            background-color: #4A665E; /* Verde corporativo */
            border-color: #4A665E;
            color: #ffffff;
            font-size: 16px;
            padding: 10px 20px;
            transition: background-color 0.3s;
            width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }

        .btnGuardarVacuna:hover {
            background-color: #3B534D; /* Tono más oscuro de verde */
            border-color: #3B534D;
        }
    </style>

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

    <div class="containerVacuna">
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

            <button type="submit" class="btnGuardarVacuna">Guardar Vacuna</button>
        </form>
    </div>

</body>
</html>
