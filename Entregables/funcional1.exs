defmodule Funcional1 do
  def mostrar_mensaje do
    "Bienvenidos a la empresa Once Ltda"
    |> Util.mostrar_mensaje()
  end
end

Funcional1.mostrar_mensaje()
