<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registro exitoso</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
  body {
    min-height: 100vh;
    display: flex; align-items: center; justify-content: center;
    background-color: #f5f5f3;
  }
  .success-wrapper { width: 100%; max-width: 420px; padding: 1rem; text-align: center; }
  .success-card {
    background: #fff;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 12px;
    padding: 2.5rem 2rem;
  }
  .success-icon {
    width: 64px; height: 64px; border-radius: 50%;
    background-color: #eaf3de;
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 1.5rem;
  }
  .btn-login {
    width: 100%; background: #1a1a1a; color: #fff;
    border: none; border-radius: 8px; padding: 11px;
    font-size: 14px; font-weight: 500;
  }
  .btn-login:hover { background: #333; color: #fff; }
</style>
</head>
<body>
<div class="success-wrapper">
  <div class="success-card">

    <div class="success-icon">
      <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#3B6D11" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20 6 9 17l-5-5"/>
      </svg>
    </div>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <h2 style="font-size:22px; font-weight:500; margin-bottom:8px;">
            ¡Todo listo, <span style="color:#3B6D11;">${sessionScope.nombreUsuario}</span>!
        </h2>
        <p class="text-muted" style="font-size:14px; line-height:1.6; margin-bottom:2rem;">
            Tu cuenta fue creada exitosamente. Ya puedes iniciar sesión y comenzar a usar la plataforma.
        </p>
        
        <button class="btn btn-login"
      	onclick="window.location.href='${pageContext.request.contextPath}/VISTA/loginPageUsuario.jsp'">
      	Ir a inicio de sesión
    	</button>

  </div>
</div>
</body>
</html>