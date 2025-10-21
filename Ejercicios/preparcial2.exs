defmodule Cliente do
  defstruct nombre: "", documento: ""
end

defmodule Reserva do
  defstruct codigo: "", fecha_reserva: "", total: "", fecha_entrada: "", tipo_habitacion: "", cliente: %Cliente{}, habitaciones: []
  @moduledoc """
  Módulo para manejar reservas de un hotel, almacenadas en un archivo CSV.
  """

  # Nota: @file es un atributo reservado en Elixir; usamos otro nombre
  @csv_file "reservas.csv"


  # 🔹 Función auxiliar para leer texto de forma segura
  defp leer_cadena(mensaje) do
    case IO.gets(mensaje) do
      :eof -> ""
      nil -> ""
      data -> String.trim(data)
    end
  end

  # 🔹 Función auxiliar para leer habitaciones
  defp leer_habitaciones(acumulado) do
    numero = leer_cadena("Número de habitación (o 'fin'): ")

    if numero == "fin" or numero == "" do
      Enum.reverse(acumulado)
    else
      tipo = leer_cadena("Tipo de habitación: ")
      leer_habitaciones([{numero, tipo} | acumulado])
    end
  end

  # 1️⃣ Registrar una nueva reserva
  def registrar_reserva do
    IO.puts("=== Nueva Reserva ===")

    codigo = leer_cadena("Código de la reserva: ")
    fecha_reserva = leer_cadena("Fecha de la reserva (YYYY-MM-DD): ")
    total = leer_cadena("Total: ")
    fecha_entrada = leer_cadena("Fecha de entrada (YYYY-MM-DD): ")
    tipo_habitacion = leer_cadena("Tipo de habitación (sencilla/doble): ")
  nombre_cliente = leer_cadena("Nombre del cliente: ")
  documento_cliente = leer_cadena("Documento del cliente: ")
  cliente = %Cliente{nombre: nombre_cliente, documento: documento_cliente}

    IO.puts("Ingrese habitaciones (número y tipo), escriba 'fin' para terminar:")
    habitaciones = leer_habitaciones([])

    reserva = %Reserva{
      codigo: codigo,
      fecha_reserva: fecha_reserva,
      total: total,
      fecha_entrada: fecha_entrada,
      tipo_habitacion: tipo_habitacion,
  cliente: cliente,
      habitaciones: habitaciones
    }

    linea = reserva_to_csv(reserva)
    File.write(@csv_file, linea <> "\n", [:append])
    IO.puts("✅ Reserva registrada exitosamente.")
  end

  defp reserva_to_csv(%Reserva{codigo: c, fecha_reserva: fr, total: t, fecha_entrada: fe, tipo_habitacion: th, cliente: %Cliente{nombre: nombre, documento: doc}, habitaciones: habs}) do
    [
      to_string(c),
      to_string(fr),
      to_string(t),
      to_string(fe),
      to_string(th),
      to_string(nombre),
      to_string(doc),
      Enum.map(habs, fn
        nil -> ""
        {n, t} -> "#{to_string(n)}-#{to_string(t)}"
      end) |> Enum.join("|")
    ]
    |> Enum.join(",")
  end

  # 2️⃣ Consultar reservas por fecha (divide y vencerás)
  def buscar_por_fecha(fecha) do
    if File.exists?(@csv_file) do
      {:ok, contenido} = File.read(@csv_file)
      lineas = String.split(contenido, "\n", trim: true)
      reservas = Enum.map(lineas, &String.split(&1, ","))
      resultado = buscar_dividir(reservas, fecha)

      if resultado == [] do
        IO.puts("❌ No se encontraron reservas.")
      else
        IO.inspect(resultado)
      end
    else
      IO.puts("⚠️ No existe el archivo de reservas.")
    end
  end

  defp buscar_dividir([], _fecha), do: []
  defp buscar_dividir([r], fecha), do: if(Enum.at(r, 1) == fecha, do: [r], else: [])
  defp buscar_dividir(lista, fecha) do
    {left, right} = Enum.split(lista, div(length(lista), 2))
    buscar_dividir(left, fecha) ++ buscar_dividir(right, fecha)
  end

  # 3️⃣ Contar cuántos elementos son mayores que un número dado
  def contar_mayores([], _n), do: 0
  def contar_mayores([h | t], n) when h > n, do: 1 + contar_mayores(t, n)
  def contar_mayores([_ | t], n), do: contar_mayores(t, n)
end

# ======================
# MAIN DEL PROGRAMA
# ======================

defmodule Main do
  def menu do
    IO.puts("""
    =============================
    🏨 SISTEMA DE RESERVAS HOTEL
    =============================
    1. Registrar nueva reserva
    2. Buscar reservas por fecha
    3. Contar elementos mayores que un número
    0. Salir
    """)

    case IO.gets("Seleccione una opción: ") |> String.trim() do
      "1" -> Reserva.registrar_reserva()
      "2" ->
        fecha = IO.gets("Ingrese fecha (YYYY-MM-DD): ") |> String.trim()
        Reserva.buscar_por_fecha(fecha)
      "3" ->
        lista = [1, 5, 8, 2, 10, 4]
        n = IO.gets("Número de referencia: ") |> String.trim() |> String.to_integer()
        IO.puts("Hay #{Reserva.contar_mayores(lista, n)} elementos mayores que #{n}")
      "0" -> IO.puts("Saliendo del sistema...")
      _ -> IO.puts("Opción no válida")
    end

    if IO.gets("\n¿Desea continuar? (s/n): ") |> String.trim() == "s" do
      menu()
    else
      IO.puts("👋 Programa finalizado.")
    end
  end
end

# Ejecutar el menú automáticamente al iniciar
Main.menu()
