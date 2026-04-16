<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Postulaciones</title>
</head>
<body>

<h2>Mis Postulaciones</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Vacante</th>
        <th>Fecha de Postulación</th>
        <th>Estado</th>
    </tr>

    <c:forEach var="p" items="${postulaciones}">
        <tr>
            <td>${p.id}</td>

            <td>${p.vacante.id}</td>

            <td>${p.fechaPostulacion}</td>

            <td>
                <c:choose>
                    <c:when test="${p.estatus == 'pendiente'}">
                        Pendiente
                    </c:when>
                    <c:when test="${p.estatus == 'aceptada'}">
                        Aceptada
                    </c:when>
                    <c:when test="${p.estatus == 'rechazada'}">
                        Rechazada
                    </c:when>
                    <c:otherwise>
                        ${p.estatus}
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>