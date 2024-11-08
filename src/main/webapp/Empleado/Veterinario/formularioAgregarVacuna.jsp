<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Vacuna Aplicada</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <script>
        // Lista de vacunas específicas para cada tipo de animal
        const vacunasPorEspecie = {
            "Perro": ["Rabia", "Parvovirus", "Moquillo", "Hepatitis", "Leptospirosis"],
            "Gato": ["Rabia", "Panleucopenia", "Rinotraqueítis", "Calicivirus", "Leucemia Felina"],
            "Conejo": ["Mixomatosis", "Enfermedad Hemorrágica Viral", "Pasteurelosis"]
        };

        // Función para inicializar las vacunas según la especie recibida
        function inicializarVacunas() {
            const especie = document.getElementById("especie").value;
            const vacunasSelect = document.getElementById("nombreVacuna");

            // Limpiar opciones previas
            vacunasSelect.innerHTML = "";

            // Agregar nuevas opciones de vacuna según la especie
            if (especie in vacunasPorEspecie) {
                vacunasPorEspecie[especie].forEach(vacuna => {
                    const option = document.createElement("option");
                    option.value = vacuna;
                    option.textContent = vacuna;
                    vacunasSelect.appendChild(option);
                });
            }
        }

        // Llama a la función de inicialización al cargar la página
        window.onload = inicializarVacunas;
    </script>
</head>
<body>
<div class="container">
    <h2>Añadir Vacuna Aplicada</h2>
    <form action="${pageContext.request.contextPath}/AgregarVacunaServlet" method="post">
        <input type="hidden" name="idAnimal" value="${param.idAnimal}">
        
        <!-- Campo oculto para recibir la especie -->
        <input type="hidden" id="especie" name="especie" value="${param.especie}">

        <!-- Selector de vacuna -->
        <div class="mb-3">
            <label for="nombreVacuna" class="form-label">Nombre de la Vacuna</label>
            <select class="form-control" id="nombreVacuna" name="nombreVacuna" required>
                <!-- Las opciones se generarán dinámicamente -->
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Guardar Vacuna</button>
    </form>
</div>
</body>
</html>
