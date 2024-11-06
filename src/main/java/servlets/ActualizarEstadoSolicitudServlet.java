package servlets;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ActualizarEstadoSolicitudServlet")
public class ActualizarEstadoSolicitudServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        String nuevoEstado = request.getParameter("estado");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Actualizar el estado de la solicitud
            String updateQuery = "UPDATE solicitudes_adopcion SET estado = ? WHERE id_solicitud = ?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, nuevoEstado);
            stmt.setInt(2, idSolicitud);
            stmt.executeUpdate();

            // Si el estado es "Aprobada", registrar en la tabla adopciones
            if ("Aprobada".equals(nuevoEstado)) {
                String insertAdopcionQuery = "INSERT INTO adopciones (id_animal, id_adoptante, fecha_adopcion) " +
                                             "SELECT id_animal, id_adoptante, CURDATE() FROM solicitudes_adopcion WHERE id_solicitud = ?";
                PreparedStatement insertStmt = conn.prepareStatement(insertAdopcionQuery);
                insertStmt.setInt(1, idSolicitud);
                insertStmt.executeUpdate();
            }

            // Redirigir a la página de lista de animales adoptados
            response.sendRedirect(request.getContextPath() + "/AnimalsAdoptedServlet");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
