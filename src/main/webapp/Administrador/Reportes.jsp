<%@page import="modelos.Usuarios"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");

    if (usuario == null) {
        // Redirige a la página de login si el usuario no ha iniciado sesión
        request.getRequestDispatcher("/General/login.jsp").forward(request, response);
        return;
    }

    String rol = usuario.getRol();
%>

<%-- Incluir la barra de navegación específica del rol --%>
<jsp:include page="<%= (rol.equals("Administrador") ? "../General/navAdmin.jsp" : 
                     (rol.equals("Empleado") ? "../General/navEmpleado.jsp" : 
                     "../General/navCliente.jsp")) %>" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container my-5">
        <h1 class="text-center mb-4">Reportes</h1>

        <div class="row mb-4">
            <!-- Gráfico de Adopciones por Mes -->
            <div class="col-md-6">
                <h2>Adopciones por Mes</h2>
                <p>Este gráfico muestra el número de adopciones realizadas en cada mes.</p>
                <canvas id="adopcionesPorMesChart"></canvas>
            </div>
            
            <!-- Gráfico de Solicitudes por Estado -->
            <div class="col-md-6">
                <h2>Solicitudes por Estado</h2>
                <p>Este gráfico indica la cantidad de solicitudes de adopción en cada estado.</p>
                <canvas id="solicitudesPorEstadoChart"></canvas>
            </div>
        </div>

        <div class="row mb-4">
            <!-- Gráfico de Animales por Raza -->
            <div class="col-md-6">
                <h2>Animales por Raza</h2>
                <p>Distribución de los animales registrados por diferentes razas.</p>
                <canvas id="animalesPorRazaChart"></canvas>
            </div>
            
            <!-- Gráfico de Animales Registrados por Día -->
            <div class="col-md-6">
                <h2>Animales Registrados por Día</h2>
                <p>Este gráfico de pastel muestra el número de animales registrados en cada día específico.</p>
                <canvas id="animalesPorDiaChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        // Convertir listas de JSON a arrays de JavaScript
        const meses = JSON.parse('${meses}');
        const adopcionesPorMes = JSON.parse('${adopciones}');
        const estados = JSON.parse('${estados}');
        const solicitudesPorEstado = JSON.parse('${solicitudes}');
        const razas = JSON.parse('${razas}');
        const animalesPorRaza = JSON.parse('${animalesPorRaza}');
        const dias = JSON.parse('${dias}');
        const animalesPorDia = JSON.parse('${animalesPorDia}');

        // Gráfico de Adopciones por Mes
        new Chart(document.getElementById('adopcionesPorMesChart'), {
            type: 'bar',
            data: {
                labels: meses,
                datasets: [{
                    label: 'Adopciones por Mes',
                    data: adopcionesPorMes,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // Gráfico de Solicitudes por Estado
        new Chart(document.getElementById('solicitudesPorEstadoChart'), {
            type: 'bar',
            data: {
                labels: estados,
                datasets: [{
                    label: 'Solicitudes por Estado',
                    data: solicitudesPorEstado,
                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // Gráfico de Animales por Raza
        new Chart(document.getElementById('animalesPorRazaChart'), {
            type: 'bar',
            data: {
                labels: razas,
                datasets: [{
                    label: 'Animales por Raza',
                    data: animalesPorRaza,
                    backgroundColor: 'rgba(153, 102, 255, 0.5)',
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // Gráfico de Animales Registrados por Día
        new Chart(document.getElementById('animalesPorDiaChart'), {
            type: 'pie',
            data: {
                labels: dias,
                datasets: [{
                    label: 'Animales Registrados por Día',
                    data: animalesPorDia,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(255, 159, 64, 0.5)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true
            }
        });
    </script>
</body>
</html>
