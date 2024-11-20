package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/HomeVeterinario")
public class HomeVeterinarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lógica para pasar datos al JSP (si es necesario)
        request.setAttribute("mensaje", "Bienvenido al Home Veterinario");

        // Redirige al JSP
        request.getRequestDispatcher("/Empleado/Veterinario/HomeVeterinario.jsp").forward(request, response);
    }
}
