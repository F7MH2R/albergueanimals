package servlets;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelos.Adoptantes;
import modelos.Animales;
import modelos.ImagenesAnimales;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet("/GenerarComprobanteServlet")
public class GenerarComprobanteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idAnimal = Integer.parseInt(request.getParameter("idAnimal"));

        // Configuración de la respuesta para descargar el PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=comprobante_adopcion.pdf");

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            // Obtener los datos del animal y del adoptante
            Animales animal = obtenerDatosAnimal(conn, idAnimal);
            Adoptantes adoptante = obtenerDatosAdoptante(conn, idAnimal);
            ImagenesAnimales imagenAnimal = obtenerImagenPorIdAnimal(conn, idAnimal); // Obtener la imagen asociada al animal

            // Crear el documento PDF
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            // Título
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Paragraph title = new Paragraph("Comprobante de Adopción", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Información del adoptante
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);

            document.add(new Paragraph("\nInformación del Adoptante:", headerFont));
            document.add(new Paragraph("Nombre: " + adoptante.getNombre(), normalFont));
            document.add(new Paragraph("Correo: " + adoptante.getCorreo(), normalFont));
            document.add(new Paragraph("Teléfono: " + adoptante.getTelefono(), normalFont));
            document.add(new Paragraph("Dirección: " + adoptante.getDireccion(), normalFont));

            // Espacio
            document.add(new Paragraph("\nInformación del Animal Adoptado:", headerFont));
            document.add(new Paragraph("Nombre: " + animal.getNombre(), normalFont));
            document.add(new Paragraph("Especie: " + animal.getEspecie(), normalFont));
            document.add(new Paragraph("Raza: " + animal.getRaza(), normalFont));
            document.add(new Paragraph("Edad: " + animal.getEdad() + " años", normalFont));
            document.add(new Paragraph("Estado de Salud: " + animal.getEstadoSalud(), normalFont));
            document.add(new Paragraph("Fecha de Ingreso: " + animal.getFechaIngreso(), normalFont));

            // Agregar imagen del animal, si está disponible
            if (imagenAnimal != null && imagenAnimal.getImagen() != null) {
                try {
                    Image image = Image.getInstance(Base64.getDecoder().decode(imagenAnimal.getImagen()));
                    image.scaleToFit(150, 150);
                    image.setAlignment(Element.ALIGN_CENTER);
                    document.add(new Paragraph("\n"));
                    document.add(image);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            document.close();
        } catch (SQLException | ClassNotFoundException | DocumentException e) {
            e.printStackTrace();
        }
    }

    private Animales obtenerDatosAnimal(Connection conn, int idAnimal) throws SQLException {
        String query = "SELECT * FROM Animales WHERE id_animal = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, idAnimal);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Animales animal = new Animales();
            animal.setIdAnimal(rs.getInt("id_animal"));
            animal.setNombre(rs.getString("nombre"));
            animal.setEspecie(rs.getString("especie"));
            animal.setRaza(rs.getString("raza"));
            animal.setEdad(rs.getInt("edad"));
            animal.setEstadoSalud(rs.getString("estado_salud"));
            animal.setFechaIngreso(rs.getDate("fecha_ingreso"));
            return animal;
        }
        return null;
    }

    private Adoptantes obtenerDatosAdoptante(Connection conn, int idAnimal) throws SQLException {
        String query = "SELECT a.* FROM Adoptantes a " +
                       "JOIN Solicitudes_Adopcion sa ON a.id_adoptante = sa.id_adoptante " +
                       "WHERE sa.id_animal = ? AND sa.estado = 'Aprobada'";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, idAnimal);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Adoptantes adoptante = new Adoptantes();
            adoptante.setNombre(rs.getString("nombre"));
            adoptante.setCorreo(rs.getString("correo"));
            adoptante.setTelefono(rs.getString("telefono"));
            adoptante.setDireccion(rs.getString("direccion"));
            return adoptante;
        }
        return null;
    }

    private ImagenesAnimales obtenerImagenPorIdAnimal(Connection conn, int idAnimal) throws SQLException {
        String query = "SELECT * FROM imagenes_animales WHERE id_animal = ? LIMIT 1";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, idAnimal);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            ImagenesAnimales imagen = new ImagenesAnimales();
            imagen.setIdImagen(rs.getInt("id_imagen"));
            imagen.setIdAnimal(rs.getInt("id_animal"));
            imagen.setNombreImagen(rs.getString("nombre_imagen"));
            imagen.setTipoImagen(rs.getString("tipo_imagen"));
            imagen.setImagen(rs.getString("imagen")); // Aquí obtenemos la imagen en Base64
            imagen.setFechaSubida(rs.getDate("fecha_subida"));
            return imagen;
        }
        return null;
    }
}
