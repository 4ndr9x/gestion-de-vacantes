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
import com.empleo.usuarios.Postulacion;


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
            lista = dao.ListaPostulaciones(); 
            request.setAttribute("postulaciones", lista);
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

        if (session == null || session.getAttribute("rol") == null) {
            response.sendRedirect("vista/loginPageUsuario.jsp");
            return;
        }

        String rol = String.valueOf(session.getAttribute("rol"));

        if (!"admin".equals(rol)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));
            String estado = request.getParameter("estado");

            Postulacion p = new Postulacion();
            p.setId(id);
            p.setEstatus(estado);

            dao.editarPostulacion(p);

        } else if ("eliminar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));
            dao.borrarPostulacion(id);
        }

        response.sendRedirect("PostulacionesServlet");
    }
}
