package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelos.Adoptantes;
import database.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/FormularioAdopcionServlet")
public class FormularioAdopcionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));

        // Guardar idAnimal en la sesión
        HttpSession session = request.getSession();
        session.setAttribute("idAnimal", idAnimal);

        // Obtener información del adoptante si el nombre está presente
        String nombreAdoptante = request.getParameter("nombreAdoptante");
        if (nombreAdoptante != null && !nombreAdoptante.isEmpty()) {
            try (Connection conn = DatabaseConnection.initializeDatabase()) {
                String query = "SELECT * FROM Adoptantes WHERE nombre = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, nombreAdoptante);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    Adoptantes adoptante = new Adoptantes(
                            rs.getInt("id_adoptante"),
                            rs.getString("nombre"),
                            rs.getString("correo"),
                            rs.getString("telefono"),
                            rs.getString("direccion")
                    );
                    request.setAttribute("adoptante", adoptante);
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

        // Redirigir al formulario de adopción
        request.getRequestDispatcher("/Empleado/Recepcionista/formularioAdopcion.jsp").forward(request, response);
    }
}
