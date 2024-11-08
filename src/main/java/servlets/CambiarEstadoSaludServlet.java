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

@WebServlet("/CambiarEstadoSaludServlet")
public class CambiarEstadoSaludServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        String nuevoEstadoSalud = request.getParameter("nuevoEstadoSalud");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "UPDATE Animales SET estado_salud = ? WHERE id_animal = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, nuevoEstadoSalud);
            stmt.setInt(2, idAnimal);
            stmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/VerHistorialVeterinarioServlet?idAnimal=" + idAnimal);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
