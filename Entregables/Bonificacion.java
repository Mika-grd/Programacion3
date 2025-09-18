import java.util.LinkedList;

class Empresa {
    private String nombre;
    private LinkedList<Categoria> listaCategorias;

    public Empresa(String nombre) {
        this.nombre = nombre;
        this.listaCategorias = new LinkedList<>();
    }

    public void agregarCategoria(Categoria categoria) {
        listaCategorias.add(categoria);
    }
    public LinkedList<Categoria> getCategorias() {
        return listaCategorias;
    }

    public void eliminarCategoria(Categoria categoria) {
        listaCategorias.remove(categoria);
    }

    public LinkedList<Producto> buscarProductoPrecio10_000(){
        LinkedList<Producto> productosEncontrados = new LinkedList<>();
        for(Categoria categoria : listaCategorias){
            productosEncontrados.addAll(categoria.buscarProductoPrecio10_000());
        }
        return productosEncontrados;
    }
}

class Categoria {
    private String nombre;
    private LinkedList<Producto> listaProductos = new LinkedList<>();
    private LinkedList<Categoria> subCategorias = new LinkedList<>();

    public Categoria(String nombre) {
        this.nombre = nombre;
    }

    public void agregarProducto(Producto producto) {
        listaProductos.add(producto);
    }

    public void agregarSubCategoria(Categoria categoria) {
        subCategorias.add(categoria);
    }

    public void eliminarProducto(Producto producto) {
        listaProductos.remove(producto);
    }

    public void eliminarSubCategoria(Categoria categoria) {
        subCategorias.remove(categoria);
    }

    public LinkedList<Producto> getProductos() {
        return listaProductos;
    }

    public LinkedList<Categoria> getSubCategorias() {
        return subCategorias;
    }

    public LinkedList<Producto> buscarProductoPrecio10_000(){
        LinkedList<Producto> productosEncontrados = new LinkedList<>();
        for(Producto producto : listaProductos){
            if(producto.getPrecio() >= 10000){
                productosEncontrados.add(producto);
            }
        }
        for(Categoria subCategoria : subCategorias){
            productosEncontrados.addAll(subCategoria.buscarProductoPrecio10_000());
        }
        return productosEncontrados;
    }
}

class Producto {
    private String nombre;
    private double precio;

    public Producto(String nombre, double precio) {
        this.nombre = nombre;
        this.precio = precio;
    }

    public String getNombre() {
        return nombre;
    }

    public double getPrecio() {
        return precio;
    }
}

public class Bonificacion {
    public static void main(String[] args) {
        Empresa empresa = new Empresa("Mi Empresa");
        Categoria categoria1 = new Categoria("Electrónica");
        Categoria categoria2 = new Categoria("Ropa");
        Producto producto1 = new Producto("Televisor", 1000.0);
        Producto producto2 = new Producto("Camiseta", 20000.0);
        categoria1.agregarProducto(producto1);
        categoria2.agregarProducto(producto2);
        empresa.agregarCategoria(categoria1);
        categoria1.agregarSubCategoria(categoria2);
        LinkedList<Producto> productosEncontrados = categoria1.buscarProductoPrecio10_000();
        for(Producto producto : productosEncontrados){
            System.out.println("Producto encontrado: " + producto.getNombre() + ", Precio: $" + producto.getPrecio());
        }
    }
}