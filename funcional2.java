import javax.swing.JOptionPane;

/**
 * Clase funcional2
 * Autor: Miguel Ángel Betancourt
 * Fecha: 26/08/2025
 *
 * Esta clase solicita al usuario un mensaje mediante JOptionPane
 * y lo imprime en salida estándar, para que Elixir pueda capturarlo.
 */
public class funcional2 {
    public static void main(String[] args) {
        String input = JOptionPane.showInputDialog("Ingrese un mensaje:");
        if (input != null) {
            // Elixir podrá capturar este valor como salida estándar
            System.out.print(input);
        } else {
            System.out.print("<<sin mensaje>>");
        }
    }
}
