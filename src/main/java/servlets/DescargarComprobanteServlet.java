package servlets;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
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

        try (Connection conn = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT a.nombre AS nombre_animal, a.especie, a.raza, a.edad, a.estado_salud " +
                           "FROM Solicitudes_Adopcion sa " +
                           "JOIN Animales a ON sa.id_animal = a.id_animal " +
                           "WHERE sa.id_solicitud = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, idSolicitud);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                nombreAnimal = rs.getString("nombre_animal");
                especie = rs.getString("especie");
                raza = rs.getString("raza");
                edad = rs.getInt("edad");
                estadoSalud = rs.getString("estado_salud");
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
            document.add(new Paragraph("Comprobante de Adopción"));
            document.add(new Paragraph("ID de Solicitud: " + idSolicitud));
            document.add(new Paragraph("Detalles del Animal Adoptado:"));
            document.add(new Paragraph("Nombre del Animal: " + nombreAnimal));
            document.add(new Paragraph("Especie: " + especie));
            document.add(new Paragraph("Raza: " + raza));
            document.add(new Paragraph("Edad: " + edad + " años"));
            document.add(new Paragraph("Estado de Salud: " + estadoSalud));
            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
}
