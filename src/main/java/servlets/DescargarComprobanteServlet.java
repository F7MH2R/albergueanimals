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

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet("/DescargarComprobanteServlet")
public class DescargarComprobanteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));

        // Configurar el tipo de respuesta como PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=comprobante_adopcion_" + idSolicitud + ".pdf");

        // Detalles del animal a adoptar
        String nombreAnimal = "";
        String especie = "";
        String raza = "";
        int edad = 0;
        String estadoSalud = "";
        String imagenBase64 = null;

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT a.nombre AS nombre_animal, a.especie, a.raza, a.edad, a.estado_salud, ia.imagen " +
                           "FROM Solicitudes_Adopcion sa " +
                           "JOIN Animales a ON sa.id_animal = a.id_animal " +
                           "LEFT JOIN Imagenes_Animales ia ON a.id_animal = ia.id_animal " +
                           "WHERE sa.id_solicitud = ? LIMIT 1";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, idSolicitud);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                nombreAnimal = rs.getString("nombre_animal");
                especie = rs.getString("especie");
                raza = rs.getString("raza");
                edad = rs.getInt("edad");
                estadoSalud = rs.getString("estado_salud");
                imagenBase64 = rs.getString("imagen");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/General/ErrorPage.jsp");
            return;
        }

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Título
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Paragraph title = new Paragraph("Comprobante de Adopción", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Espaciado
            document.add(new Paragraph("\n"));

            // Información del animal
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            document.add(new Paragraph("Detalles del Animal Adoptado:", normalFont));
            document.add(new Paragraph("Nombre del Animal: " + nombreAnimal, normalFont));
            document.add(new Paragraph("Especie: " + especie, normalFont));
            document.add(new Paragraph("Raza: " + raza, normalFont));
            document.add(new Paragraph("Edad: " + edad + " años", normalFont));
            document.add(new Paragraph("Estado de Salud: " + estadoSalud, normalFont));

            // Espaciado
            document.add(new Paragraph("\n"));

            // Agregar imagen del animal si está disponible
            if (imagenBase64 != null) {
                try {
                    Image image = Image.getInstance(Base64.getDecoder().decode(imagenBase64));
                    image.scaleToFit(200, 200); // Escalar la imagen a 200x200 píxeles
                    image.setAlignment(Element.ALIGN_CENTER);
                    document.add(image);
                } catch (Exception e) {
                    e.printStackTrace();
                    document.add(new Paragraph("No se pudo cargar la imagen del animal."));
                }
            } else {
                document.add(new Paragraph("No hay imagen disponible para este animal."));
            }

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
}
