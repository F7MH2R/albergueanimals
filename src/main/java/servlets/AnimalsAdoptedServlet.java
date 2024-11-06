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

@WebServlet("/AnimalsAdoptedServlet")
public class AnimalsAdoptedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Animales> animalesAprobadosList = new ArrayList<>();
        Map<Integer, ImagenesAnimales> imagenesMap = new HashMap<>();

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Consulta para obtener los datos de los animales con adopciones aprobadas
            String queryAnimalesAprobados = "SELECT * FROM Animales WHERE id_animal IN (SELECT id_animal FROM solicitudes_adopcion WHERE estado = 'Aprobada')";
            PreparedStatement stmtAnimalesAprobados = conn.prepareStatement(queryAnimalesAprobados);
            ResultSet rsAnimalesAprobados = stmtAnimalesAprobados.executeQuery();

            while (rsAnimalesAprobados.next()) {
                Animales animal = new Animales(
                        rsAnimalesAprobados.getInt("id_animal"),
                        rsAnimalesAprobados.getString("nombre"),
                        rsAnimalesAprobados.getString("especie"),
                        rsAnimalesAprobados.getString("raza"),
                        rsAnimalesAprobados.getInt("edad"),
                        rsAnimalesAprobados.getString("estado_salud"),
                        rsAnimalesAprobados.getDate("fecha_ingreso")
                );
                animalesAprobadosList.add(animal);
            }

            // Consulta para obtener las imágenes de los animales aprobados
            String queryImagenes = "SELECT * FROM imagenes_animales WHERE id_animal IN (SELECT id_animal FROM Animales WHERE id_animal IN (SELECT id_animal FROM solicitudes_adopcion WHERE estado = 'Aprobada'))";
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

                if (!imagenesMap.containsKey(idAnimal)) {
                    imagenesMap.put(idAnimal, imagen);
                }
            }

            // Añadir listas a la solicitud
            request.setAttribute("animalesAprobadosList", animalesAprobadosList);
            request.setAttribute("imagenesMap", imagenesMap);

            // Redirigir a la vista para animales adoptados
            request.getRequestDispatcher("/Empleado/Recepcionista/animalesAprobados.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
