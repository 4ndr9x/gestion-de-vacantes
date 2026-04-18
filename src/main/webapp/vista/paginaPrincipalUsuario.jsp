<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Portal de Empleo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background-color: #f4f6f9;
    overflow-x: hidden;
}

.navbar {
    background-color: #0d6efd;
}

/* --- ESTILOS DEL SIDEBAR --- */
.sidebar {
    height: 100vh;
            background-color: #0d6efd;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
}

.sidebar a {
    color: #ffffff;
    text-decoration: none;
    padding: 12px 15px;
    display: block;
    border-radius: 6px;
    margin-bottom: 8px;
    transition: background-color 0.2s, color 0.2s;
}

.sidebar a:hover {
    background-color: #343a40;
    color: #ffffff;
}

.sidebar-btn-login {
    background-color: #0d6efd;
    color: white !important;
    text-align: center;
    font-weight: bold;
}

.sidebar-btn-login:hover {
    background-color: #0b5ed7;
}
/* --------------------------- */

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

.btn-postular {
    background-color: #0d6efd;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-size: 13px;
    cursor: pointer;
}

.btn-postular:hover {
    background-color: #0b5ed7;
    color: white;
}
</style>
</head>

<body>


<div class="container-fluid">
    <div class="row">
        
        <div class="col-md-2 sidebar d-flex flex-column justify-content-between">
            <div>
                <h4 class="text-center mb-4 text-white">Menú de Opciones</h4>

                <c:choose>
                    <c:when test="${not empty sessionScope.nombreUsuario}">
                        <a href="${pageContext.request.contextPath}/PostulacionesServlet">
                            Mis Postulaciones
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/ListarVacantesUsuario" class="sidebar-btn-login">
                            Iniciar Sesión
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Botón de cerrar sesión siempre al fondo (solo si está logueado) --%>
            <c:if test="${not empty sessionScope.nombreUsuario}">
                <div class="mb-3 px-2">
                    <a href="${pageContext.request.contextPath}/LogoutServlet" style="background-color: rgba(220, 53, 69, 0.2); color: #ffb3b3; text-align: center;">
                        Cerrar sesión
                    </a>
                </div>
            </c:if>
        </div>

        <div class="col-md-10 py-4 px-md-5">

            <%-- Saludo personalizado si hay sesión --%>
            <c:if test="${not empty sessionScope.nombreUsuario}">
                <h2 class="text-primary mb-4">Bienvenido, ${sessionScope.nombreUsuario}</h2>
            </c:if>

            <!--<div class="row mb-4">
                <div class="col-md-6 mb-2">
                    <input type="text" class="form-control" placeholder="Buscar empleo...">
                </div>
                <div class="col-md-3 mb-2">
                    <select class="form-select">
                        <option>Ubicación</option>
                        <option>Santo Domingo</option>
                        <option>Santiago</option>
                    </select>
                </div>
                <div class="col-md-3 mb-2">
                    <select class="form-select">
                        <option>Tipo</option>
                        <option>Tiempo completo</option>
                        <option>Medio tiempo</option>
                    </select>
                </div>
            </div> -->

            <h3 class="mb-4" style="font-weight:500;">Vacantes Disponibles</h3>

            <div class="row">
            
<%-- Mensaje si no hay vacantes --%>
<c:if test="${empty vacantesDisponibles}">
    <div class="col-12 text-center mt-5">
        <h2 class="text-primary mb-4">No existen vacantes disponibles actualmente.</h2>
        <p class="text-muted">Vuelve a revisar más tarde.</p>
    </div>
</c:if>

<%-- Grid de Vacantes --%>
		<div class="row">
		    <c:forEach var="v" items="${vacantesDisponibles}">
		        <div class="col-md-6 col-lg-4 mb-4">
		            <div class="login-card shadow-sm h-100" style="padding: 1.5rem; border-radius: 12px; background: white;">
		
		                <%-- Cabecera de la Tarjeta --%>
		                <div class="d-flex align-items-center gap-3 mb-3">
		                    <div class="empresa-icon">
		                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#854f0b" stroke-width="2">
		                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2"/>
		                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/>
		                        </svg>
		                    </div>
		                    <div>
		                        <h5 class="mb-0" style="font-size: 16px; font-weight: 600;">${v.titulo}</h5>
		                        <small class="text-muted">${v.nombreEmpresa}</small> <%-- Muestra el nombre en lugar del ID --%>
		                    </div>
		                </div>
		
		                <%-- Descripción --%>
		                <p style="font-size: 13px; color: #666; height: 60px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;">
		                    ${v.descripcion}
		                </p>
		
		                <%-- Pie de la Tarjeta --%>
		                <div class="d-flex justify-content-between align-items-center mt-auto pt-3 border-top">
		                    <span style="font-weight: 600; color: #1a1a1a;">
		                        <fmt:formatNumber value="${v.salario}" type="currency" currencySymbol="RD$ " />
		                    </span>
		
		                    <button type="button"
		                        class="btn btn-primary btn-sm btn-postular"
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
		
        </div> </div> </div> <div class="modal fade" id="modalPostular" tabindex="-1" aria-labelledby="modalPostularLabel" aria-hidden="true">
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
                    <%-- Validación rápida: advertir si intenta postularse sin sesión --%>
                    <c:if test="${empty sessionScope.nombreUsuario}">
                        <div class="alert alert-warning">
                            <strong>Aviso:</strong> Necesitas iniciar sesión para poder postularte.
                        </div>
                    </c:if>
                    <p>¿Confirmas tu postulación a <strong id="tituloVacante"></strong>?</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary" ${empty sessionScope.nombreUsuario ? 'disabled' : ''}>
                        Enviar Postulación
                    </button>
                </div>
            </form>

        	</div>
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