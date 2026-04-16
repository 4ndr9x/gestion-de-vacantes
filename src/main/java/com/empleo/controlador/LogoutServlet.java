package com.empleo.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Obtener la sesión actual (sin crear una nueva)
        HttpSession session = request.getSession(false);

        // 2. Si existe, destruirla
        if (session != null) {
            session.invalidate();
        }

        // 3. Redirigir al login
        response.sendRedirect(request.getContextPath() + "/LoginUsuarioServlet");
    }
}
