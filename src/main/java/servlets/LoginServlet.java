package servlets;

import database.DatabaseConnection;
import modelos.Usuarios;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirige al formulario de inicio de sesión (login.jsp) al acceder mediante GET
        request.getRequestDispatcher("General/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM Usuarios WHERE nombre_usuario = ? AND contrasena = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                boolean estado = resultSet.getBoolean("estado");
                HttpSession session = request.getSession();

                if (estado) {
                    Usuarios usuario = new Usuarios(
                            resultSet.getInt("id_usuario"),
                            resultSet.getString("nombre_usuario"),
                            resultSet.getString("contrasena"),
                            resultSet.getString("nombre_completo"),
                            resultSet.getString("correo"),
                            resultSet.getString("rol"),
                            resultSet.getTimestamp("fecha_registro"),
                            estado,
                            resultSet.getString("puesto"),
                            resultSet.getString("telefono")
                    );

                    session.setAttribute("usuario", usuario);

                    String rol = usuario.getRol();
                    if ("Administrador".equals(rol)) {
                        request.getRequestDispatcher("Administrador/HomeAdmin.jsp").forward(request, response);
                    } else if ("Empleado".equals(rol)) {
                        if (usuario.getPuesto() != null) {
                            redirigirPorPuesto(request, response, usuario.getPuesto());
                        } else {
                            request.setAttribute("error", "Puesto no reconocido para el empleado.");
                            request.getRequestDispatcher("General/login.jsp").forward(request, response);
                        }
                    } else if ("Cliente".equals(rol)) {
                        request.getRequestDispatcher("Cliente/HomeCliente.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Rol no reconocido.");
                        request.getRequestDispatcher("General/login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Usuario inactivo. Contacte al administrador.");
                    request.getRequestDispatcher("General/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos.");
                request.getRequestDispatcher("General/login.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en la conexión a la base de datos.");
            request.getRequestDispatcher("General/login.jsp").forward(request, response);
        }
    }

    private void redirigirPorPuesto(HttpServletRequest request, HttpServletResponse response, String puesto) throws ServletException, IOException {
        String destino;
        switch (puesto) {
            case "Veterinario":
                destino = "Empleado/Veterinario/HomeVeterinario.jsp";
                break;
            case "Recepcionista":
                destino = "Empleado/Recepcionista/HomeRecepcionista.jsp";
                break;
            case "Cuidador":
                destino = "Empleado/Recepcionista/HomeRecepcionista.jsp";
                break;
            case "Auxiliar":
                destino = "Empleado/Recepcionista/HomeRecepcionista.jsp";
                break;
            case "Asistente":
                destino = "Empleado/Recepcionista/HomeRecepcionista.jsp";
                break;
            default:
                throw new IllegalArgumentException("Puesto no reconocido: " + puesto);
        }
        request.getRequestDispatcher(destino).forward(request, response);
    }
}
