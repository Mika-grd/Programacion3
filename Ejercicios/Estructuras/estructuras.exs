defmodule Estructuras do

  def crear_lista_clientes do
  [
    Cliente.crear("Ana", 16, 1.70),
    Cliente.crear("Juan", 20, 1.72),
    Cliente.crear("Diana", 48, 1.71),
    Cliente.crear("Julian", 51, 1.73),
    Cliente.crear("Isbella", 6, 1.00),
    Cliente.crear("Sara", 8, 1.30)
  ]
  end

  def main do
    "Ingrese los datos del cliente: "
    |>Cliente.ingresar(:clientes)
    |>Cliente.generar_mensaje_clientes(&generar_mensaje/1)
    |>Util.mostrar_mensaje()
  end

  def main2 do
  crear_lista_clientes()
  |> Cliente.escribir_csv("clientes.csv")
  end

  def generar_mensaje(cliente) do
    "Hola #{cliente.nombre}, tienes una edad de #{cliente.edad} y una altura de #{cliente.altura}\n"
  end
end


Estructuras.main2()
