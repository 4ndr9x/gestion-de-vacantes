<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Inicio de sesión</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
  body {
    min-height: 100vh;
    display: flex; align-items: center; justify-content: center;
    background-color: #f5f5f3;
  }
  .login-wrapper { width: 100%; max-width: 420px; padding: 1rem; }
  .login-icon {
    width: 52px; height: 52px; border-radius: 14px;
    background-color: #e6f1fb;
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 1rem;
  }
  .login-card {
    background: #fff;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 12px;
    padding: 2rem;
  }
  .login-card.has-error { border-color: #f09595; }
  .error-banner {
    background-color: #fcebeb;
    border: 1px solid #f09595;
    border-radius: 8px;
    padding: 12px 14px;
    margin-bottom: 1.25rem;
    display: flex; align-items: center; gap: 10px;
    font-size: 13px; color: #a32d2d;
  }
  .input-wrapper { position: relative; }
  .input-icon {
    position: absolute; left: 12px; top: 50%;
    transform: translateY(-50%);
    width: 16px; height: 16px; pointer-events: none;
  }
  .input-icon-right {
    position: absolute; right: 10px; top: 50%;
    transform: translateY(-50%);
    background: none; border: none; cursor: pointer; padding: 4px;
  }
  .form-control {
    background-color: #f8f8f7 !important;
    border: 1px solid #ddd !important;
    border-radius: 8px !important;
    font-size: 14px !important;
    padding-left: 38px !important;
  }
  .form-control:focus { border-color: #378add !important; box-shadow: none !important; }
  .form-control.field-error {
    background-color: #fcebeb !important;
    border-color: #f09595 !important;
  }
  .form-control.field-error:focus { border-color: #a32d2d !important; }
  .btn-login {
    width: 100%; background: #1a1a1a; color: #fff;
    border: none; border-radius: 8px; padding: 11px;
    font-size: 14px; font-weight: 500;
  }
  .btn-login:hover { background: #333; color: #fff; }
  .divider { border-top: 1px solid #eee; padding-top: 1rem; }
  .form-label-sm { font-size: 13px; font-weight: 500; color: #666; }
  
  .empresa-card {
  margin-top: 12px;
  background: #fafaf8;
  border: 1px solid rgba(0,0,0,0.08);
  border-radius: 12px;
  padding: 1.25rem 1.5rem;
  display: flex; align-items: center;
  justify-content: space-between; gap: 12px;
}
.empresa-icon {
  width: 36px; height: 36px; border-radius: 10px;
  background: #faeeda;
  display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}
.empresa-links { display: flex; flex-direction: column; gap: 6px; flex-shrink: 0; }
.empresa-link-primary { font-size:12px; font-weight:500; color:#854f0b; text-decoration:none; text-align:right; }
.empresa-link-secondary { font-size:12px; font-weight:500; color:#888; text-decoration:none; text-align:right; }
  
</style>
</head>
<body>
<div class="login-wrapper">
  <div class="text-center mb-4">
    <div class="login-icon">
      <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#185fa5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
      </svg>
    </div>
    <h2 style="font-size:22px; font-weight:500;" class="mb-1">Bienvenido de nuevo </h2>
    <p class="text-muted mb-0" style="font-size:14px;">Inicia sesión para continuar</p>
  </div>

  <div class="login-card ${not empty requestScope.loginError ? 'has-error' : ''}">
    <form action="${pageContext.request.contextPath}/LoginUsuarioServlet" method="post">

      <%-- Banner de error --%>
      <c:if test="${not empty requestScope.loginError}">
      <div class="error-banner">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#a32d2d" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="flex-shrink:0;">
          <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
        </svg>
        Correo o contraseña incorrectos. Intenta de nuevo.
      </div>
      </c:if>

      <!-- Correo -->
      <div class="mb-3">
        <label class="form-label form-label-sm">Correo electrónico</label>
        <div class="input-wrapper">
          <svg class="input-icon" style="color: ${not empty requestScope.loginError ? '#e24b4a' : '#aaa'};" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/>
          </svg>
          <input type="email" name="correo" value="${not empty requestScope.loginError ? requestScope.correoIngresado : ''}"
            class="form-control ${not empty requestScope.loginError ? 'field-error' : ''}"
            placeholder="nombre@ejemplo.com">
        </div>
      </div>

      <!-- Contraseña -->
      <div class="mb-4">
        <div class="d-flex justify-content-between align-items-center mb-1">
          <label class="form-label mb-0 form-label-sm">Contraseña</label>
          <a href="#" style="font-size:12px; color:#185fa5; text-decoration:none;">¿Olvidaste tu contraseña?</a>
        </div>
        <div class="input-wrapper">
          <svg class="input-icon" style="color: ${not empty requestScope.loginError ? '#e24b4a' : '#aaa'};" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect width="18" height="11" x="3" y="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
          </svg>
          <input type="password" name="password" id="pwdField"
            class="form-control ${not empty requestScope.loginError ? 'field-error' : ''}"
            placeholder="••••••••" style="padding-right:38px !important;">
          <button type="button" class="input-icon-right" style="color: ${not empty requestScope.loginError ? '#e24b4a' : '#aaa'};"
            onclick="let p=document.getElementById('pwdField'); p.type=p.type==='password'?'text':'password';">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>
            </svg>
          </button>
        </div>
      </div>

      <input type="submit" value="Iniciar sesión" class="btn btn-login mb-3">

<div class="text-center divider">
  <span style="font-size:13px; color:#888;">¿No tienes cuenta? </span>
  <a href="${pageContext.request.contextPath}/VISTA/registroUsuario.jsp"
    style="font-size:13px; color:#185fa5; font-weight:500; text-decoration:none;">Regístrate</a>
</div>

</form>
</div>

  </div>
</body>
</html>