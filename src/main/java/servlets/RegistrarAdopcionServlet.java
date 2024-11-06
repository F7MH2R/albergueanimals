package servlets;

import database.DatabaseConnection;
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
import java.time.LocalDate;

@WebServlet("/RegistrarAdopcionServlet")
public class RegistrarAdopcionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idAnimal = (int) session.getAttribute("idAnimal");

        String nombreAdoptante = request.getParameter("nombreAdoptante");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Verificar si el adoptante ya existe o insertarlo
            int idAdoptante = obtenerOInsertarAdoptante(conn, nombreAdoptante, correo, telefono, direccion);

            // Insertar la solicitud de adopción
            String querySolicitud = "INSERT INTO Solicitudes_Adopcion (id_adoptante, id_animal, fecha_solicitud, estado) VALUES (?, ?, ?, ?)";
            PreparedStatement stmtSolicitud = conn.prepareStatement(querySolicitud);
            stmtSolicitud.setInt(1, idAdoptante);
            stmtSolicitud.setInt(2, idAnimal);
            stmtSolicitud.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
            stmtSolicitud.setString(4, "Pendiente");
            stmtSolicitud.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/General/ConfirmacionAdopcion.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ErrorPage.jsp");
        }
    }

    private int obtenerOInsertarAdoptante(Connection conn, String nombre, String correo, String telefono, String direccion) throws SQLException {
        String querySelect = "SELECT id_adoptante FROM Adoptantes WHERE nombre = ?";
        PreparedStatement stmtSelect = conn.prepareStatement(querySelect);
        stmtSelect.setString(1, nombre);
        ResultSet rs = stmtSelect.executeQuery();

        if (rs.next()) {
            return rs.getInt("id_adoptante");
        } else {
            String queryInsert = "INSERT INTO Adoptantes (nombre, correo, telefono, direccion) VALUES (?, ?, ?, ?)";
            PreparedStatement stmtInsert = conn.prepareStatement(queryInsert, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtInsert.setString(1, nombre);
            stmtInsert.setString(2, correo);
            stmtInsert.setString(3, telefono);
            stmtInsert.setString(4, direccion);
            stmtInsert.executeUpdate();

            ResultSet generatedKeys = stmtInsert.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Error al insertar adoptante.");
            }
        }
    }
}
