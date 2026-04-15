<!DOCTYPE html>

<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Vacantes</title>


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


<div class="col-2 sidebar">
    <h4 class="text-center">Vacantes</h4>
    <a href="#">Dashboard</a>
    <a href="#">Vacantes</a>
    <a href="#">Candidatos</a>
</div>


<div class="col-10 p-4">

<h2 class="mb-4">Gestión de Vacantes</h2>

<!-- DASHBOARD -->

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
```

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
                <option>Cerrada</option>
            </select>
        </div>
        <div class="col-md-3">
            <!-- Botón abre modal -->
            <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#modalVacante">
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
            <th>Ubicación</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>

    <tbody>
        <tr>
            <td>Desarrollador Web</td>
            <td>Tech Solutions</td>
            <td>Santo Domingo</td>
            <td><span class="badge bg-success">Activa</span></td>
            <td>
                <button class="btn btn-warning btn-sm">Editar</button>
                <button class="btn btn-danger btn-sm">Eliminar</button>
            </td>
        </tr>

        <tr>
            <td>Diseñador UI</td>
            <td>Creative Studio</td>
            <td>Santiago</td>
            <td><span class="badge bg-secondary">Cerrada</span></td>
            <td>
                <button class="btn btn-warning btn-sm">Editar</button>
                <button class="btn btn-danger btn-sm">Eliminar</button>
            </td>
        </tr>
    </tbody>
</table>
```

</div>

</div>
</div>
</div>


<div class="modal fade" id="modalVacante" tabindex="-1">
<div class="modal-dialog">
<div class="modal-content">

<div class="modal-header">
<h5 class="modal-title">Nueva Vacante</h5>
<button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">

<form>
    <label>Puesto</label>
    <input type="text" class="form-control mb-2">


<label>Empresa</label>
<input type="text" class="form-control mb-2">

<label>Ubicación</label>
<input type="text" class="form-control mb-2">

<label>Salario</label>
<input type="number" class="form-control mb-2">

<label>Tipo de empleo</label>
<select class="form-select mb-2">
    <option>Tiempo completo</option>
    <option>Medio tiempo</option>
</select>

<label>Estado</label>
<select class="form-select mb-2">
    <option>Activa</option>
    <option>Cerrada</option>
</select>
cls

</form>

</div>

<div class="modal-footer">
<button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
<button class="btn btn-primary">Guardar</button>
</div>

</div>
</div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>