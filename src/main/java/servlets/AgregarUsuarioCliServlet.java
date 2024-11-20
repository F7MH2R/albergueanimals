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

@WebServlet("/AgregarUsuarioCliServlet")
public class AgregarUsuarioCliServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Renderiza el formulario de registro (Register.jsp)
        request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario
        String nombreUsuario = request.getParameter("nombreUsuario");
        String contrasena = request.getParameter("contrasena");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");

        // Validar que los campos requeridos no estén vacíos
        if (nombreUsuario == null || contrasena == null || nombreCompleto == null || correo == null
                || nombreUsuario.isEmpty() || contrasena.isEmpty() || nombreCompleto.isEmpty() || correo.isEmpty()) {
            request.setAttribute("error", "Todos los campos obligatorios deben ser completados.");
            request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Consulta SQL para insertar el usuario
            String sql = "INSERT INTO usuarios (nombre_usuario, contrasena, nombre_completo, correo, telefono, rol, estado, fecha_registro) "
                       + "VALUES (?, ?, ?, ?, ?, 'Cliente', 1, NOW())";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombreUsuario);
            stmt.setString(2, contrasena);
            stmt.setString(3, nombreCompleto);
            stmt.setString(4, correo);
            stmt.setString(5, telefono);

            // Ejecutar la consulta
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirigir a una página de éxito
                response.sendRedirect(request.getContextPath() + "/Cliente/ConfirmacionAdopcion.jsp");
            } else {
                // Enviar un mensaje de error si no se pudo insertar el usuario
                request.setAttribute("error", "No se pudo registrar el usuario. Intenta nuevamente.");
                request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error al registrar el usuario: " + e.getMessage());
            request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
        }
    }
}
