package com.tecsup.laboratorio_7.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cursos")
public class CursosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Curso> cursos = new ArrayList<>();
        cursos.add(new Curso(1, "Desarrollo de Aplicaciones Web", "DAW", 4, "A"));
        cursos.add(new Curso(2, "Base de Datos Avanzado", "BDA", 4, "B"));
        cursos.add(new Curso(3, "Inteligencia de Negocios", "IN", 3, "A"));
        cursos.add(new Curso(4, "Desarrollo Móvil", "DM", 4, "C"));
        cursos.add(new Curso(5, "Seguridad Informática", "SI", 3, "B"));
        cursos.add(new Curso(6, "Computación en la Nube", "CC", 4, "A"));

        request.setAttribute("listaCursos", cursos);
        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
    }

    public static class Curso {
        private int id;
        private String nombre;
        private String codigo;
        private int creditos;
        private String seccion;

        public Curso(int id, String nombre, String codigo, int creditos, String seccion) {
            this.id = id;
            this.nombre = nombre;
            this.codigo = codigo;
            this.creditos = creditos;
            this.seccion = seccion;
        }

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public String getNombre() { return nombre; }
        public void setNombre(String nombre) { this.nombre = nombre; }

        public String getCodigo() { return codigo; }
        public void setCodigo(String codigo) { this.codigo = codigo; }

        public int getCreditos() { return creditos; }
        public void setCreditos(int creditos) { this.creditos = creditos; }

        public String getSeccion() { return seccion; }
        public void setSeccion(String seccion) { this.seccion = seccion; }
    }
}