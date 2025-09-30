defmodule Estructuras do
  def main do
    "Ingrese los datos del cliente: "
    |>Cliente.ingresar()
    |>generar_mensaje()
    |>Util.mostrar_mensaje()
  end

  def generar_mensaje(cliente) do
    "Hola #{cliente.nombre}, tienes una edad de #{cliente.edad} y una altura de #{cliente.altura} :p"
  end
end


Estructuras.main()
