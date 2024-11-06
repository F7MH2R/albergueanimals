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

@WebServlet("/CambiarEstadoEmpleadoServlet")
public class CambiarEstadoEmpleadoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Cambiar el estado del empleado
            String query = "UPDATE empleados SET estado = NOT estado WHERE id_empleado = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, idEmpleado);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirige de nuevo a la lista de empleados
        response.sendRedirect("EmpleadosServlet");
    }
}
