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

<!-- VACANTES -->
<div class="row">

    
    <div class="col-md-4 mb-4">
        <div class="card job-card card-fixed shadow-sm p-3">
            <div>
                <h5>Desarrollador Web</h5>
                <p class="text-muted">Tech Solutions</p>

                <span class="badge bg-primary">Santo Domingo</span>
                <span class="badge bg-success">Tiempo completo</span>

                <p class="mt-2 descripcion">
                    Desarrollo de aplicaciones web con HTML, CSS y JavaScript. Se valora experiencia en frameworks modernos.
                </p>
            </div>

            <button class="btn btn-primary w-100 mt-2" data-bs-toggle="modal" data-bs-target="#modalPostular">
                Postularse
            </button>
        </div>
    </div>

    
    <div class="col-md-4 mb-4">
        <div class="card job-card card-fixed shadow-sm p-3">
            <div>
                <h5>Diseñador UI/UX</h5>
                <p class="text-muted">Creative Studio</p>

                <span class="badge bg-primary">Santiago</span>
                <span class="badge bg-warning text-dark">Medio tiempo</span>

                <p class="mt-2 descripcion">
                    Diseño de interfaces modernas enfocadas en la experiencia del usuario y prototipos interactivos.
                </p>
            </div>

            <button class="btn btn-primary w-100 mt-2" data-bs-toggle="modal" data-bs-target="#modalPostular">
                Postularse
            </button>
        </div>
    </div>

    
    <div class="col-md-4 mb-4">
        <div class="card job-card card-fixed shadow-sm p-3">
            <div>
                <h5>Analista de Datos</h5>
                <p class="text-muted">DataCorp</p>

                <span class="badge bg-primary">Remoto</span>
                <span class="badge bg-success">Tiempo completo</span>

                <p class="mt-2 descripcion">
                    Análisis de datos, creación de reportes y visualización con herramientas modernas como Power BI.
                </p>
            </div>

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
```

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