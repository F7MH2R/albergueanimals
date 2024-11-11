package servlets;

import database.DatabaseConnection;
import modelos.Animales;
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

@WebServlet("/FormularioAdopcionCliServlet")
public class FormularioAdopcionCliServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idAnimalParam = request.getParameter("idAnimal");
        HttpSession session = request.getSession();
        Usuarios cliente = (Usuarios) session.getAttribute("usuario");

        if (idAnimalParam != null && cliente != null) {
            try (Connection conn = DatabaseConnection.initializeDatabase()) {
                int idAnimal = Integer.parseInt(idAnimalParam);

                // Obtener los datos del animal
                String queryAnimal = "SELECT * FROM Animales WHERE id_animal = ?";
                PreparedStatement stmtAnimal = conn.prepareStatement(queryAnimal);
                stmtAnimal.setInt(1, idAnimal);
                ResultSet rsAnimal = stmtAnimal.executeQuery();

                Animales animal = null;
                if (rsAnimal.next()) {
                    animal = new Animales(
                            rsAnimal.getInt("id_animal"),
                            rsAnimal.getString("nombre"),
                            rsAnimal.getString("especie"),
                            rsAnimal.getString("raza"),
                            rsAnimal.getInt("edad"),
                            rsAnimal.getString("estado_salud"),
                            rsAnimal.getDate("fecha_ingreso")
                    );
                }

                // Pasar los datos del cliente y del animal al JSP
                request.setAttribute("animal", animal);
                request.setAttribute("cliente", cliente); // Pasamos el cliente al JSP

                // Redirigir al formulario de adopción
                request.getRequestDispatcher("Cliente/formularioAdopcion.jsp").forward(request, response);

            } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
