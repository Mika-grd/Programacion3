/*
 * Ejercicio de Bonificación - Programación 3
 *
 * Este programa implementa una estructura de empresa con categorías y productos.
 * El objetivo es obtener todos los productos cuyo precio sea mayor o igual a 10,000.
 * La búsqueda de productos se realiza de manera recursiva a través de las subcategorías.
 *
 * Clases:
 * - Empresa: representa una empresa con una lista de categorías.
 * - Categoria: representa una categoría que puede contener productos y subcategorías.
 * - Producto: representa un producto con nombre y precio.
 *
 * Autor: Miguel Betancourt
 */

import java.util.LinkedList;

// Clase que representa una empresa con una lista de categorías
class Empresa {
    private String nombre;
    private LinkedList<Categoria> listaCategorias;

    // Constructor de Empresa
    public Empresa(String nombre) {
        this.nombre = nombre;
        this.listaCategorias = new LinkedList<>();
    }

    // Agrega una categoría a la empresa
    public void agregarCategoria(Categoria categoria) {
        listaCategorias.add(categoria);
    }
    // Devuelve la lista de categorías
    public LinkedList<Categoria> getCategorias() {
        return listaCategorias;
    }

    // Elimina una categoría de la empresa
    public void eliminarCategoria(Categoria categoria) {
        listaCategorias.remove(categoria);
    }

    public String getNombre() {
        return nombre;
    }

    /*
     * Busca productos con precio >= 10,000 en todas las categorías de la empresa
     * @return LinkedList<Producto> con los productos encontrados
     */
    public LinkedList<Producto> buscarProductoPrecio10_000(){
        LinkedList<Producto> productosEncontrados = new LinkedList<>();
        // Buscar en cada categoría de la empresa
        for(Categoria categoria : listaCategorias){
            productosEncontrados.addAll(categoria.buscarProductoPrecio10_000());
        }
        return productosEncontrados;
    }
}

// Clase que representa una categoría con productos y subcategorías
class Categoria {
    private String nombre;
    private LinkedList<Producto> listaProductos = new LinkedList<>();
    private LinkedList<Categoria> subCategorias = new LinkedList<>();

    // Constructor de Categoria
    public Categoria(String nombre) {
        this.nombre = nombre;
    }

    // Agrega un producto a la categoría
    public void agregarProducto(Producto producto) {
        listaProductos.add(producto);
    }

    // Agrega una subcategoría a la categoría
    public void agregarSubCategoria(Categoria categoria) {
        subCategorias.add(categoria);
    }

    // Elimina un producto de la categoría
    public void eliminarProducto(Producto producto) {
        listaProductos.remove(producto);
    }

    // Elimina una subcategoría de la categoría
    public void eliminarSubCategoria(Categoria categoria) {
        subCategorias.remove(categoria);
    }

    // Devuelve la lista de productos de la categoría
    public LinkedList<Producto> getProductos() {
        return listaProductos;
    }

    // Devuelve la lista de subcategorías
    public LinkedList<Categoria> getSubCategorias() {
        return subCategorias;
    }

    public String getNombre() {
        return nombre;
    }

    /*
     * Algoritmo recursivo para buscar productos con precio >= 10,000
     * Busca en la lista de productos de la categoría actual y luego
     * recursivamente en todas las subcategorías.
     * @return LinkedList<Producto> con los productos encontrados
     */
    public LinkedList<Producto> buscarProductoPrecio10_000(){
        LinkedList<Producto> productosEncontrados = new LinkedList<>();
        // Buscar en los productos de la categoría actual
        for(Producto producto : listaProductos){
            if(producto.getPrecio() >= 10000){
                productosEncontrados.add(producto);
            }
        }
        // Buscar recursivamente en las subcategorías
        for(Categoria subCategoria : subCategorias){
            productosEncontrados.addAll(subCategoria.buscarProductoPrecio10_000());
        }
        return productosEncontrados;
    }
}

// Clase que representa un producto con nombre y precio
class Producto {
    private String nombre;
    private double precio;

    // Constructor de Producto
    public Producto(String nombre, double precio) {
        this.nombre = nombre;
        this.precio = precio;
    }

    // Devuelve el nombre del producto
    public String getNombre() {
        return nombre;
    }

    // Devuelve el precio del producto
    public double getPrecio() {
        return precio;
    }
}

// Clase principal que ejecuta el ejercicio de bonificación
public class Bonificacion {
    public static void main(String[] args) {
        // Crear una empresa
        Empresa empresa = new Empresa("Mi Empresa");
        // Crear categorías
        Categoria categoria1 = new Categoria("Electrónica");
        Categoria categoria2 = new Categoria("Ropa");
        // Crear productos
        Producto producto1 = new Producto("Televisor", 10000.0);
        Producto producto2 = new Producto("Camiseta", 20000.0);
        // Agregar productos a las categorías
        categoria1.agregarProducto(producto1);
        categoria2.agregarProducto(producto2);
        // Agregar categorías a la empresa y subcategorías
        empresa.agregarCategoria(categoria1);
        categoria1.agregarSubCategoria(categoria2);
        // Buscar productos con precio >= 10,000 de forma recursiva
        LinkedList<Producto> productosEncontrados = empresa.buscarProductoPrecio10_000();
        // Imprimir los productos encontrados
        for(Producto producto : productosEncontrados){
            System.out.println("Producto encontrado: " + producto.getNombre() + ", Precio: $" + producto.getPrecio());
        }
    }
}