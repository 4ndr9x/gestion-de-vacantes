package com.empleo.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.empleo.DAO.PostulacionDAO;
import com.empleo.DAO.VacanteDAO;
import com.empleo.usuarios.Postulacion;
import com.empleo.usuarios.Usuario;
import com.empleo.usuarios.Vacante;

@WebServlet("/PostulacionesServlet")
public class PostulacionesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PostulacionDAO dao = new PostulacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("vista/loginPageUsuario.jsp");
            return;
        }

        int idUsuario = (int) session.getAttribute("id_usuario");
        String rol = String.valueOf(session.getAttribute("rol"));

        List<Postulacion> lista;
        
        if ("admin".equals(rol)) {
            // 1. Obtener Postulaciones
            List<Postulacion> listaPostulaciones = dao.ListaPostulaciones();
            
            // 2. Obtener Vacantes (Para los cuadritos y la tabla)
            VacanteDAO vDao = new VacanteDAO();
            List<Vacante> listaVacantes = vDao.listarVacantes(); // Asegúrate que este método exista en tu VacanteDAO

            // 3. Cálculos para los cuadritos (Reactivos)
            int totalVacantes = listaVacantes.size();
            long activas = listaVacantes.stream().filter(v -> "Activa".equalsIgnoreCase(v.getEstado())).count();
            long cerradas = listaVacantes.stream().filter(v -> "Cerrada".equalsIgnoreCase(v.getEstado())).count();

            // 4. Pasar todo al JSP
            request.setAttribute("postulaciones", listaPostulaciones);
            request.setAttribute("vacantes", listaVacantes);
            request.setAttribute("totalV", totalVacantes);
            request.setAttribute("activasV", activas);
            request.setAttribute("cerradasV", cerradas);

            request.getRequestDispatcher("vista/admin_postulaciones.jsp").forward(request, response);
            
        } else {
        	
            lista = dao.listarPorUsuario(idUsuario);
            request.setAttribute("postulaciones", lista);
            request.getRequestDispatcher("vista/usuario_postulaciones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String accion = request.getParameter("accion");

        // 1. Validación de sesión única al principio
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/vista/loginPageUsuario.jsp");
            return; // Terminamos aquí si no hay sesión
        }

        String rol = String.valueOf(session.getAttribute("rol"));
        String idStr = request.getParameter("id");

        try {
            // CASO: POSTULARSE (Para Usuarios)
            if ("postularse".equals(accion)) {
                int idVacante = Integer.parseInt(request.getParameter("idVacante"));
                int idUser = (int) session.getAttribute("id_usuario");

                Vacante v = new Vacante(); v.setId(idVacante);
                Usuario u = new Usuario(); u.setId(idUser);

                Postulacion p = new Postulacion(0, v, u, new java.sql.Date(System.currentTimeMillis()), "pendiente");
                
                if (dao.insertarPostulacion(p)) {
                    response.sendRedirect(request.getContextPath() + "/UsuarioDashboardServlet?msg=exito");
                } else {
                    response.sendRedirect(request.getContextPath() + "/UsuarioDashboardServlet?msg=error");
                }
                return; // <--- CRÍTICO: Evita que el código siga bajando
            }

            // ACCIONES SOLO PARA ADMIN
            if ("admin".equals(rol)) {
                if ("editar".equals(accion) && idStr != null) {
                    int id = Integer.parseInt(idStr);
                    String nuevoEstado = request.getParameter("estado");
                    Postulacion p = dao.buscarPorID(id);
                    if (p != null) {
                        p.setEstatus(nuevoEstado); 
                        dao.editarPostulacion(p);
                    }
                } else if ("eliminar".equals(accion) && idStr != null) {
                    int id = Integer.parseInt(idStr);
                    dao.borrarPostulacion(id);
                }
                
                // Después de editar o eliminar, el admin vuelve a la lista
                response.sendRedirect(request.getContextPath() + "/PostulacionesServlet");
                return; // <--- CRÍTICO: Evita que el código siga bajando
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. Fallback: Si no entró en ninguna de las acciones anteriores,
        // redirigimos a una página segura para evitar que la página se quede en blanco.
        if (!response.isCommitted()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }}