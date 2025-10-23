package com.tecsup.laboratorio_7.dao;

import com.tecsup.laboratorio_7.model.Producto;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductoDA0 {
    private static List<Producto> productos = new ArrayList<>();
    private static int contadorId = 1;
    private CategoriaDA0 categoriaDAO = new CategoriaDA0();

    static {
        productos.add(new Producto(contadorId++, "Laptop HP", "Laptop Core i5 8GB RAM", 2500.00, 10, 1, "Electrónica"));
        productos.add(new Producto(contadorId++, "Mouse Logitech", "Mouse inalámbrico", 45.50, 50, 1, "Electrónica"));
        productos.add(new Producto(contadorId++, "Camisa Formal", "Camisa blanca talla M", 89.90, 20, 2, "Ropa"));
        productos.add(new Producto(contadorId++, "Pantalón Jean", "Jean azul talla 32", 120.00, 15, 2, "Ropa"));
        productos.add(new Producto(contadorId++, "Arroz Costeño", "Arroz superior 1kg", 4.50, 100, 3, "Alimentos"));
    }

    public List<Producto> listarTodos() {
        for (Producto p : productos) {
            var cat = categoriaDAO.buscarPorId(p.getCategoriaId());
            if (cat != null) {
                p.setCategoriaNombre(cat.getNombre());
            }
        }
        return new ArrayList<>(productos);
    }

    public List<Producto> listarPorCategoria(int categoriaId) {
        return productos.stream()
                .filter(p -> p.getCategoriaId() == categoriaId)
                .collect(Collectors.toList());
    }

    public Producto buscarPorId(int id) {
        Producto producto = productos.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);

        if (producto != null) {
            var cat = categoriaDAO.buscarPorId(producto.getCategoriaId());
            if (cat != null) {
                producto.setCategoriaNombre(cat.getNombre());
            }
        }

        return producto;
    }

    // Insertar
    public boolean insertar(Producto producto) {
        try {
            producto.setId(contadorId++);
            var cat = categoriaDAO.buscarPorId(producto.getCategoriaId());
            if (cat != null) {
                producto.setCategoriaNombre(cat.getNombre());
            }
            productos.add(producto);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizar(Producto producto) {
        try {
            for (int i = 0; i < productos.size(); i++) {
                if (productos.get(i).getId() == producto.getId()) {
                    var cat = categoriaDAO.buscarPorId(producto.getCategoriaId());
                    if (cat != null) {
                        producto.setCategoriaNombre(cat.getNombre());
                    }
                    productos.set(i, producto);
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        try {
            return productos.removeIf(p -> p.getId() == id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Producto> buscarPorNombre(String nombre) {
        return productos.stream()
                .filter(p -> p.getNombre().toLowerCase().contains(nombre.toLowerCase()))
                .collect(Collectors.toList());
    }
}
