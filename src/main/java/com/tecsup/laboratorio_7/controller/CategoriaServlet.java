package com.tecsup.laboratorio_7.controller;

import com.tecsup.laboratorio_7.dao.CategoriaDA0;
import com.tecsup.laboratorio_7.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/categorias")
public class CategoriaServlet extends HttpServlet {
    private CategoriaDA0 categoriaDAO = new CategoriaDA0();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "reactivar":
                reactivar(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "insertar":
                insertar(request, response);
                break;
            case "actualizar":
                actualizar(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Categoria> lista = categoriaDAO.listarTodos();
        request.setAttribute("listaCategorias", lista);
        request.getRequestDispatcher("/views/categorias/listar.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/categorias/formulario.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = categoriaDAO.buscarPorId(id);
        request.setAttribute("categoria", categoria);
        request.getRequestDispatcher("/views/categorias/formulario.jsp").forward(request, response);
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        boolean activo = request.getParameter("activo") != null;

        Categoria categoria = new Categoria();
        categoria.setNombre(nombre);
        categoria.setDescripcion(descripcion);
        categoria.setActivo(activo);

        boolean exito = categoriaDAO.insertar(categoria);

        if (exito) {
            request.setAttribute("mensaje", "Categoría creada exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al crear la categoría");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        boolean activo = request.getParameter("activo") != null;

        Categoria categoria = new Categoria(id, nombre, descripcion, activo);

        boolean exito = categoriaDAO.actualizar(categoria);

        if (exito) {
            request.setAttribute("mensaje", "Categoría actualizada exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al actualizar la categoría");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        boolean exito = categoriaDAO.eliminar(id);

        if (exito) {
            request.setAttribute("mensaje", "Categoría desactivada exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al desactivar la categoría");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void reactivar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = categoriaDAO.buscarPorId(id);

        if (categoria != null) {
            categoria.setActivo(true);
            boolean exito = categoriaDAO.actualizar(categoria);

            if (exito) {
                request.setAttribute("mensaje", "Categoría reactivada exitosamente");
                request.setAttribute("tipoMensaje", "success");
            } else {
                request.setAttribute("mensaje", "Error al reactivar la categoría");
                request.setAttribute("tipoMensaje", "error");
            }
        }

        listar(request, response);
    }
}