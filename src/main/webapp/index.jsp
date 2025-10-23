<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Laboratorio JSTL - Menú Principal</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.4);
            padding: 40px;
        }
        h1 {
            color: #1e3c72;
            text-align: center;
            margin-bottom: 15px;
            font-size: 2.5em;
        }
        .subtitle {
            text-align: center;
            color: #555;
            margin-bottom: 40px;
            font-size: 1.2em;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        .card {
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            position: relative;
            overflow: hidden;
        }
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
            pointer-events: none;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        .card.ejemplos {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .card.crud {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }
        .card-icon {
            font-size: 4em;
            margin-bottom: 20px;
            filter: drop-shadow(0 4px 6px rgba(0,0,0,0.2));
        }
        .card h2 {
            margin-bottom: 15px;
            font-size: 1.5em;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .card p {
            margin-bottom: 20px;
            opacity: 0.95;
        }
        .card a {
            display: inline-block;
            padding: 12px 30px;
            background-color: rgba(255,255,255,0.25);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: all 0.3s;
            border: 2px solid rgba(255,255,255,0.4);
            backdrop-filter: blur(10px);
        }
        .card a:hover {
            background-color: rgba(255,255,255,0.35);
            border-color: rgba(255,255,255,0.6);
            transform: scale(1.05);
        }
        .info-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 100%);
            padding: 25px;
            border-radius: 10px;
            margin-top: 30px;
            border-left: 5px solid #667eea;
        }
        .info-section h3 {
            color: #1e3c72;
            margin-bottom: 15px;
            font-size: 1.3em;
        }
        .info-section ul {
            list-style: none;
            padding-left: 0;
        }
        .info-section li {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
            color: #333;
        }
        .info-section li:before {
            content: "✓ ";
            color: #667eea;
            font-weight: bold;
            margin-right: 10px;
            font-size: 1.2em;
        }
        .info-section li:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🎓 Laboratorio 7(JSTL)</h1>

    <div class="grid">
        <div class="card ejemplos">
            <div class="card-icon"></div>
            <h2>Ejemplos JSTL</h2>
            <p>Ejemplos prácticos de JSTL</p>
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <a href="${pageContext.request.contextPath}/calculadora.jsp">
                    Ejemplo 1: Calculadora
                </a>
                <a href="${pageContext.request.contextPath}/cursos">
                    Ejemplo 2: Listado de Cursos
                </a>
                <a href="${pageContext.request.contextPath}/manipulacion.jsp">
                    Ejemplo 3: Manipulación de Datos
                </a>
            </div>
        </div>

        <div class="card crud">
            <div class="card-icon">🛒</div>
            <h2>Sistema CRUD</h2>
            <p>Gestión completa de Productos y Categorías</p>
            <div style="display: flex; flex-direction: column; gap: 10px;">
                <a href="${pageContext.request.contextPath}/categorias">
                    Gestión de Categorías
                </a>
                <a href="${pageContext.request.contextPath}/productos">
                    Gestión de Productos
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>