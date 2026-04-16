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

@WebServlet("/ListarVacantesUsuario")
public class ListarVacantesUsuarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VacanteDAO vDao = new VacanteDAO();
        // Método que solo traiga las activas
        List<Vacante> lista = vDao.listarVacantesActivas(); 
        
        request.setAttribute("vacantesDisponibles", lista);
        request.getRequestDispatcher("vista/paginaPrincipalUsuario.jsp").forward(request, response);
    
    } 
}