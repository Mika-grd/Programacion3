defmodule Quizz do

  def encontrar_mayor_lista([], mayor) do
    mayor
  end

  def encontrar_mayor_lista([head|tail], acc)do
    encontrar_mayor_lista(tail, max(acc, head))
  end
end

IO.puts(Quizz.encontrar_mayor_lista([1, 2, 3, 4, 5, 6, 7, 8], 0))
