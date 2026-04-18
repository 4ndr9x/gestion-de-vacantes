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
        	
        	HttpSession sesionVieja = request.getSession(false);
        	
        	if (sesionVieja != null) {
                sesionVieja.invalidate();
            }
	         
	        HttpSession session = request.getSession(true);
            
            // GUARDAR EN SESSION (No en request)
            session.setAttribute("nombreUsuario", u.getNombre());
            session.setAttribute("id_usuario", u.getId());
            System.out.println(u.getId());// <--- Corregido
            
            if (u.getRol_id() == 3) {
                session.setAttribute("rol", "admin");
                response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
            } else {
                session.setAttribute("rol", "usuario"); // <--- IMPORTANTE
                System.out.println("Accediste como usuario");
                response.sendRedirect(request.getContextPath() + "/UsuarioDashboardServlet");
        
        }
       
        } else {
            request.setAttribute("loginError", true);
            request.setAttribute("correoIngresado", request.getParameter("correo"));
            request.getRequestDispatcher("/vista/loginPageUsuario.jsp").forward(request, response);
        }
    }
}