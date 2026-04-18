package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

import com.empleo.DAO.EmpresaDAO;
import com.empleo.DAO.VacanteDAO;
import com.empleo.usuarios.Empresa;
import com.empleo.usuarios.Vacante;

@WebServlet("/VacanteServletAdm")
public class VacanteServletAdm extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    	
        String accion = request.getParameter("accion");
        VacanteDAO dao = new VacanteDAO();

        if ("crear".equals(accion)) {
            try {
                // El combobox ahora envía el id_empresa como value
                int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
                String titulo = request.getParameter("titulo");
                String descripcion = request.getParameter("descripcion");
                BigDecimal salario = new BigDecimal(request.getParameter("salario"));
                String fechaStr = request.getParameter("fechaLimite");
                String estado = request.getParameter("estado");

                java.sql.Date fechaLimite = java.sql.Date.valueOf(fechaStr);

                Vacante nuevaVacante = new Vacante();
                nuevaVacante.setIdEmpresa(idEmpresa);
                nuevaVacante.setTitulo(titulo);
                nuevaVacante.setDescripcion(descripcion);
                nuevaVacante.setSalario(salario);
                nuevaVacante.setFechaLimite(fechaLimite);
                nuevaVacante.setEstado(estado);

                dao.insertarVacantes(nuevaVacante);
                response.sendRedirect(request.getContextPath() + "/VacanteServletAdm");

            } catch (Exception e) {
                e.printStackTrace();
                try {
					response.sendRedirect(request.getContextPath() + "/VacanteServletAdm?error=1");
				} catch (IOException e1) {
					e1.printStackTrace();
				}
            }
        }
        
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminarVacante(id);
            try {
				response.sendRedirect(request.getContextPath() + "/VacanteServletAdm");
			} catch (IOException e) {
				e.printStackTrace();
			}
            return;
        }
            
        if ("editar".equals(accion)) {
            int id1 = Integer.parseInt(request.getParameter("id"));
            int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
            String titulo = request.getParameter("titulo");
            String desc = request.getParameter("descripcion");
            BigDecimal salario = new BigDecimal(request.getParameter("salario"));
            String estado = request.getParameter("estado");
            
            String fechaStr = request.getParameter("fechaLimite");
        	Date fecha = null;
        	try {
        	    fecha = Date.valueOf(fechaStr); 
        	} catch (IllegalArgumentException e) {
        	    System.out.println("Error en el formato de la fecha");
        	    e.printStackTrace();
        	}
            
            Vacante v = new Vacante(id1, null, idEmpresa, titulo, desc, salario, estado, fecha);

            dao.actualizarVacante(v);

            try {
				response.sendRedirect(request.getContextPath() + "/VacanteServletAdm");
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        VacanteDAO vacanteDAO = new VacanteDAO();
        EmpresaDAO empresaDAO = new EmpresaDAO();
        
        // Vacantes con nombre de empresa para mostrar en la tabla
        List<Vacante> listaVacantes = vacanteDAO.listarVacantesConEmpresa();

        // Lista de empresas para el combobox del formulario
        List<Empresa> listaEmpresas = empresaDAO.listarEmpresas();
        
        request.setAttribute("listaVacantes", listaVacantes);
        request.setAttribute("listaEmpresas", listaEmpresas);
        
        request.getRequestDispatcher("/vista/paginaPrincipalAdm.jsp").forward(request, response);
    }
}