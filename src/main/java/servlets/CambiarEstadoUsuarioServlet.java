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

@WebServlet("/CambiarEstadoUsuarioServlet")
public class CambiarEstadoUsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "UPDATE Usuarios SET estado = NOT estado WHERE id_usuario = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, idUsuario);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirige a GestionUsuariosServlet en lugar de GestionUsuarios.jsp
        response.sendRedirect("GestionUsuariosServlet");
    }
}
