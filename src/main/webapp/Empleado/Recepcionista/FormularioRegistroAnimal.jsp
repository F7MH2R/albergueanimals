<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <style>
        /* Estilos personalizados */
        body {
            font-family: Arial, sans-serif;
            background-color: #F0EEED;
            margin: 0;
            padding: 0;
        }

        .containerRegAnimal {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
        }

        .titleRegAnimal {
            font-size: 32px;
            color: #4A665E;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-label {
            font-size: 18px;
            color: #4A665E;
            font-weight: bold;
        }

        .form-control, .form-select {
            font-size: 16px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            width: 100%;
        }

        .form-control:focus, .form-select:focus {
            border-color: #4A665E;
            box-shadow: 0 0 5px rgba(74, 102, 94, 0.5);
        }

        .preview-img {
            display: none;
            width: 100px;
            height: auto;
            margin-top: 10px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btnRegAnimal {
            background-color: #4A665E;
            color: #ffffff;
            font-size: 18px;
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            transition: background-color 0.3s;
        }

        .btnRegAnimal:hover {
            background-color: #333;
        }

        /* Espaciado entre los elementos del formulario */
        .mb-3 {
            margin-bottom: 20px;
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

        function previewImage(input, imagePreviewId) {
            const file = input.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById(imagePreviewId).src = e.target.result;
                    document.getElementById(imagePreviewId).style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        }

        window.onload = function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById("fechaIngreso").value = today;
        };
    </script>
</head>
<body>
    <%-- Incluir la barra de navegación para el recepcionista --%>
    <jsp:include page="navbarRecepcionista.jsp" />

    <div class="containerRegAnimal">
        <h1 class="titleRegAnimal">Registro de Nuevo Animal</h1>
        
        <form action="${pageContext.request.contextPath}/RegistrarAnimalServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Animal</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>

            <div class="mb-3">
                <label for="especie" class="form-label">Especie</label>
                <select class="form-select" id="especie" name="especie" onchange="actualizarRazas()" required>
                    <option value="">Seleccione una especie</option>
                    <option value="Perro">Perro</option>
                    <option value="Gato">Gato</option>
                    <option value="Conejo">Conejo</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="raza" class="form-label">Raza</label>
                <select class="form-select" id="raza" name="raza" required>
                    <option value="">Seleccione una raza</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="edad" class="form-label">Edad</label>
                <input type="number" class="form-control" id="edad" name="edad" min="0" required>
            </div>

            <div class="mb-3">
                <label for="estadoSalud" class="form-label">Estado de Salud</label>
                <select class="form-select" id="estadoSalud" name="estadoSalud" required>
                    <option value="Saludable">Saludable</option>
                    <option value="En recuperación">En recuperación</option>
                    <option value="En tratamiento">En tratamiento</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="fechaIngreso" class="form-label">Fecha de Ingreso</label>
                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" readonly required>
            </div>

            <!-- Campos para cargar imágenes con previsualización -->
            <div class="mb-3">
                <label for="imagen1" class="form-label">Imagen 1</label>
                <input type="file" class="form-control" id="imagen1" name="imagen1" accept="image/*" onchange="previewImage(this, 'preview1')">
                <img id="preview1" class="preview-img" src="#" alt="Previsualización de Imagen 1">
            </div>

            <button type="submit" class="btn btnRegAnimal">Registrar Animal</button>
        </form>
    </div>
</body>
</html>
