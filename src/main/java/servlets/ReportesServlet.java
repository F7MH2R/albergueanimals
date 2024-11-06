package servlets;

import com.google.gson.Gson; // Asegúrate de tener la librería Gson para convertir a JSON
import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ReportesServlet")
public class ReportesServlet extends HttpServlet {
    
    private static final Gson gson = new Gson(); // Instancia de Gson para convertir listas a JSON

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Inicializar todas las listas antes del bloque try
        List<Integer> adopcionesPorMes = new ArrayList<>();
        List<String> meses = List.of("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio");

        List<String> estados = new ArrayList<>();
        List<Integer> solicitudesPorEstado = new ArrayList<>();

        List<String> razas = new ArrayList<>();
        List<Integer> animalesPorRaza = new ArrayList<>();

        List<String> dias = new ArrayList<>();
        List<Integer> animalesPorDia = new ArrayList<>();

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Consulta para obtener adopciones por mes
            String queryAdopciones = "SELECT MONTH(fecha_adopcion) AS mes, COUNT(*) AS total FROM Adopciones GROUP BY mes ORDER BY mes";
            PreparedStatement stmtAdopciones = conn.prepareStatement(queryAdopciones);
            ResultSet rsAdopciones = stmtAdopciones.executeQuery();

            while (rsAdopciones.next()) {
                adopcionesPorMes.add(rsAdopciones.getInt("total"));
            }

            // Consulta para estado de solicitudes de adopción
            String querySolicitudes = "SELECT estado, COUNT(*) AS total FROM Solicitudes_Adopcion GROUP BY estado";
            PreparedStatement stmtSolicitudes = conn.prepareStatement(querySolicitudes);
            ResultSet rsSolicitudes = stmtSolicitudes.executeQuery();

            while (rsSolicitudes.next()) {
                estados.add(rsSolicitudes.getString("estado"));
                solicitudesPorEstado.add(rsSolicitudes.getInt("total"));
            }

            // Consulta para razas de animales
            String queryRazas = "SELECT raza, COUNT(*) AS total FROM Animales GROUP BY raza";
            PreparedStatement stmtRazas = conn.prepareStatement(queryRazas);
            ResultSet rsRazas = stmtRazas.executeQuery();

            while (rsRazas.next()) {
                razas.add(rsRazas.getString("raza"));
                animalesPorRaza.add(rsRazas.getInt("total"));
            }

            // Consulta para registro de animales por día
            String queryAnimalesPorDia = "SELECT DATE(fecha_ingreso) AS dia, COUNT(*) AS total FROM Animales GROUP BY dia ORDER BY dia";
            PreparedStatement stmtAnimalesPorDia = conn.prepareStatement(queryAnimalesPorDia);
            ResultSet rsAnimalesPorDia = stmtAnimalesPorDia.executeQuery();

            while (rsAnimalesPorDia.next()) {
                dias.add(rsAnimalesPorDia.getString("dia"));
                animalesPorDia.add(rsAnimalesPorDia.getInt("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Convertir listas a JSON para enviar al JSP
        request.setAttribute("meses", gson.toJson(meses));
        request.setAttribute("adopciones", gson.toJson(adopcionesPorMes));
        request.setAttribute("estados", gson.toJson(estados));
        request.setAttribute("solicitudes", gson.toJson(solicitudesPorEstado));
        request.setAttribute("razas", gson.toJson(razas));
        request.setAttribute("animalesPorRaza", gson.toJson(animalesPorRaza));
        request.setAttribute("dias", gson.toJson(dias));
        request.setAttribute("animalesPorDia", gson.toJson(animalesPorDia));

        // Redireccionar al JSP
        request.getRequestDispatcher("Administrador/Reportes.jsp").forward(request, response);
    }
}
