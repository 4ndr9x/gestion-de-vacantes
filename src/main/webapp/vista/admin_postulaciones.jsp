<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin - Postulaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
        body { background-color: #f4f6f9; }
        .sidebar {
            height: 100vh;
            background-color: #0d6efd;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px; border-radius: 5px; }
        .sidebar a:hover { background-color: #343a40; }
        .card { border-radius: 12px; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <div class="col-2 sidebar">
            <div>
                <h4 class="text-center mb-4">Panel Admin</h4>
                <a href="${pageContext.request.contextPath}/VacanteServletAdm">Gestionar Vacantes</a>
                <a href="${pageContext.request.contextPath}/PostulacionesServlet">Ver Postulaciones</a>
            </div>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout">
                Cerrar sesión
            </a>
        </div>

        <div class="col-10 p-4">
            
            <h2 class="mb-4">Gestión de Postulaciones</h2>
            <div class="card p-3 mb-4 shadow-sm border-0">
                <div class="row g-3">
                    <div class="col-md-8">
                        <input type="text" id="busqueda" class="form-control" placeholder="Buscar por candidato o vacante...">
                    </div>
                    <div class="col-md-4">
                        <select class="form-select">
                            <option value="todos">Todos los estados</option>
                            <option value="pendiente">Pendiente</option>
                            <option value="aceptado">Aceptado</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="card p-4 shadow-sm">
                <h5 class="mb-3">Candidatos Postulados</h5>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th># ID</th>
                                <th>Vacante</th>
                                <th>Usuario</th>
                                <th>Fecha</th>
                                <th>Cambiar Estado</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty postulaciones}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        No se encontraron postulaciones.
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="p" items="${postulaciones}">
                                <tr>
                                    <td><strong>${p.id}</strong></td>
                                    <td>${p.vacante.titulo}</td> 
                                    <td>${p.usuario.nombre}</td>
                                    <td>
                                        <fmt:formatDate value="${p.fechaPostulacion}" pattern="dd/MM/yyyy" />
                                    </td>

                                    <td>
                                        <div class="d-flex gap-2">
                                            <form method="post" action="${pageContext.request.contextPath}/PostulacionesServlet" class="mb-0">
                                                <input type="hidden" name="accion" value="editar"/>
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="estado" value="aceptado"/>
                                                <button type="submit" class="btn btn-sm btn-outline-success ${p.estatus == 'aceptado' ? 'active disabled' : ''}">
                                                    Aceptar
                                                </button>
                                            </form>

                                            <form method="post" action="${pageContext.request.contextPath}/PostulacionesServlet" class="mb-0">
                                                <input type="hidden" name="accion" value="editar"/>
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="estado" value="rechazado"/>
                                                <button type="submit" class="btn btn-sm btn-outline-danger ${p.estatus == 'rechazado' ? 'active disabled' : ''}">
                                                    Rechazar
                                                </button>
                                            </form>
                                            
                                            <span class="badge align-self-center ${p.estatus == 'aceptado' ? 'bg-success' : p.estatus == 'rechazado' ? 'bg-danger' : 'bg-warning text-dark'}">
                                                ${p.estatus}
                                            </span>
                                        </div>
                                    </td>

                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/PostulacionesServlet" class="mb-0">
                                            <input type="hidden" name="accion" value="eliminar"/>
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('¿Estás seguro de que deseas eliminar la postulación #${p.id}?');">
                                                Eliminar
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
