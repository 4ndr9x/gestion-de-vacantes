package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import com.empleo.DAO.UsuarioDAO;
import com.empleo.usuarios.Usuario;

@WebServlet("/LoginUsuarioServlet")
public class LoginUsuarioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // esto lo coloco pa arreglar el bug de registrarse
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/vista/loginPageUsuario.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String correo  = request.getParameter("correo");
        String password = request.getParameter("password");
        
        // creo objeto
        Usuario u;
        u = UsuarioDAO.buscarUsuario(correo, password);
        
        if (u != null) {
            System.out.println("Nombre usuario: " + u.getNombre());
            HttpSession session = request.getSession();
            session.setAttribute("nombreUsuario", u.getNombre());
            
            if (u.getRol_id() == 3) {
                System.out.println("Accediste como Administrador");
                response.sendRedirect(request.getContextPath() + "/vista/paginaPrincipalAdm.jsp");
            } else {
                System.out.println("Accediste como usuario");
                response.sendRedirect(request.getContextPath() + "/vista/paginaPrincipalUsuario.jsp");
            }
       
        } else {
            request.setAttribute("loginError", true);
            request.setAttribute("correoIngresado", request.getParameter("correo"));
            request.getRequestDispatcher("/vista/loginPageUsuario.jsp").forward(request, response);
        }
    }
}