package servlets;

import database.DatabaseConnection;
import modelos.Animales;
import modelos.ImagenesAnimales;
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

@WebServlet("/DetalleAnimalServlet")
public class DetalleAnimalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el id del animal desde los parámetros de la URL
        String idAnimalParam = request.getParameter("idAnimal");

        if (idAnimalParam != null) {
            try (Connection conn = DatabaseConnection.initializeDatabase()) {
                int idAnimal = Integer.parseInt(idAnimalParam);

                // Consulta para obtener los detalles del animal
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

                // Consulta para obtener la imagen del animal (si existe)
                String queryImagen = "SELECT * FROM imagenes_animales WHERE id_animal = ?";
                PreparedStatement stmtImagen = conn.prepareStatement(queryImagen);
                stmtImagen.setInt(1, idAnimal);
                ResultSet rsImagen = stmtImagen.executeQuery();

                ImagenesAnimales imagen = null;
                if (rsImagen.next()) {
                    imagen = new ImagenesAnimales(
                            rsImagen.getInt("id_imagen"),
                            idAnimal,
                            rsImagen.getString("nombre_imagen"),
                            rsImagen.getString("tipo_imagen"),
                            rsImagen.getString("imagen"),
                            rsImagen.getDate("fecha_subida")
                    );
                }

                // Pasar los datos del animal y la imagen al JSP
                request.setAttribute("animal", animal);
                request.setAttribute("imagen", imagen);

                // Redirigir a detalleAnimal.jsp
                request.getRequestDispatcher("Cliente/detalleAnimal.jsp").forward(request, response);

            } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
