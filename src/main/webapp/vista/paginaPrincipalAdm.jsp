<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Panel Administrador</title>
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
.sidebar a:hover, .sidebar a.active {
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
.section { display: none; }
.section.active { display: block; }
</style>
</head>

<body>
<div class="container-fluid">
<div class="row">

    <%-- ===== SIDEBAR ===== --%>
    <div class="col-2 sidebar d-flex flex-column justify-content-between">
        <div>
            <h4 class="text-center mb-4">Admin</h4>
            <a href="#" onclick="mostrarSeccion('vacantes')" id="linkVacantes">Vacantes</a>
            <a href="#" onclick="mostrarSeccion('empresas')" id="linkEmpresas">Empresas</a>
            <a href="${pageContext.request.contextPath}/PostulacionesServlet">Postulaciones</a>
        </div>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">
            Cerrar sesión
        </a>
    </div>

    <%-- ===== CONTENIDO ===== --%>
    <div class="col-10 p-4">


        <%-- SECCIÓN: VACANTES--%>

        <%-- SECCIÓN: VACANTES--%>
        <div id="secVacantes" class="section">
            <h2 class="mb-4">Gestión de Vacantes</h2>

            <%-- TARJETAS DE RESUMEN (DASHBOARD) --%>
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card bg-success text-white shadow-sm h-100">
                        <div class="card-body">
                            <h6 class="card-title text-uppercase text-white-50 fw-bold">Comisiones Totales</h6>
                            <h3 class="mb-0">
                                <%-- Usamos fmt para darle formato de moneda. Si está vacío, muestra 0.00 --%>
                                <fmt:formatNumber value="${not empty totalComisiones ? totalComisiones : 0}" type="currency" currencySymbol="RD$ " />
                            </h3>
                            <small>Ganancias por contrataciones</small>
                        </div>
                    </div>
                </div>
                <%-- Puedes agregar más tarjetas aquí en el futuro (ej. Total de Vacantes, Total Empresas) --%>
            </div>

            <div class="card p-3 mb-3 shadow-sm">
                <div class="row">
                    <div class="col-md-6">
                        <input type="text" class="form-control" placeholder="Buscar vacante...">
                    </div>
                    <div class="col-md-3">
                        <select class="form-select">
                            <option>Todos</option>
                            <option>Activa</option>
                            <option>Finalizada</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button class="btn btn-primary w-100"
                                data-bs-toggle="modal" data-bs-target="#modalVacante"
                                onclick="prepararCreacionVacante()">
                            + Nueva Vacante
                        </button>
                    </div>
                </div>
            </div>

            <div class="card p-3 shadow-sm">
                <h5>Lista de Vacantes</h5>
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Puesto</th>
                            <th>Empresa</th>
                            <th>Salario</th>
                            <th>Fecha Límite</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${listaVacantes}">
                            <tr>
                                <td>${v.titulo}</td>
                                <td>${v.nombreEmpresa}</td>
                                <td>RD$ ${v.salario}</td>
                                <td>${v.fechaLimite}</td>
                                <td>
                                    <span class="badge ${v.estado == 'activa' ? 'bg-success' : 'bg-secondary'}">
                                        ${v.estado}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-warning btn-sm"
                                        onclick="prepararEdicionVacante('${v.id}','${v.idEmpresa}','${v.titulo}','${v.descripcion}','${v.salario}','${v.fechaLimite}','${v.estado}')"
                                        data-bs-toggle="modal" data-bs-target="#modalVacante">
                                        Editar
                                    </button>
                                    <form action="${pageContext.request.contextPath}/VacanteServletAdm" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="id" value="${v.id}">
                                        <button type="submit" class="btn btn-sm btn-danger"
                                                onclick="return confirm('¿Eliminar la vacante: ${v.titulo}?');">
                                            Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listaVacantes}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">No hay vacantes registradas.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div><%-- fin secVacantes --%>


        <%-- SECCIÓN: EMPRESAS--%>

        <div id="secEmpresas" class="section">

            <h2 class="mb-4">Gestión de Empresas</h2>

            <div class="card p-3 mb-3 shadow-sm">
                <div class="row">
                    <div class="col-md-9">
                        <input type="text" class="form-control" placeholder="Buscar empresa...">
                    </div>
                    <div class="col-md-3">
                        <button class="btn btn-success w-100"
                                data-bs-toggle="modal" data-bs-target="#modalEmpresa"
                                onclick="prepararCreacionEmpresa()">
                            + Nueva Empresa
                        </button>
                    </div>
                </div>
            </div>

            <div class="card p-3 shadow-sm">
                <h5>Lista de Empresas</h5>
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Correo</th>
                            <th>RNC</th>
                            <th>Descripción</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emp" items="${listaEmpresas}">
                            <tr>
                                <td>${emp.nombre}</td>
                                <td>${emp.correo}</td>
                                <td>${emp.rnc}</td>
                                <td>${emp.descripcion}</td>
                                <td>
                                    <span class="badge ${emp.estado == 'activa' ? 'bg-success' : 'bg-secondary'}">
                                        ${emp.estado}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-warning btn-sm"
                                        onclick="prepararEdicionEmpresa('${emp.id_empresa}','${emp.nombre}','${emp.correo}','${emp.rnc}','${emp.descripcion}','${emp.estado}')"
                                        data-bs-toggle="modal" data-bs-target="#modalEmpresa">
                                        Editar
                                    </button>
                                    <form action="${pageContext.request.contextPath}/EmpresaServletAdm" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="id" value="${emp.id_empresa}">
                                        <button type="submit" class="btn btn-sm btn-danger"
                                                onclick="return confirm('¿Eliminar la empresa: ${emp.nombre}?');">
                                            Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listaEmpresas}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">No hay empresas registradas.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div><%-- fin secEmpresas --%>

    </div><%-- fin col-10 --%>
</div>
</div>

<%-- ===== MODAL: VACANTE ===== --%>
<div class="modal fade" id="modalVacante" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">
    <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="tituloModalVacante">Nueva Vacante</h5>
        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
    </div>
    <div class="modal-body">
        <form action="${pageContext.request.contextPath}/VacanteServletAdm" method="POST">
            <input type="hidden" name="accion" id="accionVacante" value="crear">
            <input type="hidden" name="id"     id="vacanteId">

            <div class="mb-3">
                <label class="form-label fw-semibold">Empresa</label>
                <select name="idEmpresa" id="mIdEmpresa" class="form-select" required>
                    <option value="">-- Selecciona una empresa --</option>
                    <c:forEach var="emp" items="${listaEmpresas}">
                        <option value="${emp.id_empresa}">${emp.nombre}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Título del Puesto</label>
                <input type="text" name="titulo" id="mTitulo" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Descripción</label>
                <textarea name="descripcion" id="mDescripcion" class="form-control" rows="3" required></textarea>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Salario (RD$)</label>
                    <input type="number" name="salario" id="mSalario" class="form-control" step="0.01" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Fecha Límite</label>
                    <input type="date" name="fechaLimite" id="mFechaLimite" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Estado</label>
                <select name="estado" id="mEstadoVacante" class="form-select" required>
                    <option value="activa">Activa</option>
                    <option value="finalizada">Finalizada</option>
                </select>
            </div>

            <div class="modal-footer px-0 pb-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" id="btnGuardarVacante" class="btn btn-primary">Guardar Vacante</button>
            </div>
        </form>
    </div>
</div>
</div>
</div>

<%-- ===== MODAL: EMPRESA ===== --%>
<div class="modal fade" id="modalEmpresa" tabindex="-1">
<div class="modal-dialog">
<div class="modal-content">
    <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="tituloModalEmpresa">Nueva Empresa</h5>
        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
    </div>
    <div class="modal-body">
        <form action="${pageContext.request.contextPath}/EmpresaServletAdm" method="POST">
            <input type="hidden" name="accion" id="accionEmpresa" value="crear">
            <input type="hidden" name="id"     id="empresaId">

            <div class="mb-3">
                <label class="form-label fw-semibold">Nombre</label>
                <input type="text" name="nombre" id="eNombre" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Correo</label>
                <input type="email" name="correo" id="eCorreo" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">RNC</label>
                <input type="text" name="rnc" id="eRnc" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Descripción</label>
                <textarea name="descripcion" id="eDescripcion" class="form-control" rows="3"></textarea>
            </div>

            <%-- Estado solo visible al editar --%>
            <div class="mb-3" id="campoEstadoEmpresa" style="display:none;">
                <label class="form-label fw-semibold">Estado</label>
                <select name="estado" id="eEstado" class="form-select">
                    <option value="activa">Activa</option>
                    <option value="desactiva">Desactiva</option>
                </select>
            </div>

            <div class="modal-footer px-0 pb-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" id="btnGuardarEmpresa" class="btn btn-success">Guardar Empresa</button>
            </div>
        </form>
    </div>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

// ── Navegación entre secciones ────────────────────────────────────────────
function mostrarSeccion(cual) {
    document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
    document.querySelectorAll('.sidebar a').forEach(a => a.classList.remove('active'));

    document.getElementById('sec' + cual.charAt(0).toUpperCase() + cual.slice(1)).classList.add('active');
    document.getElementById('link' + cual.charAt(0).toUpperCase() + cual.slice(1)).classList.add('active');

    // Guardamos la sección activa para que no se pierda al recargar
    sessionStorage.setItem('seccionActiva', cual);
}

// Al cargar la página, restaurar la sección que estaba activa
window.addEventListener('DOMContentLoaded', () => {
    const seccion = sessionStorage.getItem('seccionActiva') || 'vacantes';
    mostrarSeccion(seccion);
});

// ── Modal VACANTE ─────────────────────────────────────────────────────────
function prepararCreacionVacante() {
    document.getElementById('tituloModalVacante').innerText = "Nueva Vacante";
    document.getElementById('accionVacante').value = "crear";
    document.getElementById('btnGuardarVacante').innerText = "Guardar Vacante";
    document.getElementById('vacanteId').value = "";
    document.getElementById('mIdEmpresa').value = "";
    document.getElementById('mTitulo').value = "";
    document.getElementById('mDescripcion').value = "";
    document.getElementById('mSalario').value = "";
    document.getElementById('mFechaLimite').value = "";
    document.getElementById('mEstadoVacante').value = "activa";
}

function prepararEdicionVacante(id, idEmpresa, titulo, descripcion, salario, fecha, estado) {
    document.getElementById('tituloModalVacante').innerText = "Editar Vacante #" + id;
    document.getElementById('accionVacante').value = "editar";
    document.getElementById('btnGuardarVacante').innerText = "Actualizar Cambios";
    document.getElementById('vacanteId').value = id;
    document.getElementById('mIdEmpresa').value = idEmpresa;
    document.getElementById('mTitulo').value = titulo;
    document.getElementById('mDescripcion').value = descripcion;
    document.getElementById('mSalario').value = salario;
    document.getElementById('mFechaLimite').value = fecha;
    document.getElementById('mEstadoVacante').value = estado;
}

// ── Modal EMPRESA ─────────────────────────────────────────────────────────
function prepararCreacionEmpresa() {
    document.getElementById('tituloModalEmpresa').innerText = "Nueva Empresa";
    document.getElementById('accionEmpresa').value = "crear";
    document.getElementById('btnGuardarEmpresa').innerText = "Guardar Empresa";
    document.getElementById('empresaId').value = "";
    document.getElementById('eNombre').value = "";
    document.getElementById('eCorreo').value = "";
    document.getElementById('eRnc').value = "";
    document.getElementById('eDescripcion').value = "";
    document.getElementById('campoEstadoEmpresa').style.display = "none"; // Estado oculto al crear
}

function prepararEdicionEmpresa(id, nombre, correo, rnc, descripcion, estado) {
    document.getElementById('tituloModalEmpresa').innerText = "Editar Empresa #" + id;
    document.getElementById('accionEmpresa').value = "editar";
    document.getElementById('btnGuardarEmpresa').innerText = "Actualizar Cambios";
    document.getElementById('empresaId').value = id;
    document.getElementById('eNombre').value = nombre;
    document.getElementById('eCorreo').value = correo;
    document.getElementById('eRnc').value = rnc;
    document.getElementById('eDescripcion').value = descripcion;
    document.getElementById('eEstado').value = estado;
    document.getElementById('campoEstadoEmpresa').style.display = "block"; // Estado visible al editar
}
</script>
</body>
</html>
