<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Animal</title>
    <link rel="stylesheet" href="path/to/your/bootstrap.css"> <!-- Ruta a Bootstrap -->
    <script>
        // Lista de especies y razas correspondientes
        const especiesYrazas = {
            "Perro": ["Labrador", "Bulldog", "Pastor Alemán", "Poodle", "Salchicha"],
            "Gato": ["Siames", "Persa", "Angora", "Bengala", "Siberiano"],
            "Conejo": ["Angora", "Holland Lop", "Lionhead", "Rex"]
        };

        // Cambiar razas en función de la especie seleccionada
        function actualizarRazas() {
            const especie = document.getElementById("especie").value;
            const razaSelect = document.getElementById("raza");

            // Limpiar opciones previas
            razaSelect.innerHTML = "";

            // Agregar nuevas opciones de raza
            if (especie in especiesYrazas) {
                especiesYrazas[especie].forEach(raza => {
                    const option = document.createElement("option");
                    option.value = raza;
                    option.textContent = raza;
                    razaSelect.appendChild(option);
                });
            }
        }

        // Previsualización de imágenes
        function previewImage(input, imagePreviewId) {
            const file = input.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById(imagePreviewId).src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }

        // Configurar la fecha de ingreso como la fecha actual
        window.onload = function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById("fechaIngreso").value = today;
        };
    </script>
</head>
<body>
<div class="container">
    <h1 class="my-4">Registro de Nuevo Animal</h1>
    <form action="${pageContext.request.contextPath}/RegistrarAnimalServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre del Animal</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>
        <div class="mb-3">
            <label for="especie" class="form-label">Especie</label>
            <select class="form-control" id="especie" name="especie" onchange="actualizarRazas()" required>
                <option value="">Seleccione una especie</option>
                <option value="Perro">Perro</option>
                <option value="Gato">Gato</option>
                <option value="Conejo">Conejo</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="raza" class="form-label">Raza</label>
            <select class="form-control" id="raza" name="raza" required>
                <option value="">Seleccione una raza</option>
                <!-- Las opciones se actualizarán en función de la especie seleccionada -->
            </select>
        </div>
        <div class="mb-3">
            <label for="edad" class="form-label">Edad</label>
            <input type="number" class="form-control" id="edad" name="edad" min="0" required>
        </div>
        <div class="mb-3">
            <label for="estadoSalud" class="form-label">Estado de Salud</label>
            <select class="form-control" id="estadoSalud" name="estadoSalud" required>
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
            <img id="preview1" src="#" alt="Previsualización de Imagen 1" style="display:none; width: 100px; margin-top: 10px;">
        </div>
        <div class="mb-3">
            <label for="imagen2" class="form-label">Imagen 2</label>
            <input type="file" class="form-control" id="imagen2" name="imagen2" accept="image/*" onchange="previewImage(this, 'preview2')">
            <img id="preview2" src="#" alt="Previsualización de Imagen 2" style="display:none; width: 100px; margin-top: 10px;">
        </div>
        <div class="mb-3">
            <label for="imagen3" class="form-label">Imagen 3</label>
            <input type="file" class="form-control" id="imagen3" name="imagen3" accept="image/*" onchange="previewImage(this, 'preview3')">
            <img id="preview3" src="#" alt="Previsualización de Imagen 3" style="display:none; width: 100px; margin-top: 10px;">
        </div>
        <div class="mb-3">
            <label for="imagen4" class="form-label">Imagen 4</label>
            <input type="file" class="form-control" id="imagen4" name="imagen4" accept="image/*" onchange="previewImage(this, 'preview4')">
            <img id="preview4" src="#" alt="Previsualización de Imagen 4" style="display:none; width: 100px; margin-top: 10px;">
        </div>
        <div class="mb-3">
            <label for="imagen5" class="form-label">Imagen 5</label>
            <input type="file" class="form-control" id="imagen5" name="imagen5" accept="image/*" onchange="previewImage(this, 'preview5')">
            <img id="preview5" src="#" alt="Previsualización de Imagen 5" style="display:none; width: 100px; margin-top: 10px;">
        </div>

        <button type="submit" class="btn btn-primary">Registrar Animal</button>
    </form>
</div>

<script>
    // Mostrar la imagen de previsualización solo cuando haya una imagen seleccionada
    document.querySelectorAll('input[type="file"]').forEach(input => {
        input.addEventListener('change', function() {
            const previewId = this.nextElementSibling.id;
            if (this.files.length > 0) {
                document.getElementById(previewId).style.display = 'block';
            } else {
                document.getElementById(previewId).style.display = 'none';
            }
        });
    });
</script>

</body>
</html>
