package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/DescargarComprobanteServlet")
public class DescargarComprobanteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));

        // Configurar el tipo de respuesta como PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=comprobante_adopcion_" + idSolicitud + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            // Generar el comprobante en PDF
            // Aquí debes generar el contenido del PDF
            out.write("Este es el comprobante de adopción para la solicitud".getBytes());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
