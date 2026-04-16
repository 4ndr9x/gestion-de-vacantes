<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Postulaciones</title>
</head>
<body>

<h2>Gestión de Postulaciones</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Vacante</th>
        <th>Usuario</th>
        <th>Fecha</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>

    <c:forEach var="p" items="${postulaciones}">
        <tr>
            <td>${p.id}</td>
            <td>${p.vacante.id}</td>
            <td>${p.usuario.id}</td>
            <td>${p.fechaPostulacion}</td>

            <td>
                <form method="post" action="${pageContext.request.contextPath}/PostulacionServlet">

                    <input type="hidden" name="accion" value="editar"/>
                    <input type="hidden" name="id" value="${p.id}"/>

                    <select name="estado">
                        <option value="pendiente" ${p.estatus == 'pendiente' ? 'selected' : ''}>Pendiente</option>
                        <option value="aceptada" ${p.estatus == 'aceptada' ? 'selected' : ''}>Aceptada</option>
                        <option value="rechazada" ${p.estatus == 'rechazada' ? 'selected' : ''}>Rechazada</option>
                    </select>

                    <button type="submit">Guardar</button>
                </form>
            </td>

            <!-- ELIMINAR -->
            <td>
                <form method="post" action="${pageContext.request.contextPath}/PostulacionServlet">
                    <input type="hidden" name="accion" value="eliminar"/>
                    <input type="hidden" name="id" value="${p.id}"/>
                    <button type="submit">Eliminar</button>
                </form>
            </td>

        </tr>
    </c:forEach>

</table>

</body>
</html>