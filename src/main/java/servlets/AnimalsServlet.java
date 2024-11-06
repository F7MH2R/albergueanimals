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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AnimalsServlet")
public class AnimalsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Animales> animalesList = new ArrayList<>();
        Map<Integer, ImagenesAnimales> imagenesMap = new HashMap<>();

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Consulta para obtener los datos de los animales sin adopciones aprobadas
            String queryAnimales = "SELECT * FROM Animales WHERE id_animal NOT IN (SELECT id_animal FROM solicitudes_adopcion WHERE estado = 'Aprobada')";
            PreparedStatement stmtAnimales = conn.prepareStatement(queryAnimales);
            ResultSet rsAnimales = stmtAnimales.executeQuery();

            while (rsAnimales.next()) {
                Animales animal = new Animales(
                        rsAnimales.getInt("id_animal"),
                        rsAnimales.getString("nombre"),
                        rsAnimales.getString("especie"),
                        rsAnimales.getString("raza"),
                        rsAnimales.getInt("edad"),
                        rsAnimales.getString("estado_salud"),
                        rsAnimales.getDate("fecha_ingreso")
                );
                animalesList.add(animal);
            }

            // Consulta para obtener las imágenes de los animales
            String queryImagenes = "SELECT * FROM imagenes_animales WHERE id_animal IN (SELECT id_animal FROM Animales)";
            PreparedStatement stmtImagenes = conn.prepareStatement(queryImagenes);
            ResultSet rsImagenes = stmtImagenes.executeQuery();

            while (rsImagenes.next()) {
                int idAnimal = rsImagenes.getInt("id_animal");
                ImagenesAnimales imagen = new ImagenesAnimales(
                        rsImagenes.getInt("id_imagen"),
                        idAnimal,
                        rsImagenes.getString("nombre_imagen"),
                        rsImagenes.getString("tipo_imagen"),
                        rsImagenes.getString("imagen"),
                        rsImagenes.getDate("fecha_subida")
                );

                // Solo guardar una imagen por animal (por simplificación)
                if (!imagenesMap.containsKey(idAnimal)) {
                    imagenesMap.put(idAnimal, imagen);
                }
            }

            // Añadir listas a la solicitud
            request.setAttribute("animalesList", animalesList);
            request.setAttribute("imagenesMap", imagenesMap);

            // Redirigir a la vista
            request.getRequestDispatcher("/Empleado/Recepcionista/animals.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
        System.out.println("Número de animales encontrados: " + animalesList.size());
        System.out.println("Número de imágenes asociadas: " + imagenesMap.size());
    }
}
