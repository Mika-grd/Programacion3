defmodule Taller do


  #Punto numero 1: Contar elementos pares en una lista
  def contar_pares([]) do
    0
  end

  def contar_pares([head|tail]) do
    if rem(head, 2) == 0 do
      1 + contar_pares(tail)
    else
      contar_pares(tail)
    end
  end

  def contar_pares_con_acc(lista) do
    contar_pares_acc(lista, 0)
  end

  defp contar_pares_acc([], acc) do
    acc
  end

  defp contar_pares_acc([head|tail], acc) do
    if rem(head, 2) == 0 do
      contar_pares_acc(tail, acc + 1)
    else
      contar_pares_acc(tail, acc)
    end
  end


  #Punto numero dos: Invertir una lista sin usar Enum.reverse

  defp helper_reverse([x], list) do
    [x|list]
  end

  defp helper_reverse([head|tail], list) do
    helper_reverse(tail, [head|list])
  end

  def reverse(list) do
    helper_reverse(list, [])
  end

  #Punto numero 3: Sumar todos los elementos de una matriz (lista de listas)

  def sum_matrix([head|tail]) do
    sum_list(head) + sum_matrix(tail)
  end

  def sum_matrix([x]) do
    sum_list(x)
  end

  def sum_matrix([]) do
    0
  end

  defp sum_list([head|tail]) do
    head + sum_list(tail)
  end

  defp sum_list([x]) do
    x
  end

  defp sum_list([]) do
    0
  end

  #Punto numero 4: Transposición de una matriz
  #[[1,2,3], [4, 5, 6]] -> [[1, 4], [2, 5], [3, 6]]

  def matrix_transposition([]) do
    []
  end

  def matrix_transposition([head|tail]) do
    zip_rows(rows(head), matrix_transposition(tail))
  end

  def matrix_transposition([x])do
    rows([x])
  end

  defp rows([head|tail]) do
    [[head]|rows(tail)]
  end

  defp rows([]) do
    []
  end

  defp rows([x]) do
    [[x]]
  end

  defp zip_rows([h1|t1], [h2|t2]) do
    [h1 ++ h2 | zip_rows(t1, t2)]
  end

  defp zip_rows(rows, []) do
    rows
  end

  #Punto numero 5: Resolver una suma objetivo con combinaciones de una lista jajaj es DP

  #candidates = [2,3,6,7], target = 7 Output: [[2,2,3],[7]]

  def allTheWay(list, current, target, acc, totalCurrents) do
    Enum.reduce(list, totalCurrents, fn x, acc_total ->
      if x + acc == target do
        new_combination = current ++ [x]
        acc_total ++ [new_combination]
      else
        if x + acc < target do
          allTheWay(list, current ++ [x], target, x + acc, acc_total)
        else
          acc_total
        end
      end
    end)
  end

end


IO.inspect(Taller.reverse([1, 2, 3, 4]))

IO.puts(Taller.sum_matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10]]))

IO.puts("Matrix transposition:")
IO.inspect(Taller.matrix_transposition([[1,2,3], [4,5,6]]))

IO.puts("Combination sum [2,3,6,7] target 7:")
IO.inspect(Taller.allTheWay([2,3,6,7], [], 7, 0, []), charlists: :as_lists)
