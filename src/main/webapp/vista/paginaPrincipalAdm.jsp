<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestor de Vacantes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background-color: #f4f6f9;
}
.sidebar {
    height: 100vh;
    background-color: #0d6efd;
    color: white;
    padding: 20px;
}
.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 10px;
    border-radius: 5px;
}
.sidebar a:hover {
    background-color: #0b5ed7;
}
.card {
    border-radius: 12px;
}
</style>
</head>

<body>
<div class="container-fluid">
<div class="row">

    <!-- SIDEBAR -->
    <div class="col-2 sidebar d-flex flex-column justify-content-between">
    <div>
        <h4 class="text-center">Vacantes</h4>
        <a href="#">Dashboard</a>
        <a href="${pageContext.request.contextPath}/PostulacionesServlet">Postulaciones</a>
    </div>

    <%-- Logout al fondo del sidebar --%>
    <a href="${pageContext.request.contextPath}/LogoutServlet" 
       style="background-color: rgba(255,255,255,0.15); text-align: center; margin-bottom: 10px;">
        Cerrar sesión
    </a>
</div>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="col-10 p-4">

        <h2 class="mb-4">Gestor de Vacantes - Panel Administrador</h2>

        <!-- DASHBOARD CARDS -->
        
        <!--
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card p-3 shadow-sm">
                    <h6>Total Vacantes</h6>
                    <h3>12</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow-sm">
                    <h6>Activas</h6>
                    <h3>8</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow-sm">
                    <h6>Cerradas</h6>
                    <h3>4</h3>
                </div>
            </div>
        </div>
        -->

        <!-- BARRA DE BUSQUEDA Y FILTROS -->
        <div class="card p-3 mb-3 shadow-sm">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" placeholder="Buscar vacante...">
                </div>
                <div class="col-md-3">
                    <select class="form-select">
                        <option>Todos</option>
                        <option>Activa</option>
                        <option>Cerrada</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#modalVacante">
                        + Nueva Vacante
                    </button>
                </div>
            </div>
        </div>

        <!-- TABLA DE VACANTES -->
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
			            <td>${v.idEmpresa}</td> <td>RD$ ${v.salario}</td>
			            <td>${v.fechaLimite}</td>
			            <td>
			            <span class="badge ${v.estado == 'Activa' ? 'bg-success' : 'bg-secondary'}">
						    ${v.estado}
						</span>
			            </td>
			            <td>
					    <button class="btn btn-warning btn-sm" 
					        onclick="prepararEdicion('${v.id}', '${v.idEmpresa}', '${v.titulo}', '${v.descripcion}', '${v.salario}', '${v.fechaLimite}', '${v.estado}')" 
					        data-bs-toggle="modal" data-bs-target="#modalVacante">
					    Editar
					</button>
					
					    <form action="${pageContext.request.contextPath}/VacanteServletAdm" method="POST" style="display:inline;">
					        <input type="hidden" name="accion" value="eliminar">
					        <input type="hidden" name="id" value="${v.id}">
					        <button type="submit" class="btn btn-sm btn-danger" 
					                onclick="return confirm('¿Estás seguro de que deseas eliminar la vacante: ${v.titulo}?');">
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

    </div>
</div>
</div>

<div class="modal fade" id="modalVacante" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">

    <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Editar Vacante</h5>
        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body">
        <form action="${pageContext.request.contextPath}/VacanteServletAdm" method="POST">
    <input type="hidden" name="accion" id="modalAccion" value="crear">
    <input type="hidden" name="id" id="vacanteId">
	
	<!-- FORMULARIO NUEVA VACANTE -->
	
    <div class="row mb-3">
        <div class="col-md-4">
            <label class="form-label fw-semibold">ID Empresa</label>
            <input type="number" name="idEmpresa" id="mIdEmpresa" class="form-control" required>
        </div>
        <div class="col-md-8">
            <label class="form-label fw-semibold">Título del Puesto</label>
            <input type="text" name="titulo" id="mTitulo" class="form-control" required>
        </div>
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
        <select name="estado" id="mEstado" class="form-select" required>
            <option value="activa">Activa</option>
            <option value="finalizada">Finalizada</option>
        </select>
    </div>

    <div class="modal-footer px-0 pb-0">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" id="btnGuardar" class="btn btn-primary">Guardar Vacante</button>
    </div>
    <!-- FORMULARIO -->
</form>
    </div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function prepararEdicion(id, idEmpresa, titulo, descripcion, salario, fecha, estado) {
    // Cambiamos el título del modal y la acción
    document.querySelector('.modal-title').innerText = "Editar Vacante #" + id;
    document.getElementById('modalAccion').value = "editar";
    document.getElementById('btnGuardar').innerText = "Actualizar Cambios";
    
    // Llenamos los campos
    document.getElementById('vacanteId').value = id;
    document.getElementById('mIdEmpresa').value = idEmpresa;
    document.getElementById('mTitulo').value = titulo;
    document.getElementById('mDescripcion').value = descripcion;
    document.getElementById('mSalario').value = salario;
    document.getElementById('mFechaLimite').value = fecha;
    document.getElementById('mEstado').value = estado;
}

// Opcional: Limpiar el modal cuando se quiera crear una nueva
document.querySelector('[data-bs-target="#modalVacante"]').addEventListener('click', function() {
    if(this.innerText.includes('+')) {
        document.querySelector('.modal-title').innerText = "Nueva Vacante";
        document.getElementById('modalAccion').value = "crear";
        document.getElementById('btnGuardar').innerText = "Guardar Vacante";
        document.getElementById('vacanteId').value = "";
        // Aquí podrías limpiar el resto de inputs...
    }
});
</script>
</body>
</html>