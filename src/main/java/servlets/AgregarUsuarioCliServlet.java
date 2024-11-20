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
        // Redirigir al formulario de registro
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

        // Validar campos obligatorios
        if (nombreUsuario == null || contrasena == null || nombreCompleto == null || correo == null ||
            nombreUsuario.isEmpty() || contrasena.isEmpty() || nombreCompleto.isEmpty() || correo.isEmpty()) {
            request.setAttribute("error", "Todos los campos obligatorios deben ser completados.");
            request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
            return;
        }

        // Validar formato del correo electrónico
        if (!correo.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "El correo electrónico no es válido.");
            request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
            return;
        }

        // Validar que el teléfono sea numérico
        if (telefono != null && !telefono.isEmpty() && !telefono.matches("\\d+")) {
            request.setAttribute("error", "El teléfono debe contener solo números.");
            request.getRequestDispatcher("/Cliente/Register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Insertar el cliente en la base de datos
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
                // Redirigir al LoginServlet después del registro exitoso
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
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