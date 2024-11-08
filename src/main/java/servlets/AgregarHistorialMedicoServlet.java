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
import java.util.Date;

@WebServlet("/AgregarHistorialMedicoServlet")
public class AgregarHistorialMedicoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        request.setAttribute("idAnimal", idAnimal);
        request.getRequestDispatcher("/Empleado/Veterinario/formularioAgregarHistorial.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        String tratamiento = request.getParameter("tratamiento");
        String descripcion = request.getParameter("descripcion");
        Date fecha = new Date(); // Fecha actual

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO Historial_Medico (id_animal, fecha, tratamiento, descripcion) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, idAnimal);
            stmt.setDate(2, new java.sql.Date(fecha.getTime()));
            stmt.setString(3, tratamiento);
            stmt.setString(4, descripcion);
            stmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/VerHistorialVeterinarioServlet?idAnimal=" + idAnimal);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
