<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Categorías</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            padding: 30px;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.5em;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-success {
            background-color: #28a745;
            color: white;
            font-size: 0.9em;
            padding: 8px 16px;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #333;
            font-size: 0.9em;
            padding: 8px 16px;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
            font-size: 0.9em;
            padding: 8px 16px;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: bold;
        }
        td {
            padding: 12px 15px;
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
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.85em;
            font-weight: bold;
        }
        .badge-active {
            background-color: #28a745;
            color: white;
        }
        .badge-inactive {
            background-color: #6c757d;
            color: white;
        }
        .actions {
            display: flex;
            gap: 8px;
        }
        .nav-menu {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .nav-menu a {
            color: #667eea;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }
        .nav-menu a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>📁 Gestión de Categorías</h1>

    <div class="nav-menu">
        <a href="${pageContext.request.contextPath}/categorias">Categorías</a>
        <a href="${pageContext.request.contextPath}/productos">Productos</a>
    </div>

    <!-- Mensajes -->
    <c:if test="${not empty mensaje}">
        <div class="alert alert-${tipoMensaje}">
                ${mensaje}
        </div>
    </c:if>

    <div class="header-actions">
        <div>
            <strong>Total de categorías:</strong> ${listaCategorias.size()}
        </div>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-primary">
            ➕ Nueva Categoría
        </a>
    </div>

    <c:choose>
        <c:when test="${empty listaCategorias}">
            <div style="text-align: center; padding: 40px; color: #666;">
                <h3>No hay categorías registradas</h3>
                <p>Comienza agregando una nueva categoría</p>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="categoria" items="${listaCategorias}" varStatus="status">
                    <tr>
                        <td><strong>#${categoria.id}</strong></td>
                        <td>${categoria.nombre}</td>
                        <td>${categoria.descripcion}</td>
                        <td>
                            <c:choose>
                                <c:when test="${categoria.activo}">
                                    <span class="badge badge-active">✓ Activo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-inactive">✗ Inactivo</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/categorias?accion=editar&id=${categoria.id}"
                                   class="btn btn-warning">
                                    Editar
                                </a>
                                <c:choose>
                                    <c:when test="${categoria.activo}">
                                        <a href="${pageContext.request.contextPath}/categorias?accion=eliminar&id=${categoria.id}"
                                           class="btn btn-danger"
                                           onclick="return confirm('¿Está seguro de desactivar esta categoría?')">
                                            🗑 Desactivar
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/categorias?accion=reactivar&id=${categoria.id}"
                                           class="btn btn-success"
                                           onclick="return confirm('¿Desea reactivar esta categoría?')">
                                            Reactivar
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Estadísticas -->
            <div style="margin-top: 20px; padding: 15px; background-color: #e7f3ff; border-radius: 8px;">
                <c:set var="activas" value="0" />
                <c:set var="inactivas" value="0" />
                <c:forEach var="cat" items="${listaCategorias}">
                    <c:choose>
                        <c:when test="${cat.activo}">
                            <c:set var="activas" value="${activas + 1}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="inactivas" value="${inactivas + 1}" />
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <strong> Estadísticas:</strong>
                    ${activas} categorías activas | ${inactivas} categorías inactivas
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>