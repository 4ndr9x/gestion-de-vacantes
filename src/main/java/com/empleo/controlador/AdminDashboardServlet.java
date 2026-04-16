package com.empleo.controlador;

import java.io.IOException;
import java.util.List;

import com.empleo.DAO.VacanteDAO;
import com.empleo.usuarios.Vacante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Instanciar DAOs
        VacanteDAO vDao = new VacanteDAO();
        // 2. Obtener listas
        List<Vacante> listaVacantes = vDao.listarVacantes(); // Asegúrate de tener este método en VacanteDAO
        
        // 3. Calcular totales para las cards superiores
        int totalVacantes = listaVacantes.size();
        long activas = listaVacantes.stream().filter(v -> "Activa".equalsIgnoreCase(v.getEstado())).count();
        long cerradas = listaVacantes.stream().filter(v -> "Cerrada".equalsIgnoreCase(v.getEstado())).count();

        // 4. Enviar datos al JSP
        request.setAttribute("listaVacantes", listaVacantes);
        request.setAttribute("totalV", totalVacantes);
        request.setAttribute("activasV", activas);
        request.setAttribute("cerradasV", cerradas);

        // 5. Redirigir a la página principal
        request.getRequestDispatcher("vista/paginaPrincipalAdm.jsp").forward(request, response);
    }
}