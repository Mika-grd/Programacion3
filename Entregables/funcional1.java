import javax.swing.JOptionPane;

/**
 * Clase funcional1
 * Autor: Miguel Ángel Betancourt
 * Fecha: 26/08/2025
 *
 * Esta clase recibe un argumento desde Elixir y lo muestra
 * en un cuadro de diálogo JOptionPane.
 */
public class funcional1 {
    public static void main(String[] args) {
        if (args.length > 0) {
            JOptionPane.showMessageDialog(null, args[0]);
        } else {
            JOptionPane.showMessageDialog(null, "No se recibió mensaje");
        }
    }
}
