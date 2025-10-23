<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Listado de Cursos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-creditos {
            background-color: #2196F3;
            color: white;
        }
        .badge-seccion {
            background-color: #FF9800;
            color: white;
        }
        .total {
            margin-top: 20px;
            padding: 15px;
            background-color: #e3f2fd;
            border-left: 4px solid #2196F3;
            border-radius: 5px;
        }
        .btn-back {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn-back:hover {
            background-color: #5568d3;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/" class="btn-back">← Volver al Menú</a>

    <h2>📚 Listado de Cursos - JSTL</h2>

    <c:choose>
        <c:when test="${empty listaCursos}">
            <p style="text-align: center; color: #666; padding: 20px;">
                No hay cursos disponibles
            </p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Nombre del Curso</th>
                    <th>Créditos</th>
                    <th>Sección</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="totalCreditos" value="0" />
                <c:forEach var="curso" items="${listaCursos}" varStatus="status">
                    <tr>
                        <td>${curso.id}</td>
                        <td><strong>${curso.codigo}</strong></td>
                        <td>${curso.nombre}</td>
                        <td>
                                    <span class="badge badge-creditos">
                                        ${curso.creditos} créditos
                                    </span>
                        </td>
                        <td>
                                    <span class="badge badge-seccion">
                                        Sección ${curso.seccion}
                                    </span>
                        </td>
                    </tr>
                    <c:set var="totalCreditos" value="${totalCreditos + curso.creditos}" />
                </c:forEach>
                </tbody>
            </table>

            <div class="total">
                <strong>Total de cursos:</strong> ${listaCursos.size()} cursos
                <br>
                <strong>Total de créditos:</strong> ${totalCreditos} créditos
            </div>

            <div class="total" style="background-color: #fff3e0; border-left-color: #FF9800; margin-top: 15px;">
                <h4 style="margin-top: 0;">Cursos de 4 créditos:</h4>
                <c:set var="contadorCuatroCreditos" value="0" />
                <c:forEach var="curso" items="${listaCursos}">
                    <c:if test="${curso.creditos == 4}">
                        <c:set var="contadorCuatroCreditos" value="${contadorCuatroCreditos + 1}" />
                        ▪ ${curso.nombre} (${curso.codigo})<br>
                    </c:if>
                </c:forEach>
                <strong style="margin-top: 10px; display: block;">
                    Total: ${contadorCuatroCreditos} cursos
                </strong>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
