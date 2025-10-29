defmodule IPC do

  def main do
    Util.mostrar_mensaje("PROCESO PRINCIPAL")

    crear_servicio()
    |> producir_elementos()

    recibir_respuestas()

  end

  def producir_elementos(servicio) do
    {:mayus, "Diana"} |> enviar_mensaje(servicio)
    {:mayus, "Juana"} |> enviar_mensaje(servicio)
    {:minus, "Ana"} |> enviar_mensaje(servicio)
    {&String.reverse/1, "Julian"} |> enviar_mensaje(servicio)

    "Uniquindio" |> enviar_mensaje(servicio)

    :fin |> enviar_mensaje(servicio)

  end

  defp crear_servicio(),
    do: spawn(IPC, :activar_servicio, [])

  defp enviar_mensaje(mensaje, servicio),
    do: send(servicio, {self(), mensaje})

    def activar_servicio() do
      receive do
        {productor, :fin} -> send(productor, :fin)

        {productor, {:mayus, mensae}} -> send(productor, String.upcase(mensae))
        activar_servicio()

        {productor, {:minus, mensae}} -> send(productor, String.downcase(mensae))
        activar_servicio()

        {productor, {funcion, mensae}} -> send(productor, funcion.(mensae))
        activar_servicio()

        {productor, {:mayus, mensae}} -> send(productor, "El mensaje \" #{mensae}\" es desconocido.")
        activar_servicio()
      end
    end

    def recibir_respuestas() do
      receive do
        :fin -> :ok
        mensaje -> Util.mostrar_mensaje("\t-> #{mensaje}")
      end
      recibir_respuestas()
    end

end

IPC.main()
