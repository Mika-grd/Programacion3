defmodule NodoCliente do
  @nombre_servicio_remoto :servicio_trabajos
  @nodo_remoto :nodoservidor@localhost
  @servicio_remoto {@nombre_servicio_remoto, @nodo_remoto}

  def main() do
    Util.mostrar_mensaje("BIENVENIDO CLIENTE")
    buscar_autores("Mi Titulo")
    mostrar_trabajos()
    enviar_fin()
    recibir_respuestas()
  end

  def buscar_autores(titulo) do
    send(@servicio_remoto, {self(), {:buscar, titulo}})
  end

  def mostrar_trabajos() do
    send(@servicio_remoto, {self(), {:mostrar, nil}})
  end

  def enviar_fin() do
    send(@servicio_remoto, {self(), :fin})
  end

  def recibir_respuestas() do
    receive do
      :fin -> :ok
      respuesta ->
        IO.inspect(respuesta)
        recibir_respuestas()
    end
  end
end

NodoCliente.main()
