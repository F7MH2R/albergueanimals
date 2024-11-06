package servlets;

import database.DatabaseConnection;
import modelos.Usuarios;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirige al formulario de agregar usuario
        request.getRequestDispatcher("Administrador/AgregarUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreUsuario = request.getParameter("nombreUsuario");
        String contrasena = request.getParameter("contrasena");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        String telefono = request.getParameter("telefono");

        // Solo obtener los campos de puesto si el rol es "Empleado"
        String puesto = null;
        if ("Empleado".equals(rol)) {
            puesto = request.getParameter("puesto");
        }

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO Usuarios (nombre_usuario, contrasena, nombre_completo, correo, rol, telefono, puesto) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, nombreUsuario);
            statement.setString(2, contrasena);
            statement.setString(3, nombreCompleto);
            statement.setString(4, correo);
            statement.setString(5, rol);
            statement.setString(6, telefono);
            statement.setString(7, puesto); // Este valor será null si el rol no es "Empleado"
            statement.executeUpdate();

            response.sendRedirect("GestionUsuariosServlet");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al agregar el usuario.");
            request.getRequestDispatcher("Administrador/AgregarUsuario.jsp").forward(request, response);
        }
    }
}
