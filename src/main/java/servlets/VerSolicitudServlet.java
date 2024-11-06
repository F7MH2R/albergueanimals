package servlets;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelos.Adoptantes;
import modelos.SolicitudesAdopcion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/VerSolicitudServlet")
public class VerSolicitudServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        
        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Obtener los datos de la solicitud y del adoptante
            SolicitudesAdopcion solicitud = obtenerSolicitud(conn, idSolicitud);
            Adoptantes adoptante = obtenerAdoptante(conn, solicitud.getIdAdoptante());

            // Pasar los datos al JSP
            request.setAttribute("solicitud", solicitud);
            request.setAttribute("adoptante", adoptante);
            request.getRequestDispatcher("/Empleado/Recepcionista/VerSolicitud.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("ErrorPage.jsp");
        }
    }

    private SolicitudesAdopcion obtenerSolicitud(Connection conn, int idSolicitud) throws SQLException {
        String query = "SELECT * FROM Solicitudes_Adopcion WHERE id_solicitud = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, idSolicitud);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new SolicitudesAdopcion(rs.getInt("id_solicitud"), rs.getInt("id_adoptante"),
                    rs.getInt("id_animal"), rs.getDate("fecha_solicitud"), rs.getString("estado"));
        }
        return null;
    }

    private Adoptantes obtenerAdoptante(Connection conn, int idAdoptante) throws SQLException {
        String query = "SELECT * FROM Adoptantes WHERE id_adoptante = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, idAdoptante);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new Adoptantes(rs.getInt("id_adoptante"), rs.getString("nombre"),
                    rs.getString("correo"), rs.getString("telefono"), rs.getString("direccion"));
        }
        return null;
    }
}
