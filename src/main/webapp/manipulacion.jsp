<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manipulación de Datos con JSTL</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
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
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        .section {
            margin: 30px 0;
            padding: 20px;
            background-color: #f9f9f9;
            border-left: 4px solid #4CAF50;
            border-radius: 5px;
        }
        h3 {
            color: #4CAF50;
            margin-top: 0;
        }
        .demo-box {
            background-color: white;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: left;
        }
        td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .highlight {
            background-color: #fff3cd;
            padding: 2px 5px;
            border-radius: 3px;
        }
        .code {
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            margin: 10px 0;
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

    <h2> Manipulación de Datos con JSTL</h2>

    <div class="section">
        <h3>1. Declaración y Uso de Variables</h3>

        <c:set var="nombre" value="Zair Trivino" />
        <c:set var="curso" value="Desarrollo de Aplicaciones Web" />
        <c:set var="creditos" value="4" />
        <c:set var="precio" value="1250.00" />

        <div class="demo-box">
            <strong>Nombre del estudiante:</strong> <c:out value="${nombre}" /><br>
            <strong>Curso:</strong> <c:out value="${curso}" /><br>
            <strong>Créditos:</strong> <c:out value="${creditos}" /><br>
            <strong>Precio:</strong> S/. <fmt:formatNumber value="${precio}" pattern="#,##0.00" />
        </div>
    </div>

    <div class="section">
        <h3>2. Estructuras Condicionales</h3>

        <c:set var="nota" value="16" />

        <div class="demo-box">
            <strong>Nota obtenida:</strong> ${nota}<br>
            <strong>Estado:</strong>
            <c:choose>
                <c:when test="${nota >= 18}">
                    <span style="color: #2e7d32;">✓ Excelente</span>
                </c:when>
                <c:when test="${nota >= 14}">
                    <span style="color: #1976d2;">✓ Aprobado</span>
                </c:when>
                <c:when test="${nota >= 11}">
                    <span style="color: #f57c00;">⚠ Regular</span>
                </c:when>
                <c:otherwise>
                    <span style="color: #c62828;">✗ Desaprobado</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="section">
        <h3>3. Iteración con Arrays</h3>

        <c:set var="lenguajes" value="Java,Python,JavaScript,C++,PHP,Ruby" />

        <div class="demo-box">
            <table>
                <tr>
                    <th>#</th>
                    <th>Lenguaje</th>
                    <th>Estado</th>
                </tr>
                <c:forEach var="lenguaje" items="${fn:split(lenguajes, ',')}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td><strong>${lenguaje}</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${status.first}">
                                    <span class="highlight">Primero</span>
                                </c:when>
                                <c:when test="${status.last}">
                                    <span class="highlight">Último</span>
                                </c:when>
                                <c:otherwise>
                                    Posición ${status.index + 1}
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <div class="section">
        <h3>4. Manipulación de Strings</h3>

        <c:set var="texto" value="JSTL es muy útil para JSP" />

        <div class="demo-box">
            <strong>Texto original:</strong> ${texto}<br>
            <strong>Mayúsculas:</strong> ${fn:toUpperCase(texto)}<br>
            <strong>Minúsculas:</strong> ${fn:toLowerCase(texto)}<br>
            <strong>Longitud:</strong> ${fn:length(texto)} caracteres<br>
            <strong>Contiene "JSTL":</strong>
            <c:if test="${fn:contains(texto, 'JSTL')}">
                ✓ Sí
            </c:if>
            <br>
            <strong>Subcadena (0-4):</strong> ${fn:substring(texto, 0, 4)}<br>
            <strong>Reemplazar "JSTL" por "Jakarta":</strong> ${fn:replace(texto, 'JSTL', 'Jakarta')}
        </div>
    </div>

    <div class="section">
        <h3>5. Formateo de Fechas y Números</h3>

        <c:set var="fechaActual" value="<%= new java.util.Date() %>" />
        <c:set var="monto" value="125678.75" />

        <div class="demo-box">
            <strong>Fecha actual:</strong><br>
            ▪ Formato corto: <fmt:formatDate value="${fechaActual}" pattern="dd/MM/yyyy" /><br>
            ▪ Formato largo:
            <fmt:setLocale value="es_PE" />
            <fmt:formatDate value="${fechaActual}" pattern="EEEE, dd 'de' MMMM 'de' yyyy" /><br>
            ▪ Con hora: <fmt:formatDate value="${fechaActual}" pattern="dd/MM/yyyy HH:mm:ss" /><br>
            <br>
            <strong>Monto a formatear: ${monto}</strong><br>
            ▪ Como moneda: <fmt:formatNumber value="${monto}" type="currency" currencySymbol="S/." /><br>
            ▪ Como porcentaje: <fmt:formatNumber value="${monto / 1000000}" type="percent" /><br>
            ▪ Con decimales: <fmt:formatNumber value="${monto}" pattern="#,##0.00" />
        </div>
    </div>

    <div class="section">
        <h3>6. Manejo de URLs</h3>

        <div class="demo-box">
            <c:url value="/cursos" var="urlCursos">
                <c:param name="seccion" value="C" />
                <c:param name="creditos" value="4" />
            </c:url>

            <strong>URL construida:</strong> <code>${urlCursos}</code><br>
            <a href="${urlCursos}" style="color: #4CAF50; text-decoration: none; font-weight: bold;">
                ➜ Ir a Cursos con parámetros
            </a>
        </div>
    </div>

    <div class="section">
        <h3>7. Operaciones Matemáticas</h3>

        <c:set var="num1" value="150" />
        <c:set var="num2" value="50" />

        <div class="demo-box">
            <table>
                <tr>
                    <th>Operación</th>
                    <th>Resultado</th>
                </tr>
                <tr>
                    <td>${num1} + ${num2}</td>
                    <td><strong>${num1 + num2}</strong></td>
                </tr>
                <tr>
                    <td>${num1} - ${num2}</td>
                    <td><strong>${num1 - num2}</strong></td>
                </tr>
                <tr>
                    <td>${num1} × ${num2}</td>
                    <td><strong>${num1 * num2}</strong></td>
                </tr>
                <tr>
                    <td>${num1} ÷ ${num2}</td>
                    <td><strong>${num1 / num2}</strong></td>
                </tr>
                <tr>
                    <td>${num1} % ${num2}</td>
                    <td><strong>${num1 % num2}</strong></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="section">
        <h3>8. Validación de Variables</h3>

        <c:set var="email" value="trivino@gmail.com" />
        <c:set var="telefono" value="" />

        <div class="demo-box">
            <strong>Email:</strong>
            <c:if test="${not empty email}">
                ✓ ${email} (válido)
            </c:if>
            <c:if test="${empty email}">
                ✗ No proporcionado
            </c:if>
            <br>

            <strong>Teléfono:</strong>
            <c:if test="${not empty telefono}">
                ✓ ${telefono}
            </c:if>
            <c:if test="${empty telefono}">
                ✗ No proporcionado
            </c:if>
        </div>
    </div>

    <div class="section">
        <h3>9. Operadores de Comparación</h3>

        <c:set var="edad" value="20" />
        <c:set var="limite" value="18" />

        <div class="demo-box">
            <table>
                <tr>
                    <th>Comparación</th>
                    <th>Resultado</th>
                </tr>
                <tr>
                    <td>${edad} > ${limite} (Mayor que)</td>
                    <td>
                        <c:if test="${edad > limite}">
                            <span style="color: green;">✓ Verdadero</span>
                        </c:if>
                        <c:if test="${edad <= limite}">
                            <span style="color: red;">✗ Falso</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>${edad} >= ${limite} (Mayor o igual)</td>
                    <td>
                        <c:if test="${edad >= limite}">
                            <span style="color: green;">✓ Verdadero</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>${edad} == ${limite} (Igual)</td>
                    <td>
                        <c:if test="${edad == limite}">
                            <span style="color: green;">✓ Verdadero</span>
                        </c:if>
                        <c:if test="${edad != limite}">
                            <span style="color: red;">✗ Falso</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>${edad} != ${limite} (Diferente)</td>
                    <td>
                        <c:if test="${edad != limite}">
                            <span style="color: green;">✓ Verdadero</span>
                        </c:if>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="section">
        <h3>10. Gestión de Scopes</h3>

        <c:set var="varPage" value="Variable de página" scope="page" />
        <c:set var="varRequest" value="Variable de request" scope="request" />
        <c:set var="varSession" value="Variable de sesión" scope="session" />

        <div class="demo-box">
            <strong>Scopes disponibles:</strong><br>
            ▪ Page Scope: ${pageScope.varPage}<br>
            ▪ Request Scope: ${requestScope.varRequest}<br>
            ▪ Session Scope: ${sessionScope.varSession}<br>

            <hr style="margin: 15px 0;">

            <c:remove var="varPage" scope="page" />
            <strong>Después de remover varPage:</strong><br>
            ▪ Page Scope:
            <c:if test="${empty pageScope.varPage}">
                (variable removida)
            </c:if>
        </div>
    </div>

</div>
</body>
</html>