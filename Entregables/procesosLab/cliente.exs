defmodule NodoCliente do
  @ip_servidor "192.168.40.41" #ipconfig
  @servidor {:servicio_trabajos, :"nodoservidor@#{@ip_servidor}"}

  def main() do
    Util.mostrar_mensaje("========================================")
    Util.mostrar_mensaje("   CLIENTE - SISTEMA DE TRABAJOS       ")
    Util.mostrar_mensaje("========================================")
    Util.mostrar_mensaje("Conectando a: nodoservidor@#{@ip_servidor}")
    Util.mostrar_mensaje("")

    menu_principal()
  end

  defp menu_principal() do
    Util.mostrar_mensaje("\n╔════════════════════════════════════════╗")
    Util.mostrar_mensaje("║          MENÚ PRINCIPAL                ║")
    Util.mostrar_mensaje("╠════════════════════════════════════════╣")
    Util.mostrar_mensaje("║  1. Listar todos los trabajos          ║")
    Util.mostrar_mensaje("║  2. Listar todos los estudiantes       ║")
    Util.mostrar_mensaje("║  3. Buscar trabajo por título          ║")
    Util.mostrar_mensaje("║  4. Buscar estudiante por cédula       ║")
    Util.mostrar_mensaje("║  5. Agregar nuevo estudiante           ║")
    Util.mostrar_mensaje("║  6. Agregar nuevo trabajo              ║")
    Util.mostrar_mensaje("║  7. Salir                              ║")
    Util.mostrar_mensaje("╚════════════════════════════════════════╝")

    opcion = Util.ingresar("\n👉 Seleccione una opción: ", :entero)

    case opcion do
      1 -> listar_trabajos()
      2 -> listar_estudiantes()
      3 -> buscar_trabajo()
      4 -> buscar_estudiante()
      5 -> agregar_estudiante()
      6 -> agregar_trabajo()
      7 -> salir()
      _ ->
        Util.mostrar_mensaje("❌ Opción inválida")
        menu_principal()
    end
  end

  defp listar_trabajos() do
    Util.mostrar_mensaje("\n📚 Consultando trabajos...")
    send(@servidor, {self(), {:listar_trabajos}})
    recibir_respuesta()
    menu_principal()
  end

  defp listar_estudiantes() do
    Util.mostrar_mensaje("\n👥 Consultando estudiantes...")
    send(@servidor, {self(), {:listar_estudiantes}})
    recibir_respuesta()
    menu_principal()
  end

  defp buscar_trabajo() do
    titulo = Util.ingresar("\n🔍 Ingrese el título del trabajo: ", :texto)
    send(@servidor, {self(), {:buscar_trabajo, titulo}})
    recibir_respuesta()
    menu_principal()
  end

  defp buscar_estudiante() do
    cedula = Util.ingresar("\n🔍 Ingrese la cédula del estudiante: ", :texto)
    send(@servidor, {self(), {:buscar_estudiante, cedula}})
    recibir_respuesta()
    menu_principal()
  end

  defp agregar_estudiante() do
    Util.mostrar_mensaje("\n➕ AGREGAR NUEVO ESTUDIANTE")
    Util.mostrar_mensaje("================================")

    nombre = Util.ingresar("Nombre completo: ", :texto)
    cedula = Util.ingresar("Cédula: ", :texto)
    programa = Util.ingresar("Programa: ", :texto)
    email = Util.ingresar("Email: ", :texto)

    send(@servidor, {self(), {:agregar_estudiante, nombre, cedula, programa, email}})
    recibir_respuesta()
    menu_principal()
  end

  defp agregar_trabajo() do
    Util.mostrar_mensaje("\n➕ AGREGAR NUEVO TRABAJO DE GRADO")
    Util.mostrar_mensaje("====================================")

    id = Util.ingresar("ID del trabajo: ", :texto)
    fecha = Util.ingresar("Fecha (DD/MM/AAAA): ", :texto)
    titulo = Util.ingresar("Título: ", :texto)
    descripcion = Util.ingresar("Descripción: ", :texto)

    cantidad_autores = Util.ingresar("¿Cuántos autores? ", :entero)

    autores_cedulas = for i <- 1..cantidad_autores do
      Util.ingresar("Cédula del autor #{i}: ", :texto)
    end

    send(@servidor, {self(), {:agregar_trabajo, id, fecha, titulo, descripcion, autores_cedulas}})
    recibir_respuesta()
    menu_principal()
  end

  defp salir() do
    Util.mostrar_mensaje("\n👋 Cerrando conexión...")
    send(@servidor, {self(), :fin})
    recibir_respuesta()
    Util.mostrar_mensaje("✅ Sesión finalizada")
  end

  defp recibir_respuesta() do
    receive do
      :fin ->
        :ok
      respuesta ->
        Util.mostrar_mensaje("\n#{respuesta}")
    after
      5000 ->
        Util.mostrar_mensaje("\n⏱️  Tiempo de espera agotado - El servidor no respondió")
    end
  end
end

NodoCliente.main()
