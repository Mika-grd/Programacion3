defmodule Cliente do
  defstruct nombre: "" , edad: 0, altura: 0.0

  def crear(nombre, edad, altura) do
    %Cliente{nombre: nombre, edad: edad, altura: altura}
  end

  def ingresar(mensaje) do
    mensaje
    |> Util.mostrar_mensaje()

    nombre = "Ingrese su nombre: "
    |> Util.ingresar(:texto)

    edad = "Ingrese su edad: "
    |> Util.ingresar(:entero)

    altura = "Ingrese su altura: "
    |> Util.ingresar(:real)

    crear(nombre, edad, altura)

  end

  def ingresar(mensaje, :clientes) do
    mensaje
    |> ingresar([], :clientes)
  end

  def ingresar(mensaje, lista, :clientes) do
    cliente =
      mensaje
      |> ingresar()

    nueva_lista = lista ++ [cliente]

    mas_cleintes =
      "\nDesea ingresar mas clientes?? (Y/N)"
      |> Util.ingresar(:boolean)

    case mas_cleintes do
      true ->
        mensaje
        |> ingresar(nueva_lista, :clientes)

      false ->
        nueva_lista
    end
  end

  def generar_mensaje_clientes(lista_clientes, parser) do
  lista_clientes
    |> Enum.map(parser)
    |> Enum.join()
  end

  def escribir_csv(clientes, nombre) do
    clientes
    |> generar_mensaje_clientes(&convertir_cliente_linea_csv/1)
    |> (fn datos -> "nombre, edad, altura\n"<> datos end).()
    |> (&File.write(nombre, &1)).()
  end

  defp convertir_cliente_linea_csv(cliente) do
    "#{cliente.nombre},#{cliente.edad}, #{cliente.altura}\n"
  end

end
