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
import java.sql.ResultSet;

@WebServlet("/EditarUsuarioServlet")
public class EditarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id"));
        Usuarios usuario = null;

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM Usuarios WHERE id_usuario = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, idUsuario);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                usuario = new Usuarios(
                    resultSet.getInt("id_usuario"),
                    resultSet.getString("nombre_usuario"),
                    resultSet.getString("contrasena"),
                    resultSet.getString("nombre_completo"),
                    resultSet.getString("correo"),
                    resultSet.getString("rol"),
                    resultSet.getTimestamp("fecha_registro"),
                    resultSet.getBoolean("estado"),
                    resultSet.getString("puesto"),   // Agrega el puesto del usuario
                    resultSet.getString("telefono")  // Agrega el teléfono del usuario
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("Administrador/EditarUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        String nombreUsuario = request.getParameter("nombreUsuario");
        String contrasena = request.getParameter("contrasena");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correo = request.getParameter("correo");
        String rol = request.getParameter("rol");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
        
        // Si el rol es "Empleado", obtener el puesto y teléfono
        String puesto = "Empleado".equals(rol) ? request.getParameter("puesto") : null;
        String telefono = request.getParameter("telefono");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "UPDATE Usuarios SET nombre_usuario=?, contrasena=?, nombre_completo=?, correo=?, rol=?, estado=?, puesto=?, telefono=? WHERE id_usuario=?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, nombreUsuario);
            statement.setString(2, contrasena);
            statement.setString(3, nombreCompleto);
            statement.setString(4, correo);
            statement.setString(5, rol);
            statement.setBoolean(6, estado);
            statement.setString(7, puesto);   // Guardar el puesto solo si el rol es "Empleado"
            statement.setString(8, telefono); // Guardar el teléfono para todos los roles
            statement.setInt(9, idUsuario);
            statement.executeUpdate();

            response.sendRedirect("GestionUsuariosServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar el usuario.");
            request.getRequestDispatcher("Administrador/EditarUsuario.jsp").forward(request, response);
        }
    }
}
