package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.List;

import com.empleo.DAO.EmpresaDAO;
import com.empleo.DAO.VacanteDAO;
import com.empleo.usuarios.Empresa;
import com.empleo.usuarios.Vacante;

@WebServlet("/EmpresaServletAdm")
public class EmpresaServletAdm extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        cargarVista(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if ("crear".equals(accion)) {
            Empresa e = new Empresa();
            e.setNombre(request.getParameter("nombre"));
            e.setCorreo(request.getParameter("correo"));
            e.setRnc(request.getParameter("rnc"));
            e.setDescripcion(request.getParameter("descripcion"));
            empresaDAO.registrarEmpresa(e);
        }

        if ("editar".equals(accion)) {
            Empresa e = new Empresa();
            e.setId_empresa(Integer.parseInt(request.getParameter("id")));
            e.setNombre(request.getParameter("nombre"));
            e.setCorreo(request.getParameter("correo"));
            e.setRnc(request.getParameter("rnc"));
            e.setDescripcion(request.getParameter("descripcion"));
            e.setEstado(request.getParameter("estado"));
            empresaDAO.actualizarEmpresa(e);
        }

        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            empresaDAO.eliminarEmpresa(id);
        }

        // Siempre recargamos la vista después de cualquier acción
        cargarVista(request, response);
    }

    private void cargarVista(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmpresaDAO empresaDAO = new EmpresaDAO();
        VacanteDAO vacanteDAO = new VacanteDAO();

        List<Empresa> listaEmpresas  = empresaDAO.listarEmpresas();
        List<Vacante> listaVacantes  = vacanteDAO.listarVacantesConEmpresa();

        request.setAttribute("listaEmpresas", listaEmpresas);
        request.setAttribute("listaVacantes", listaVacantes);

        request.getRequestDispatcher("/vista/paginaPrincipalAdm.jsp").forward(request, response);
    }
}