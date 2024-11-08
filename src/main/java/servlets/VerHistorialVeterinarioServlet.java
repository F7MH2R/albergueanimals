package servlets;

import database.DatabaseConnection;
import modelos.Animales;
import modelos.ImagenesAnimales;
import modelos.HistorialMedico;
import modelos.SolicitudesAdopcion;
import modelos.Vacunas;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/VerHistorialVeterinarioServlet")
public class VerHistorialVeterinarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        Animales animal = null;
        List<ImagenesAnimales> imagenesList = new ArrayList<>();
        List<HistorialMedico> historialMedicoList = new ArrayList<>();
        List<SolicitudesAdopcion> solicitudesAdopcionList = new ArrayList<>();
        List<Vacunas> vacunasList = new ArrayList<>();

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Obtener datos del animal
            String queryAnimal = "SELECT * FROM Animales WHERE id_animal = ?";
            PreparedStatement stmtAnimal = conn.prepareStatement(queryAnimal);
            stmtAnimal.setInt(1, idAnimal);
            ResultSet rsAnimal = stmtAnimal.executeQuery();

            if (rsAnimal.next()) {
                animal = new Animales(
                        rsAnimal.getInt("id_animal"),
                        rsAnimal.getString("nombre"),
                        rsAnimal.getString("especie"),
                        rsAnimal.getString("raza"),
                        rsAnimal.getInt("edad"),
                        rsAnimal.getString("estado_salud"),
                        rsAnimal.getDate("fecha_ingreso")
                );
            }

            // Obtener imágenes del animal
            String queryImagenes = "SELECT * FROM Imagenes_Animales WHERE id_animal = ?";
            PreparedStatement stmtImagenes = conn.prepareStatement(queryImagenes);
            stmtImagenes.setInt(1, idAnimal);
            ResultSet rsImagenes = stmtImagenes.executeQuery();

            while (rsImagenes.next()) {
                ImagenesAnimales imagen = new ImagenesAnimales(
                        rsImagenes.getInt("id_imagen"),
                        rsImagenes.getInt("id_animal"),
                        rsImagenes.getString("nombre_imagen"),
                        rsImagenes.getString("tipo_imagen"),
                        rsImagenes.getString("imagen"),
                        rsImagenes.getDate("fecha_subida")
                );
                imagenesList.add(imagen);
            }

            // Obtener historial médico del animal
            String queryHistorialMedico = "SELECT * FROM Historial_Medico WHERE id_animal = ?";
            PreparedStatement stmtHistorial = conn.prepareStatement(queryHistorialMedico);
            stmtHistorial.setInt(1, idAnimal);
            ResultSet rsHistorial = stmtHistorial.executeQuery();

            while (rsHistorial.next()) {
                HistorialMedico historial = new HistorialMedico(
                        rsHistorial.getInt("id_historial"),
                        rsHistorial.getInt("id_animal"),
                        rsHistorial.getDate("fecha"),
                        rsHistorial.getString("tratamiento"),
                        rsHistorial.getString("descripcion")
                );
                historialMedicoList.add(historial);
            }

            // Obtener solicitudes de adopción del animal
            String querySolicitudes = "SELECT * FROM Solicitudes_Adopcion WHERE id_animal = ?";
            PreparedStatement stmtSolicitudes = conn.prepareStatement(querySolicitudes);
            stmtSolicitudes.setInt(1, idAnimal);
            ResultSet rsSolicitudes = stmtSolicitudes.executeQuery();

            while (rsSolicitudes.next()) {
                SolicitudesAdopcion solicitud = new SolicitudesAdopcion(
                        rsSolicitudes.getInt("id_solicitud"),
                        rsSolicitudes.getInt("id_adoptante"),
                        rsSolicitudes.getInt("id_animal"),
                        rsSolicitudes.getDate("fecha_solicitud"),
                        rsSolicitudes.getString("estado")
                );
                solicitudesAdopcionList.add(solicitud);
            }

            // Obtener vacunas del animal
            String queryVacunas = "SELECT * FROM Vacunas WHERE id_animal = ?";
            PreparedStatement stmtVacunas = conn.prepareStatement(queryVacunas);
            stmtVacunas.setInt(1, idAnimal);
            ResultSet rsVacunas = stmtVacunas.executeQuery();

            while (rsVacunas.next()) {
                Vacunas vacuna = new Vacunas(
                        rsVacunas.getInt("id_vacuna"),
                        rsVacunas.getInt("id_animal"),
                        rsVacunas.getString("nombre_vacuna"),
                        rsVacunas.getDate("fecha_aplicacion")
                );
                vacunasList.add(vacuna);
            }

            // Añadir atributos a la solicitud
            request.setAttribute("animal", animal);
            request.setAttribute("imagenesList", imagenesList);
            request.setAttribute("historialMedicoList", historialMedicoList);
            request.setAttribute("solicitudesAdopcionList", solicitudesAdopcionList);
            request.setAttribute("vacunasList", vacunasList);

            // Redirigir a la vista de detalles del animal para el veterinario
            request.getRequestDispatcher("/Empleado/Veterinario/detalleAnimal.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
