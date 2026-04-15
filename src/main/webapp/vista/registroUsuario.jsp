<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registro de usuario</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
  body {
    min-height: 100vh;
    display: flex; align-items: center; justify-content: center;
    background-color: #f5f5f3;
  }
  .register-wrapper { width: 100%; max-width: 420px; padding: 1rem; }
  .register-icon {
    width: 52px; height: 52px; border-radius: 14px;
    background-color: #eaf3de;
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 1rem;
  }
  .register-card {
    background: #fff;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 12px;
    padding: 2rem;
  }
  .input-wrapper { position: relative; }
  .input-icon {
    position: absolute; left: 12px; top: 50%;
    transform: translateY(-50%);
    color: #aaa; width: 16px; height: 16px; pointer-events: none;
  }
  .at-sign {
    position: absolute; left: 12px; top: 50%;
    transform: translateY(-50%);
    font-size: 14px; font-weight: 500; color: #aaa;
  }
  .toggle-pwd {
    position: absolute; right: 10px; top: 50%;
    transform: translateY(-50%);
    background: none; border: none; cursor: pointer; color: #aaa; padding: 4px;
  }
  .form-control {
    background-color: #f8f8f7 !important;
    border: 1px solid #ddd !important;
    border-radius: 8px !important;
    font-size: 14px !important;
  }
  .form-control:focus { border-color: #378add !important; box-shadow: none !important; }
  .with-icon { padding-left: 38px !important; }
  .with-at   { padding-left: 28px !important; }
  .with-both { padding-left: 38px !important; padding-right: 38px !important; }
  .strength-bars { display: flex; gap: 4px; margin-top: 8px; }
  .strength-bar { height: 3px; flex: 1; border-radius: 2px; background: #e0e0e0; transition: background 0.2s; }
  .strength-label { font-size: 12px; color: #aaa; margin: 4px 0 0; }
  .btn-register {
    width: 100%; background: #1a1a1a; color: #fff;
    border: none; border-radius: 8px; padding: 11px;
    font-size: 14px; font-weight: 500;
  }
  .btn-register:hover { background: #333; color: #fff; }
  .divider { border-top: 1px solid #eee; padding-top: 1rem; }
  .form-label-sm { font-size: 13px; font-weight: 500; color: #666; }
</style>
</head>
<body>
<div class="register-wrapper">
  <div class="text-center mb-4">
    <div class="register-icon">
      <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#3B6D11" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
        <line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/>
      </svg>
    </div>
    <h2 style="font-size:22px; font-weight:500;" class="mb-1">Crea tu cuenta</h2>
    <p class="text-muted mb-0" style="font-size:14px;">Completa los datos para registrarte</p>
  </div>

  <div class="register-card">
    <form action="${pageContext.request.contextPath}/RegistroUsuarioServlet" method="post">

      <!-- Nombre -->
      <div class="mb-3">
        <label class="form-label form-label-sm">Nombre de usuario</label>
        <div class="input-wrapper">
          <span class="at-sign">@</span>
          <input type="text" name="nombre" class="form-control with-at" placeholder="nombre_usuario" required>
        </div>
      </div>

      <!-- Email -->
      <div class="mb-3">
        <label class="form-label form-label-sm">Correo electrónico</label>
        <div class="input-wrapper">
          <svg class="input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/>
          </svg>
          <input type="email" name="email" class="form-control with-icon" placeholder="nombre@ejemplo.com" required>
        </div>
      </div>

      <!-- Password -->
      <div class="mb-3">
        <label class="form-label form-label-sm">Contraseña</label>
        <div class="input-wrapper">
          <svg class="input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect width="18" height="11" x="3" y="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
          </svg>
          <input type="password" name="password" id="pwdField" class="form-control with-both" placeholder="••••••••" oninput="checkStrength(this.value)" required>
          <button type="button" class="toggle-pwd" onclick="let p=document.getElementById('pwdField'); p.type=p.type==='password'?'text':'password';">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>
            </svg>
          </button>
        </div>
        <div class="strength-bars">
          <div class="strength-bar" id="bar1"></div>
          <div class="strength-bar" id="bar2"></div>
          <div class="strength-bar" id="bar3"></div>
          <div class="strength-bar" id="bar4"></div>
        </div>
        <p class="strength-label" id="strength-label"></p>
      </div>

      <!-- Confirmar password -->
      <div class="mb-4">
        <label class="form-label form-label-sm">Confirmar contraseña</label>
        <div class="input-wrapper">
          <svg class="input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10"/>
          </svg>
          <input type="password" name="confirmPassword" class="form-control with-icon" placeholder="••••••••" required>
        </div>
      </div>

      <input type="submit" value="Crear cuenta" class="btn btn-register mb-3">

      <div class="text-center divider">
        <span style="font-size:13px; color:#888;">¿Ya tienes cuenta? </span>
        <a href="${pageContext.request.contextPath}/vista/loginPageUsuario.jsp" style="font-size:13px; color:#185fa5; font-weight:500; text-decoration:none;">Inicia sesión</a>
      </div>

    </form>
  </div>
</div>

<script>
function checkStrength(val) {
  let score = 0;
  if (val.length >= 8) score++;
  if (/[A-Z]/.test(val)) score++;
  if (/[0-9]/.test(val)) score++;
  if (/[^A-Za-z0-9]/.test(val)) score++;

  const colors = ['#e24b4a','#ef9f27','#1D9E75','#0F6E56'];
  const labels = ['Muy débil','Regular','Buena','Muy segura'];

  ['bar1','bar2','bar3','bar4'].forEach((id, i) => {
    document.getElementById(id).style.background = i < score ? colors[score-1] : '#e0e0e0';
  });

  const lbl = document.getElementById('strength-label');
  lbl.textContent = val.length ? labels[score-1] : '';
  lbl.style.color = val.length && score ? colors[score-1] : '#aaa';
}
</script>
</body>
</html>