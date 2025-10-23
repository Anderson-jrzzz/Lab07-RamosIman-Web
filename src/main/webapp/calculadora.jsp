<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Calculadora con JSTL</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .calculator {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        input[type="number"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        button:hover {
            background-color: #45a049;
        }
        .result {
            margin-top: 20px;
            padding: 15px;
            background-color: #e8f5e9;
            border-left: 4px solid #4CAF50;
            border-radius: 5px;
        }
        .result h3 {
            margin-top: 0;
            color: #2e7d32;
        }
    </style>
</head>
<body>
<div class="calculator">
    <h2>Calculadora con JSTL</h2>

    <form method="post">
        <div class="form-group">
            <label for="num1">Primer Número:</label>
            <input type="number" id="num1" name="num1" step="any" required
                   value="${param.num1}">
        </div>

        <div class="form-group">
            <label for="num2">Segundo Número:</label>
            <input type="number" id="num2" name="num2" step="any" required
                   value="${param.num2}">
        </div>

        <div class="form-group">
            <label for="operacion">Operación:</label>
            <select id="operacion" name="operacion">
                <option value="suma" ${param.operacion == 'suma' ? 'selected' : ''}>
                    Suma (+)
                </option>
                <option value="resta" ${param.operacion == 'resta' ? 'selected' : ''}>
                    Resta (-)
                </option>
                <option value="multiplicacion" ${param.operacion == 'multiplicacion' ? 'selected' : ''}>
                    Multiplicación (×)
                </option>
                <option value="division" ${param.operacion == 'division' ? 'selected' : ''}>
                    División (÷)
                </option>
            </select>
        </div>

        <button type="submit">Calcular</button>
    </form>

    <c:if test="${not empty param.num1 and not empty param.num2}">
        <c:set var="numero1" value="${param.num1}" />
        <c:set var="numero2" value="${param.num2}" />
        <c:set var="operacion" value="${param.operacion}" />

        <c:choose>
            <c:when test="${operacion == 'suma'}">
                <c:set var="resultado" value="${numero1 + numero2}" />
                <c:set var="simbolo" value="+" />
            </c:when>
            <c:when test="${operacion == 'resta'}">
                <c:set var="resultado" value="${numero1 - numero2}" />
                <c:set var="simbolo" value="-" />
            </c:when>
            <c:when test="${operacion == 'multiplicacion'}">
                <c:set var="resultado" value="${numero1 * numero2}" />
                <c:set var="simbolo" value="×" />
            </c:when>
            <c:when test="${operacion == 'division'}">
                <c:choose>
                    <c:when test="${numero2 == 0}">
                        <c:set var="error" value="true" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="resultado" value="${numero1 / numero2}" />
                        <c:set var="simbolo" value="÷" />
                    </c:otherwise>
                </c:choose>
            </c:when>
        </c:choose>

        <div class="result">
            <c:choose>
                <c:when test="${error == 'true'}">
                    <h3 style="color: #c62828;">Error: No se puede dividir entre cero</h3>
                </c:when>
                <c:otherwise>
                    <h3>Resultado de la operación:</h3>
                    <p style="font-size: 18px; margin: 10px 0;">
                        <strong>
                            <c:out value="${numero1}" />
                            <c:out value="${simbolo}" />
                            <c:out value="${numero2}" />
                            =
                            <fmt:formatNumber value="${resultado}" pattern="#,##0.####" />
                        </strong>
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</div>
</body>
</html>