defmodule Hilos do
  @aforoMaximo 5

  def iniciar_semaforo() do
    spawn(fn -> semaforo(0) end)
  end

  defp semaforo(aforo_actual) do
    receive do
      {:entrar, vehiculo, tiempo} when aforo_actual < @aforoMaximo ->
        Util.mostrar_mensaje("Carro #{vehiculo} entra. Aforo: #{aforo_actual + 1}")
        spawn(fn -> estadia(vehiculo, tiempo, self()) end)
        semaforo(aforo_actual + 1)
      {:entrar, vehiculo, _tiempo} ->
        Util.mostrar_mensaje("Carro #{vehiculo} NO puede entrar. Aforo lleno.")
        semaforo(aforo_actual)
      {:salir, vehiculo} ->
        Util.mostrar_mensaje("Carro #{vehiculo} sale. Aforo: #{aforo_actual - 1}")
        semaforo(aforo_actual - 1)
    end
  end

  defp estadia(vehiculo, tiempo, semaforo_pid) do
    Util.mostrar_mensaje("Carro #{vehiculo} está adentro por #{tiempo} ms")
    :timer.sleep(tiempo)
    send(semaforo_pid, {:salir, vehiculo})
  end

  def entrar_vehiculo(semaforo_pid, vehiculo, tiempo) do
    send(semaforo_pid, {:entrar, vehiculo, tiempo})
  end

end

sem = Hilos.iniciar_semaforo()
for i <- 1..7 do
Hilos.entrar_vehiculo(sem, i, 2000 + i*500)
end
