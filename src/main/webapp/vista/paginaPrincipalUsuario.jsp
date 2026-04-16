<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Portal de Empleo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background-color: #f4f6f9;
}

.navbar {
    background-color: #0d6efd;
}

.job-card {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform 0.2s;
}

.job-card:hover {
    transform: scale(1.02);
}

.card-fixed {
    height: 320px;
}

.descripcion {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
}

.badge {
    font-size: 0.9em;
}

/* Estilos originales de tus cards */
.login-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    height: 100%;
}

.empresa-icon {
    background-color: #fff3cd;
    border-radius: 8px;
    padding: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-login {
    background-color: #0d6efd;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-size: 13px;
    cursor: pointer;
}

.btn-login:hover {
    background-color: #0b5ed7;
    color: white;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark px-4 d-flex justify-content-between">
    <span class="navbar-brand mb-0 h1">Portal de Empleo</span>
    
    <a href="${pageContext.request.contextPath}/LogoutServlet" 
       class="btn btn-outline-light btn-sm">
        Cerrar sesión
    </a>
</nav>

<div class="container mt-4">

    <h1 class="text-primary">Bienvenido, ${sessionScope.nombreUsuario}</h1>

    <!-- BARRA DE BÚSQUEDA -->
    <div class="row mb-4">
        <div class="col-md-6">
            <input type="text" class="form-control" placeholder="Buscar empleo...">
        </div>
        <div class="col-md-3">
            <select class="form-select">
                <option>Ubicación</option>
                <option>Santo Domingo</option>
                <option>Santiago</option>
            </select>
        </div>
        <div class="col-md-3">
            <select class="form-select">
                <option>Tipo</option>
                <option>Tiempo completo</option>
                <option>Medio tiempo</option>
            </select>
        </div>
    </div>

    <!-- VACANTES -->
    <h2 class="mb-4" style="font-weight:500;">Vacantes Disponibles</h2>

    <div class="row">
        <c:forEach var="v" items="${vacantesDisponibles}">
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="login-card" style="padding: 1.5rem;">

                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="empresa-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#854f0b" stroke-width="2">
                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"/>
                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/>
                            </svg>
                        </div>
                        <div>
                            <h5 class="mb-0" style="font-size: 16px; font-weight: 600;">${v.titulo}</h5>
                            <small class="text-muted">${v.idEmpresa}</small>
                        </div>
                    </div>

                    <p style="font-size: 13px; color: #666; height: 40px; overflow: hidden;">
                        ${v.descripcion}
                    </p>

                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                        <span style="font-weight: 600; color: #1a1a1a;">RD$ ${v.salario}</span>

                        <%-- Botón que abre el modal --%>
                        <button type="button"
                            class="btn-login"
                            data-bs-toggle="modal"
                            data-bs-target="#modalPostular"
                            onclick="prepararPostulacion('${v.id}', '${v.titulo}')">
                            Postularse
                        </button>
                    </div>

                </div>
            </div>
        </c:forEach>
    </div>

</div>


<!-- MODAL (fuera del forEach, uno solo reutilizable) -->
<div class="modal fade" id="modalPostular" tabindex="-1" aria-labelledby="modalPostularLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="modalPostularLabel">Postularse</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <form action="${pageContext.request.contextPath}/PostulacionesServlet" method="POST">
                <input type="hidden" name="accion" value="postularse">
                <input type="hidden" name="idVacante" id="postularVacanteId">

                <div class="modal-body">
                    <p>¿Confirmas tu postulación a <strong id="tituloVacante"></strong>?</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Enviar Postulación</button>
                </div>
            </form>

        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function prepararPostulacion(id, titulo) {
    document.getElementById('postularVacanteId').value = id;
    document.getElementById('tituloVacante').innerText = titulo;
    document.getElementById('modalPostularLabel').innerText = "Postularse a: " + titulo;
}
</script>

</body>
</html>