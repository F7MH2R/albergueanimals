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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GestionUsuariosServlet")
public class GestionUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuarios> listaUsuarios = new ArrayList<>();
        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM Usuarios";
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Usuarios usuario = new Usuarios(
                        resultSet.getInt("id_usuario"),
                        resultSet.getString("nombre_usuario"),
                        resultSet.getString("contrasena"),
                        resultSet.getString("nombre_completo"),
                        resultSet.getString("correo"),
                        resultSet.getString("rol"),
                        resultSet.getTimestamp("fecha_registro"),
                        resultSet.getBoolean("estado"),
                        resultSet.getString("puesto"),
                        resultSet.getString("telefono")
                );
                listaUsuarios.add(usuario);
            }
            
            request.setAttribute("listaUsuarios", listaUsuarios);
            request.getRequestDispatcher("/Administrador/GestionUsuarios.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        boolean nuevoEstado = Boolean.parseBoolean(request.getParameter("nuevoEstado"));

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "UPDATE Usuarios SET estado = ? WHERE id_usuario = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setBoolean(1, nuevoEstado);
            statement.setInt(2, idUsuario);
            statement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/GestionUsuariosServlet");
    }
}
