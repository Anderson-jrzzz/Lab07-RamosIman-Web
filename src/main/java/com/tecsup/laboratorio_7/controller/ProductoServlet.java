package com.tecsup.laboratorio_7.controller;

import com.tecsup.laboratorio_7.dao.CategoriaDA0;
import com.tecsup.laboratorio_7.dao.ProductoDA0;
import com.tecsup.laboratorio_7.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {
    private ProductoDA0 productoDAO = new ProductoDA0();
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
            case "buscar":
                buscar(request, response);
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
        List<Producto> lista = productoDAO.listarTodos();
        request.setAttribute("listaProductos", lista);
        request.getRequestDispatcher("/views/productos/listar.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("listaCategorias", categoriaDAO.listarActivos());
        request.getRequestDispatcher("/views/productos/formulario.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = productoDAO.buscarPorId(id);
        request.setAttribute("producto", producto);
        request.setAttribute("listaCategorias", categoriaDAO.listarActivos());
        request.getRequestDispatcher("/views/productos/formulario.jsp").forward(request, response);
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

        Producto producto = new Producto();
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setStock(stock);
        producto.setCategoriaId(categoriaId);

        boolean exito = productoDAO.insertar(producto);

        if (exito) {
            request.setAttribute("mensaje", "Producto creado exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al crear el producto");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

        Producto producto = new Producto(id, nombre, descripcion, precio, stock, categoriaId);

        boolean exito = productoDAO.actualizar(producto);

        if (exito) {
            request.setAttribute("mensaje", "Producto actualizado exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al actualizar el producto");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        boolean exito = productoDAO.eliminar(id);

        if (exito) {
            request.setAttribute("mensaje", "Producto eliminado exitosamente");
            request.setAttribute("tipoMensaje", "success");
        } else {
            request.setAttribute("mensaje", "Error al eliminar el producto");
            request.setAttribute("tipoMensaje", "error");
        }

        listar(request, response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String termino = request.getParameter("termino");
        List<Producto> lista = productoDAO.buscarPorNombre(termino);
        request.setAttribute("listaProductos", lista);
        request.setAttribute("termino", termino);
        request.getRequestDispatcher("/views/productos/listar.jsp").forward(request, response);
    }
}