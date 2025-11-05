defmodule Autor do
  defstruct %{nombre: nombre, cedula: cedula, programa: programa, titulo: titulo}

  def construir() do

    nombre = "ingrese el nombre: "
    |> Util.ingresar(:texto)

    cedula = "ingrese la cedula: "
    |> Util.ingresar(:texto)

    programa = "ingrese el programa: "
    |> Util.ingresar(:texto)

    titulo = "ingrese el titulo: "
    |> Util.ingresar(:texto)

    %Autor{nombre, cedula, programa, titulo}

  end
end

defmodule Trabajo do
  defstruct %{fecha: fecha, titulo: titulo, descripcion: descripcion, autores: autores}

  def construir() do
    fecha = "ingrese la fecha: "
    |> Util.ingresar(:texto)

    titulo = "ingrese el titulo: "
    |> Util.ingresar(:texto)

    descripcion = "ingrese la descripcion: "
    |> Util.ingresar(:texto)

    cantidad = "¿Cuántos autores tiene el trabajo? "
    |> Util.ingresar(:numero)

    autores = for _ <- 1..cantidad, do: Autor.construir()

    %Trabajo{fecha: fecha, titulo: titulo, descripcion: descripcion, autores: autores}

  end

  def escribir_csv(autores, ruta) do
    encabezado = "nombre,cedula,programa,titulo\n"
    filas = Enum.map(autores, fn %Autor{nombre: n, cedula: c, programa: p, titulo: t} ->
      "#{n},#{c},#{p},#{t}\n"
    end)
    File.write!(ruta, encabezado <> Enum.join(filas, ""))
  end
end
