<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulario de Categoría</title>
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
            max-width: 600px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        input[type="checkbox"] {
            width: 20px;
            height: 20px;
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
    </style>
</head>
<body>
<div class="container">
    <c:choose>
        <c:when test="${empty categoria}">
            <h1> Nueva Categoría</h1>
            <c:set var="accionForm" value="insertar" />
        </c:when>
        <c:otherwise>
            <h1> Editar Categoría</h1>
            <c:set var="accionForm" value="actualizar" />
        </c:otherwise>
    </c:choose>

    <form method="post" action="${pageContext.request.contextPath}/categorias">
        <input type="hidden" name="accion" value="${accionForm}">

        <c:if test="${not empty categoria}">
            <input type="hidden" name="id" value="${categoria.id}">
        </c:if>

        <div class="form-group">
            <label for="nombre">Nombre de la Categoría *</label>
            <input type="text"
                   id="nombre"
                   name="nombre"
                   value="${categoria.nombre}"
                   required
                   placeholder="Ej: Electrónica">
        </div>

        <div class="form-group">
            <label for="descripcion">Descripción *</label>
            <textarea id="descripcion"
                      name="descripcion"
                      required
                      placeholder="Describe la categoría...">${categoria.descripcion}</textarea>
        </div>

        <div class="form-group">
            <div class="checkbox-group">
                <input type="checkbox"
                       id="activo"
                       name="activo"
                       value="true"
                       <c:if test="${empty categoria or categoria.activo}">checked</c:if>>
                <label for="activo" style="margin: 0;">Categoría Activa</label>
            </div>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty categoria}">
                        Guardar
                    </c:when>
                    <c:otherwise>
                        Actualizar
                    </c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/categorias" class="btn btn-secondary" style="text-align: center; line-height: 14px; text-decoration: none;">
                Cancelar
            </a>
        </div>
    </form>
</div>
</body>
</html>