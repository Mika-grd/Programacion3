defmodule Carrera do
  @moduledoc """
  Simula una carrera concurrente entre varios animales.

  - Lanza un proceso por cada animal.
  - Cada proceso avanza de forma aleatoria y notifica al proceso principal
    sobre su progreso y llegada a la meta.
  - El proceso principal recibe mensajes y muestra el estado de la carrera.

  """

  @meta 50

  @doc "Inicia la carrera: crea procesos para los animales y espera los resultados."
  def iniciar do
    animales = ["Tortuga", "Liebre", "Perro", "Gato"]

    IO.puts("🏁 ¡Comienza la carrera de animales!\n")

    # Lanzamos un proceso por cada animal; cada proceso ejecuta `correr/2`.
    juez = self()
    Enum.each(animales, fn animal ->
      spawn(fn -> correr(animal, juez) end)
    end)

    # El proceso actual actúa como juez y espera los resultados.
    esperar_resultados(length(animales), [])
  end

  @doc false
  # Inicia la rutina de avance para un animal.
  defp correr(animal, juez_pid) do
    avanzar(animal, 0, juez_pid)
  end

  @doc false
  # Avanza al animal hasta que alcanza la meta. Envía mensajes de progreso al juez.
  defp avanzar(animal, distancia, juez_pid) when distancia < @meta do
    paso = Enum.random(1..5)
    nueva_distancia = distancia + paso
    # Simula tiempo de avance
    Process.sleep(Enum.random(100..400))

    # Notifica progreso (se recorta a la meta si se supera)
    send(juez_pid, {:progreso, animal, min(nueva_distancia, @meta)})

    avanzar(animal, nueva_distancia, juez_pid)
  end

  @doc false
  # Caso cuando el animal ya alcanzó o superó la meta: notifica llegada.
  defp avanzar(animal, _distancia, juez_pid) do
    send(juez_pid, {:llego, animal})
  end

  @doc false
  # Recibe mensajes de los procesos y acumula el orden de llegada.
  defp esperar_resultados(0, resultados) do
    IO.puts("\n=== RESULTADOS FINALES ===")
    Enum.reverse(resultados)
    |> Enum.with_index(1)
    |> Enum.each(fn {animal, pos} ->
      IO.puts("#{pos}. #{animal}")
    end)
  end

  @doc false
  # Espera mensajes de progreso o llegada. 'pendientes' es el número de animales
  # que aún no han terminado; 'resultados' acumula los que ya llegaron.
  defp esperar_resultados(pendientes, resultados) do
    receive do
      {:progreso, animal, distancia} ->
        IO.puts("#{animal} avanza a #{distancia}/#{@meta}")
        esperar_resultados(pendientes, resultados)

      {:llego, animal} ->
        IO.puts("🏁 #{animal} ha llegado a la meta!")
        esperar_resultados(pendientes - 1, [animal | resultados])
    end
  end
end

Carrera.iniciar()
