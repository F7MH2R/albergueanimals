package servlets;

import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import modelos.ImagenesAnimales;

@WebServlet("/ActualizarAnimalServlet")
@MultipartConfig
public class ActualizarAnimalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        System.out.println("idAnimal recibido: " + idAnimal);  // Mensaje de depuración

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT nombre, especie, raza, edad, estado_salud, fecha_ingreso FROM Animales WHERE id_animal = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, idAnimal);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("idAnimal", idAnimal);
                request.setAttribute("nombre", rs.getString("nombre"));
                request.setAttribute("especie", rs.getString("especie"));
                request.setAttribute("raza", rs.getString("raza"));
                request.setAttribute("edad", rs.getInt("edad"));
                request.setAttribute("estadoSalud", rs.getString("estado_salud"));
                request.setAttribute("fechaIngreso", rs.getDate("fecha_ingreso").toString());
            } else {
                System.out.println("No se encontró el animal con id: " + idAnimal);  // Mensaje de depuración
            }

            String queryImagenes = "SELECT id_imagen, id_animal, nombre_imagen, tipo_imagen, imagen, fecha_subida FROM imagenes_animales WHERE id_animal = ?";
            PreparedStatement stmtImagenes = conn.prepareStatement(queryImagenes);
            stmtImagenes.setInt(1, idAnimal);
            ResultSet rsImagenes = stmtImagenes.executeQuery();

            List<ImagenesAnimales> imagenesList = new ArrayList<>();
            while (rsImagenes.next()) {
                ImagenesAnimales imagen = new ImagenesAnimales(
                        rsImagenes.getInt("id_imagen"),
                        rsImagenes.getInt("id_animal"),
                        rsImagenes.getString("nombre_imagen"),
                        rsImagenes.getString("tipo_imagen"),
                        rsImagenes.getString("imagen"),
                        rsImagenes.getDate("fecha_subida")
                );
                imagenesList.add(imagen);
            }
            request.setAttribute("imagenesList", imagenesList);
            System.out.println("Imágenes cargadas: " + imagenesList.size());  // Mensaje de depuración

            request.getRequestDispatcher("/Empleado/Recepcionista/FormularioActualizarAnimal.jsp").forward(request, response);
            System.out.println("Redirección al JSP realizada con éxito.");  // Mensaje de depuración
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));
        String nombre = request.getParameter("nombre");
        String especie = request.getParameter("especie");
        String raza = request.getParameter("raza");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String estadoSalud = request.getParameter("estadoSalud");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Actualizar la información del animal en la base de datos
            String updateAnimalQuery = "UPDATE Animales SET nombre = ?, especie = ?, raza = ?, edad = ?, estado_salud = ? WHERE id_animal = ?";
            PreparedStatement stmtAnimal = conn.prepareStatement(updateAnimalQuery);
            stmtAnimal.setString(1, nombre);
            stmtAnimal.setString(2, especie);
            stmtAnimal.setString(3, raza);
            stmtAnimal.setInt(4, edad);
            stmtAnimal.setString(5, estadoSalud);
            stmtAnimal.setInt(6, idAnimal);
            stmtAnimal.executeUpdate();

            // Eliminar todas las imágenes existentes del animal antes de insertar las nuevas
            String deleteImagesQuery = "DELETE FROM imagenes_animales WHERE id_animal = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteImagesQuery);
            deleteStmt.setInt(1, idAnimal);
            deleteStmt.executeUpdate();

            // Insertar las nuevas imágenes del formulario
            String insertImageQuery = "INSERT INTO imagenes_animales (id_animal, nombre_imagen, tipo_imagen, imagen, fecha_subida) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmtImagen = conn.prepareStatement(insertImageQuery);

            for (int i = 1; i <= 5; i++) {
                Part imagenPart = request.getPart("imagen" + i);

                // Si el campo de la imagen tiene contenido, entonces procesarlo
                if (imagenPart != null && imagenPart.getSize() > 0) {
                    String nombreImagen = "imagen" + i;
                    String tipoImagen = imagenPart.getContentType();
                    byte[] imagenBytes = imagenPart.getInputStream().readAllBytes();
                    String imagenBase64 = Base64.getEncoder().encodeToString(imagenBytes);

                    stmtImagen.setInt(1, idAnimal);
                    stmtImagen.setString(2, nombreImagen);
                    stmtImagen.setString(3, tipoImagen);
                    stmtImagen.setString(4, imagenBase64);
                    stmtImagen.setDate(5, new java.sql.Date(new Date().getTime()));
                    stmtImagen.executeUpdate();
                }
            }

            response.sendRedirect(request.getContextPath() + "/General/SuccessPage.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
        }
    }
}
