package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

import com.empleo.DAO.VacanteDAO;
import com.empleo.usuarios.Vacante;

@WebServlet("/VacanteServletAdm")
public class VacanteServletAdm extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    	
        String accion = request.getParameter("accion");
        VacanteDAO dao = new VacanteDAO();


        if ("crear".equals(accion)) {
            try {
                // 1. Capturar los datos del formulario
                int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
                String titulo = request.getParameter("titulo");
                String descripcion = request.getParameter("descripcion");
                BigDecimal salario = new BigDecimal(request.getParameter("salario"));
                String fechaStr = request.getParameter("fechaLimite");
                String estado = request.getParameter("estado");

                // 2. Convertir la fecha de String a java.sql.Date
                java.sql.Date fechaLimite = java.sql.Date.valueOf(fechaStr);

                // 3. Crear el objeto Vacante
                Vacante nuevaVacante = new Vacante();
                nuevaVacante.setIdEmpresa(idEmpresa);
                nuevaVacante.setTitulo(titulo);
                nuevaVacante.setDescripcion(descripcion);
                nuevaVacante.setSalario(salario);
                nuevaVacante.setFechaLimite(fechaLimite);
                nuevaVacante.setEstado(estado);

                // 4. Guardar en la base de datos
                dao.insertarVacantes(nuevaVacante);

                // 5. Redirigir al Dashboard para ver la nueva vacante en la lista
                response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");

            } catch (Exception e) {
                e.printStackTrace();
                try {
					response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet?error=1");
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            }
        }
        
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminarVacante(id); // Asegúrate de tener este método en tu VacanteDAO
            
            // Al terminar, volvemos al Dashboard para ver los cambios
            try {
				response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
			} catch (IOException e) {
				// TODO Auto-generated catch block
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
            	    // Convierte el texto "yyyy-MM-dd" directo a fecha de SQL
            	    fecha = Date.valueOf(fechaStr); 
            	} catch (IllegalArgumentException e) {
            	    System.out.println("Error en el formato de la fecha");
            	    e.printStackTrace();
            	}
                
                
                Vacante v = new Vacante(id1, idEmpresa, titulo, desc, salario, estado, fecha);
                dao.actualizarVacante(v); // Crea este método en DAO similar al de Postulaciones

                try {
					response.sendRedirect(request.getContextPath() + "/AdminDashboard");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
            
        
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener los datos del DAO (donde tenías el error del 'id')
        // Asegúrate de que el método listar funcione correctamente ahora
        List<Vacante> lista = null;
        
        VacanteDAO dao = new VacanteDAO();
        
		try {
			lista = dao.listarVacantes();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
        
        // 2. "Guardar" la lista en la maleta (request) para que el JSP la vea
        request.setAttribute("listaVacantes", lista);
        
        // 3. DIRIGIR a la página deseada (Forward)
        // El path debe ser relativo a la carpeta 'webapp' o 'WebContent'
        request.getRequestDispatcher("/vista/paginaPrincipalAdm.jsp").forward(request, response);
    }
}