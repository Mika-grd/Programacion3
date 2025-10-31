defmodule Autor do
  defstruct nombre: "", cedula: "", programa: "", titulo: ""

  def construir() do

    nombre = "ingrese el nombre: "
    |> Util.ingresar(:texto)

    cedula = "ingrese la cedula: "
    |> Util.ingresar(:texto)

    programa = "ingrese el programa: "
    |> Util.ingresar(:texto)

    titulo = "ingrese el titulo: "
    |> Util.ingresar(:texto)

    autor = %Autor{nombre: nombre, cedula: cedula, programa: programa, titulo: titulo}

    escribir_csv(autor)

  end

  def buscar(cedula, lista) do
    Enum.filter(lista, fn autor -> autor.cedula == cedula end)
  end

  def escribir_csv(autor) do
    datos = "Nombre: #{autor.nombre}, Cedula: #{autor.cedula}, Programa: #{autor.programa}, Titulo: #{autor.titulo}\n"
    File.write("autores.csv", datos, [:append])
  end

end

defmodule Trabajo do
  defstruct fecha: "", titulo: "", descripcion: "", autores: []

  def construir() do
    fecha = "ingrese la fecha: "
    |> Util.ingresar(:texto)

    titulo = "ingrese el titulo: "
    |> Util.ingresar(:texto)

    descripcion = "ingrese la descripcion: "
    |> Util.ingresar(:texto)

    cantidad = "¿Cuántos autores tiene el trabajo? "
    |> Util.ingresar(:entero)

    autores = for _ <- 1..cantidad, do: Autor.construir()

    trbajo = %Trabajo{fecha: fecha, titulo: titulo, descripcion: descripcion, autores: autores}

    escribir_csv(trbajo)

  end

  def buscar(titulo, lista) do
    Enum.filter(lista, fn trabajo -> trabajo.titulo == titulo end)
  end

  def escribir_csv(trabajo) do
    datos = "Fecha: #{trabajo.fecha}, Titulo: #{trabajo.titulo}, Descrpicion: #{trabajo.descripcion}, Autores: #{trabajo.autores} \n "
    File.write("trabajos.csv", datos, :append)
  end
end
