package com.tecsup.laboratorio_7.dao;

import com.tecsup.laboratorio_7.model.Categoria;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CategoriaDA0 {
    private static List<Categoria> categorias = new ArrayList<>();
    private static int contadorId = 1;

    static {
        categorias.add(new Categoria(contadorId++, "Electrónica", "Dispositivos electrónicos", true));
        categorias.add(new Categoria(contadorId++, "Ropa", "Prendas de vestir", true));
        categorias.add(new Categoria(contadorId++, "Alimentos", "Productos alimenticios", true));
        categorias.add(new Categoria(contadorId++, "Libros", "Literatura y textos", true));
    }

    public List<Categoria> listarTodos() {
        return new ArrayList<>(categorias);
    }

    public List<Categoria> listarActivos() {
        return categorias.stream()
                .filter(Categoria::isActivo)
                .collect(Collectors.toList());
    }

    public Categoria buscarPorId(int id) {
        return categorias.stream()
                .filter(c -> c.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public boolean insertar(Categoria categoria) {
        try {
            categoria.setId(contadorId++);
            categorias.add(categoria);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean actualizar(Categoria categoria) {
        try {
            for (int i = 0; i < categorias.size(); i++) {
                if (categorias.get(i).getId() == categoria.getId()) {
                    categorias.set(i, categoria);
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
            Categoria categoria = buscarPorId(id);
            if (categoria != null) {
                categoria.setActivo(false);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarFisico(int id) {
        try {
            return categorias.removeIf(c -> c.getId() == id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}