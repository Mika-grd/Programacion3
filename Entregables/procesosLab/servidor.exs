defmodule NodoServidor do
  @nombre_servicio_local :servicio_trabajos

  def buscar_autores_trabajo(titulo) do

  end

  def main() do
    Util.mostrar_mensaje("SERVIDOR UNIQUINDIO")
    registrar_servicio(@nombre_servicio_local)
    procesar_mensajes()
  end

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_mensajes() do
    receive do
      {productor, mensaje} ->
        respuesta = procesar_mensaje(mensaje)
        send(productor, respuesta)
        if respuesta != :fin, do: procesar_mensajes()
    end
  end

  defp procesar_mensaje(:fin), do: :fin
  defp procesar_mensaje({:mostrar, nil}), do: File.read("trabajos.csv")
  defp procesar_mensaje({:buscar, titulo}) do

    trabajo = datos.Trabajo.buscar(titulo)

    autores = trabajo.autores

    autores

  end
end

NodoServidor.main()
