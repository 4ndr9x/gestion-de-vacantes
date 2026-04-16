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

/* Navbar */
.navbar {
    background-color: #0d6efd;
}


.job-card {
    transition: transform 0.2s;
}

.job-card:hover {
    transform: scale(1.02);
}


.badge {
    font-size: 0.9em;
}
</style>

</head>

<body>



<nav class="navbar navbar-dark px-4">
    <span class="navbar-brand mb-0 h1">Portal de Empleo</span>
</nav>

<div class="container mt-4">

<h1 class="text-primary">Bienvenido, ${sessionScope.nombreUsuario}</h1>

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

<!-- LISTA DE VACANTES -->
<div class="row">

    
    <div class="col-md-4 mb-4">
        <div class="card job-card shadow-sm p-3">
            <h5>Desarrollador Web</h5>
            <p class="text-muted">Tech Solutions</p>

            <span class="badge bg-primary">Santo Domingo</span>
            <span class="badge bg-success">Tiempo completo</span>

            <p class="mt-2">
                Desarrollo de aplicaciones web con HTML, CSS y JavaScript.
            </p>

            <button class="btn btn-primary w-100 mt-2" data-bs-toggle="modal" data-bs-target="#modalPostular">
                Postularse
            </button>
        </div>
    </div>

    
    <div class="col-md-4 mb-4">
        <div class="card job-card shadow-sm p-3">
            <h5>Diseñador UI/UX</h5>
            <p class="text-muted">Creative Studio</p>

            <span class="badge bg-primary">Santiago</span>
            <span class="badge bg-warning text-dark">Medio tiempo</span>

            <p class="mt-2">
                Diseño de interfaces modernas y experiencia de usuario.
            </p>

            <button class="btn btn-primary w-100 mt-2" data-bs-toggle="modal" data-bs-target="#modalPostular">
                Postularse
            </button>
        </div>
    </div>

    
    <div class="col-md-4 mb-4">
        <div class="card job-card shadow-sm p-3">
            <h5>Analista de Datos</h5>
            <p class="text-muted">DataCorp</p>

            <span class="badge bg-primary">Remoto</span>
            <span class="badge bg-success">Tiempo completo</span>

            <p class="mt-2">
                Análisis de datos y generación de reportes.
            </p>

            <button class="btn btn-primary w-100 mt-2" data-bs-toggle="modal" data-bs-target="#modalPostular">
                Postularse
            </button>
        </div>
    </div>

</div>


</div>



<div class="modal fade" id="modalPostular">
<div class="modal-dialog">
<div class="modal-content">

<div class="modal-header">
<h5 class="modal-title">Postularse</h5>
<button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">

<form>
    <label>Nombre</label>
    <input type="text" class="form-control mb-2">


<label>Correo</label>
<input type="email" class="form-control mb-2">

<label>Teléfono</label>
<input type="text" class="form-control mb-2">

<label>Experiencia</label>
<textarea class="form-control mb-2"></textarea>


</form>

</div>

<div class="modal-footer">
<button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
<button class="btn btn-primary">Enviar Postulación</button>
</div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>