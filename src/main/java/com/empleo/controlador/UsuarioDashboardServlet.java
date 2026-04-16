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
import jakarta.servlet.http.HttpSession;

@WebServlet("/UsuarioDashboardServlet")
public class UsuarioDashboardServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Validar Sesión (Si no hay sesión, mandarlo al login)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/vista/loginPageUsuario.jsp");
            return;
        }

        try {
            // 2. Cargar las vacantes activas desde el DAO
            VacanteDAO vDao = new VacanteDAO();
            List<Vacante> listaActivas = vDao.listarVacantesActivas();
            System.out.println("DEBUG: Vacantes encontradas: " + listaActivas.size());

            // 3. Pasar la lista al JSP con el nombre exacto que usas en el c:forEach
            request.setAttribute("vacantesDisponibles", listaActivas);

            // 4. Redirigir a la vista del usuario
            // ¡OJO!: Verifica que la carpeta sea 'vista' y el archivo 'paginaPrincipalUsuario.jsp'
            request.getRequestDispatcher("vista/paginaPrincipalUsuario.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error en el Dashboard de Usuario: " + e.getMessage());
            e.printStackTrace();
            // Si algo falla gravemente, mejor regresarlo al login o mostrar error 500
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}