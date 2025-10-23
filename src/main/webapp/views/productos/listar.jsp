<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Productos</title>
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
            max-width: 1400px;
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
            flex-wrap: wrap;
            gap: 15px;
        }
        .search-box {
            display: flex;
            gap: 10px;
        }
        .search-box input {
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            min-width: 250px;
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
        .btn-info {
            background-color: #17a2b8;
            color: white;
            font-size: 0.9em;
            padding: 10px 20px;
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
        .badge-category {
            background-color: #17a2b8;
            color: white;
        }
        .badge-stock {
            background-color: #28a745;
            color: white;
        }
        .badge-stock-low {
            background-color: #ffc107;
            color: #333;
        }
        .badge-stock-out {
            background-color: #dc3545;
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
        .price {
            font-weight: bold;
            color: #28a745;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🛒 Gestión de Productos</h1>

    <div class="nav-menu">
        <a href="${pageContext.request.contextPath}/categorias">Categorías</a>
        <a href="${pageContext.request.contextPath}/productos">Productos</a>
    </div>

    <c:if test="${not empty mensaje}">
        <div class="alert alert-${tipoMensaje}">
                ${mensaje}
        </div>
    </c:if>

    <div class="header-actions">
        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/productos" style="display: flex; gap: 10px;">
                <input type="hidden" name="accion" value="buscar">
                <input type="text"
                       name="termino"
                       placeholder="Buscar producto..."
                       value="${termino}">
                <button type="submit" class="btn btn-info">🔍 Buscar</button>
                <c:if test="${not empty termino}">
                    <a href="${pageContext.request.contextPath}/productos" class="btn btn-secondary">Limpiar</a>
                </c:if>
            </form>
        </div>
        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-primary">
            Nuevo Producto
        </a>
    </div>

    <c:if test="${not empty termino}">
        <div style="margin-bottom: 15px; color: #666;">
            Mostrando resultados para: <strong>"${termino}"</strong>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty listaProductos}">
            <div style="text-align: center; padding: 40px; color: #666;">
                <h3>No hay productos registrados</h3>
                <p>Comienza agregando un nuevo producto</p>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Categoría</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="producto" items="${listaProductos}" varStatus="status">
                    <tr>
                        <td><strong>#${producto.id}</strong></td>
                        <td><strong>${producto.nombre}</strong></td>
                        <td>${producto.descripcion}</td>
                        <td class="price">
                            S/. <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00" />
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${producto.stock == 0}">
                                    <span class="badge badge-stock-out">Agotado</span>
                                </c:when>
                                <c:when test="${producto.stock <= 10}">
                                    <span class="badge badge-stock-low">${producto.stock} unidades</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-stock">${producto.stock} unidades</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="badge badge-category">${producto.categoriaNombre}</span>
                        </td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/productos?accion=editar&id=${producto.id}"
                                   class="btn btn-warning">
                                    Editar
                                </a>
                                <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=${producto.id}"
                                   class="btn btn-danger"
                                   onclick="return confirm('¿Está seguro de eliminar este producto?')">
                                    🗑 Eliminar
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div style="margin-top: 20px; padding: 15px; background-color: #e7f3ff; border-radius: 8px;">
                <c:set var="totalProductos" value="0" />
                <c:set var="totalStock" value="0" />
                <c:set var="totalValor" value="0" />
                <c:forEach var="prod" items="${listaProductos}">
                    <c:set var="totalProductos" value="${totalProductos + 1}" />
                    <c:set var="totalStock" value="${totalStock + prod.stock}" />
                    <c:set var="totalValor" value="${totalValor + (prod.precio * prod.stock)}" />
                </c:forEach>
                <strong> Estadísticas:</strong><br>
                ▪ Total de productos: ${totalProductos}<br>
                ▪ Stock total: ${totalStock} unidades<br>
                ▪ Valor total en inventario: S/. <fmt:formatNumber value="${totalValor}" pattern="#,##0.00" />
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
