package com.empleo.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import com.empleo.DAO.UsuarioDAO;
import com.empleo.usuarios.Usuario;

@WebServlet("/RegistroUsuarioServlet")   // <-- debe coincidir con el action del form
public class RegistroUsuarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// doPost porque el formulario usa method="post"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String nombre = request.getParameter("nombre");
        String email  = request.getParameter("email");
        String password = request.getParameter("password");
        int rol_id = 1;
        
        // agregar a BD
        
        Usuario u = new Usuario(nombre, email, password, rol_id);
        UsuarioDAO.registrarUsuario(u.getNombre(), u.getCorreo(), u.getPassword(), rol_id);

        System.out.println("Nombre: " + nombre);
        System.out.println("Email: "  + email);
        System.out.println("Contraseña "   + password);
        System.out.println("Rol "   + rol_id);

        HttpSession session = request.getSession();
        session.setAttribute("nombreUsuario", nombre);
        
        response.sendRedirect(request.getContextPath() + "/vista/registroExitoso.jsp");
    }
}