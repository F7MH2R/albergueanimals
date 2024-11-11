package servlets;

import database.DatabaseConnection;
import modelos.SolicitudesAdopcion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelos.Usuarios;

@WebServlet("/MisAdopcionesServlet")
public class MisAdopcionesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuarios usuario = (Usuarios) session.getAttribute("usuario");
        
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        int idAdoptante = 0;

        // Paso 1: Obtener el id_adoptante utilizando el correo del usuario desde la tabla adoptantes
        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String queryAdoptante = "SELECT id_adoptante FROM adoptantes WHERE correo = ?";
            PreparedStatement stmtAdoptante = conn.prepareStatement(queryAdoptante);
            stmtAdoptante.setString(1, usuario.getCorreo()); // Usa el correo del usuario
            ResultSet rsAdoptante = stmtAdoptante.executeQuery();

            if (rsAdoptante.next()) {
                idAdoptante = rsAdoptante.getInt("id_adoptante");
            } else {
                // Si no encontramos el adoptante, redirigir al usuario o mostrar un mensaje
                response.sendRedirect(request.getContextPath() + "/Cliente/misAdopciones.jsp?error=No se encontraron adopciones");
                return;
            }

            // Paso 2: Obtener las solicitudes de adopción de este adoptante
            List<SolicitudesAdopcion> solicitudesList = new ArrayList<>();
            String querySolicitudes = "SELECT sa.id_solicitud, sa.id_adoptante, sa.id_animal, sa.fecha_solicitud, sa.estado, " +
                           "a.nombre AS nombre_animal, a.especie, a.raza, a.edad, a.estado_salud, " +
                           "ia.imagen AS imagen_animal " +
                           "FROM Solicitudes_Adopcion sa " +
                           "JOIN Animales a ON sa.id_animal = a.id_animal " +
                           "LEFT JOIN Imagenes_Animales ia ON a.id_animal = ia.id_animal " +
                           "WHERE sa.id_adoptante = ?";

            PreparedStatement stmtSolicitudes = conn.prepareStatement(querySolicitudes);
            stmtSolicitudes.setInt(1, idAdoptante);
            ResultSet rsSolicitudes = stmtSolicitudes.executeQuery();

            while (rsSolicitudes.next()) {
                SolicitudesAdopcion solicitud = new SolicitudesAdopcion(
                        rsSolicitudes.getInt("id_solicitud"),
                        rsSolicitudes.getInt("id_adoptante"),
                        rsSolicitudes.getInt("id_animal"),
                        rsSolicitudes.getDate("fecha_solicitud"),
                        rsSolicitudes.getString("estado")
                );
                solicitud.setNombreAnimal(rsSolicitudes.getString("nombre_animal"));
                solicitud.setEspecie(rsSolicitudes.getString("especie"));
                solicitud.setRaza(rsSolicitudes.getString("raza"));
                solicitud.setEdad(rsSolicitudes.getInt("edad"));
                solicitud.setEstadoSalud(rsSolicitudes.getString("estado_salud"));

                // Obtener la imagen en Base64, si está disponible
                String imagenBase64 = rsSolicitudes.getString("imagen_animal");
                solicitud.setImagenUrl(imagenBase64); // Asumimos que `imagen_animal` está en formato Base64

                solicitudesList.add(solicitud);
            }

            // Configurar los atributos para el JSP
            request.setAttribute("solicitudesList", solicitudesList);
            request.getRequestDispatcher("/Cliente/misAdopciones.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
