package servlets;

import com.google.gson.Gson;
import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelos.Adoptantes;

@WebServlet("/BuscarClienteServlet")
public class BuscarClienteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        Adoptantes adoptante = null;

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM Adoptantes WHERE nombre = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, nombre);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                adoptante = new Adoptantes(
                    rs.getInt("idAdoptante"),
                    rs.getString("nombre"),
                    rs.getString("correo"),
                    rs.getString("telefono"),
                    rs.getString("direccion")
                );
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            Gson gson = new Gson();
            out.print(gson.toJson(adoptante));
            out.flush();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
