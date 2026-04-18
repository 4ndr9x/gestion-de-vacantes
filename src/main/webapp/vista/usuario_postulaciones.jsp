<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Postulaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background-color: #f4f6f9; }
        .sidebar {
            height: 100vh;
            background-color: #0d6efd;
            color: white;
            padding: 20px;
            position: sticky;
            top: 0;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.2s, color 0.2s, transform 0.2s;
        }
        .sidebar a:hover {
            background-color: #343a40;
            color: #ffffff;
        }
        .btn-logout {
            background-color: rgba(220, 53, 69, 0.2) !important;
            color: #ffb3b3 !important;
            text-align: center;
            margin-bottom: 10px;
        }
        .btn-logout:hover {
            background-color: rgba(220, 53, 69, 0.4) !important;
            color: #ffffff !important;
            transform: scale(1.02);
        }
        .card { border-radius: 12px; }
    </style>
</head>

<body>
<div class="container-fluid">
<div class="row">

    <%-- ===== SIDEBAR ===== --%>
    <div class="col-2 sidebar d-flex flex-column justify-content-between">
        <div>
            <h4 class="text-center">TalentHub</h4>
            <a href="${pageContext.request.contextPath}/UsuarioDashboardServlet">Vacantes disponibles</a>
        </div>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">
            Cerrar sesión
        </a>
    </div>

    <%-- ===== CONTENIDO ===== --%>
    <div class="col-10 p-4">

        <h2 class="mb-4">Mis Postulaciones</h2>

        <div class="card p-3 shadow-sm">
            <h5>Historial de postulaciones</h5>
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                       
                        <th>Empresa</th>
                        <th>Vacante</th>
                        <th>Fecha de Aplicación</th>
                        <th>Estado</th>
                        <th>Contacto</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${postulaciones}">
                        <tr>
                            <td>${p.vacante.nombreEmpresa}</td>
                            <td>${p.vacante.titulo}</td>
                            <td>${p.fechaPostulacion}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.estatus == 'pendiente'}">
                                        <span class="badge bg-warning text-dark">Pendiente</span>
                                    </c:when>
                                    <c:when test="${p.estatus == 'aceptado'}">
                                        <span class="badge bg-success">Aceptado</span>
                                    </c:when>
                                    <c:when test="${p.estatus == 'rechazado'}">
                                        <span class="badge bg-danger">Rechazado</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${p.estatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <%-- Botón que abre el modal con el correo de esa empresa --%>
                                <button class="btn btn-info btn-sm text-white"
                                        onclick="mostrarContacto('${p.vacante.nombreEmpresa}', '${p.vacante.correoEmpresa}')"
                                        data-bs-toggle="modal" data-bs-target="#modalContacto">
                                    Contactar
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty postulaciones}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">
                                No tienes postulaciones registradas aún.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div><%-- fin col-10 --%>
</div>
</div>

<%-- ===== MODAL CONTACTO ===== --%>
<div class="modal fade" id="modalContacto" tabindex="-1">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content">

    <div class="modal-header bg-info text-white">
        <h5 class="modal-title">Información de Contacto</h5>
        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body text-center py-4">
        <p class="mb-1 text-muted">Para consultas sobre tu postulación en</p>
        <h5 class="fw-bold mb-3" id="modalNombreEmpresa"></h5>
        <p class="mb-1">Puedes escribir al correo:</p>
        <a id="modalCorreoEmpresa" href="#" class="btn btn-outline-info mt-2">
            📩 <span id="textoCorreo"></span>
        </a>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
    </div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function mostrarContacto(nombreEmpresa, correoEmpresa) {
    document.getElementById('modalNombreEmpresa').innerText = nombreEmpresa;
    document.getElementById('textoCorreo').innerText = correoEmpresa;
    document.getElementById('modalCorreoEmpresa').href = 'mailto:' + correoEmpresa;
}
</script>
</body>
</html>
