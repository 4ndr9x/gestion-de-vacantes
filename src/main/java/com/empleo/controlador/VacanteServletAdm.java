package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import com.empleo.DAO.UsuarioDAO;
import com.empleo.usuarios.Usuario;

@WebServlet("/VacanteServlet")
public class VacanteServletAdm extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response) {
        String accion = request.getParameter("accion");

        if (accion.equals("crear")) {
            // Recoger datos del form
            String puesto   = request.getParameter("puesto");
            String empresa  = request.getParameter("empresa");
            String ubicacion = request.getParameter("ubicacion");
            
            // Crear objeto
            Vacante v = new Vacante(puesto, empresa, ubicacion);
            
            // Mandar al DAO
            VacanteDAO dao = new VacanteDAO();
            dao.insertar(v);
            
            // Redirigir de vuelta al JSP
            response.sendRedirect("vacantes.jsp");
        }

        if (accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            VacanteDAO dao = new VacanteDAO();
            dao.eliminar(id);
            response.sendRedirect("vacantes.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response) {
        // Para cargar la lista al abrir la página
        VacanteDAO dao = new VacanteDAO();
        List<Vacante> lista = dao.obtenerTodas();
        
        request.setAttribute("vacantes", lista);
        request.getRequestDispatcher("vacantes.jsp").forward(request, response);
    }
}