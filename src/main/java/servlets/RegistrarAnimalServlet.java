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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

@WebServlet("/RegistrarAnimalServlet")
@MultipartConfig
public class RegistrarAnimalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirige al formulario de registro en la ubicación correcta
        request.getRequestDispatcher("/Empleado/Recepcionista/FormularioRegistroAnimal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String especie = request.getParameter("especie");
        String raza = request.getParameter("raza");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String estadoSalud = request.getParameter("estadoSalud");
        Date fechaIngreso = java.sql.Date.valueOf(request.getParameter("fechaIngreso"));

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Insertar el animal en la base de datos
            String queryAnimal = "INSERT INTO Animales (nombre, especie, raza, edad, estado_salud, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmtAnimal = conn.prepareStatement(queryAnimal, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtAnimal.setString(1, nombre);
            stmtAnimal.setString(2, especie);
            stmtAnimal.setString(3, raza);
            stmtAnimal.setInt(4, edad);
            stmtAnimal.setString(5, estadoSalud);
            stmtAnimal.setDate(6, new java.sql.Date(fechaIngreso.getTime()));
            stmtAnimal.executeUpdate();

            // Obtener el ID generado para el animal
            int idAnimal = 0;
            var rs = stmtAnimal.getGeneratedKeys();
            if (rs.next()) {
                idAnimal = rs.getInt(1);
            }

            // Lista de las imágenes cargadas
            List<Part> imagenesPart = new ArrayList<>();
            imagenesPart.add(request.getPart("imagen1"));
            imagenesPart.add(request.getPart("imagen2"));
            imagenesPart.add(request.getPart("imagen3"));
            imagenesPart.add(request.getPart("imagen4"));
            imagenesPart.add(request.getPart("imagen5"));

            // Insertar cada imagen en la base de datos
// Cambia esta línea de acuerdo con el nombre correcto de la tabla
            String queryImagen = "INSERT INTO imagenes_animales (id_animal, nombre_imagen, tipo_imagen, imagen, fecha_subida) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmtImagen = conn.prepareStatement(queryImagen);
            for (Part imagenPart : imagenesPart) {
                if (imagenPart != null && imagenPart.getSize() > 0) {
                    String nombreImagen = imagenPart.getSubmittedFileName();
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

            request.getRequestDispatcher("/General/SuccessPage.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/General/ErrorPage.jsp").forward(request, response);
        }
    }
}
