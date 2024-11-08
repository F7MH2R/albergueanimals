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

@WebServlet("/AgregarVacunaServlet")
public class AgregarVacunaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        request.setAttribute("idAnimal", idAnimal);
        request.getRequestDispatcher("/Empleado/Veterinario/formularioAgregarVacuna.jsp").forward(request, response);
    }

      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        String nombreVacuna = request.getParameter("nombreVacuna");
        String ml = request.getParameter("ml");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO vacunas (id_animal, nombre_vacuna, fecha_aplicacion, ml) VALUES (?, ?, NOW(), ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, idAnimal);
            stmt.setString(2, nombreVacuna);
            stmt.setString(3, ml);

            stmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/VerHistorialVeterinarioServlet?idAnimal=" + idAnimal);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
