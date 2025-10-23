<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulario de Producto</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            max-width: 700px;
            width: 100%;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            padding: 40px;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        select {
            cursor: pointer;
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1em;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .required {
            color: #dc3545;
        }
    </style>
</head>
<body>
<div class="container">
    <c:choose>
        <c:when test="${empty producto}">
            <h1>➕ Nuevo Producto</h1>
            <c:set var="accionForm" value="insertar" />
        </c:when>
        <c:otherwise>
            <h1> Editar Producto</h1>
            <c:set var="accionForm" value="actualizar" />
        </c:otherwise>
    </c:choose>

    <form method="post" action="${pageContext.request.contextPath}/productos">
        <input type="hidden" name="accion" value="${accionForm}">

        <c:if test="${not empty producto}">
            <input type="hidden" name="id" value="${producto.id}">
        </c:if>

        <div class="form-group">
            <label for="nombre">Nombre del Producto <span class="required">*</span></label>
            <input type="text"
                   id="nombre"
                   name="nombre"
                   value="${producto.nombre}"
                   required
                   placeholder="Ej: Laptop HP Pavilion">
        </div>

        <div class="form-group">
            <label for="descripcion">Descripción <span class="required">*</span></label>
            <textarea id="descripcion"
                      name="descripcion"
                      required
                      placeholder="Describe las características del producto...">${producto.descripcion}</textarea>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="precio">Precio (S/.) <span class="required">*</span></label>
                <input type="number"
                       id="precio"
                       name="precio"
                       value="${producto.precio}"
                       step="0.01"
                       min="0"
                       required
                       placeholder="0.00">
            </div>

            <div class="form-group">
                <label for="stock">Stock <span class="required">*</span></label>
                <input type="number"
                       id="stock"
                       name="stock"
                       value="${producto.stock}"
                       min="0"
                       required
                       placeholder="0">
            </div>
        </div>

        <div class="form-group">
            <label for="categoriaId">Categoría <span class="required">*</span></label>
            <select id="categoriaId" name="categoriaId" required>
                <option value="">-- Seleccione una categoría --</option>
                <c:forEach var="categoria" items="${listaCategorias}">
                    <option value="${categoria.id}"
                            <c:if test="${producto.categoriaId == categoria.id}">selected</c:if>>
                            ${categoria.nombre}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty producto}">
                        Guardar Producto
                    </c:when>
                    <c:otherwise>
                        Actualizar Producto
                    </c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/productos"
               class="btn btn-secondary"
               style="text-align: center; line-height: 14px; text-decoration: none;">
                Cancelar
            </a>
        </div>
    </form>
</div>
</body>
</html>
