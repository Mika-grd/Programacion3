defmodule DivideYVenceras do
  @moduledoc """
  ## Módulo DivideYVenceras
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 23 de septiembre de 2025
  **Licencia:** GNU GPL V3

  Este módulo implementa un algoritmo de divide y vencerás para recorrer una lista.
  La estrategia consiste en dividir recursivamente la lista por la mitad hasta
  llegar a elementos individuales, momento en el cual los imprime.

  ### Funcionamiento:
  - Si la lista está vacía, retorna `:ok`.
  - Si la lista tiene un solo elemento, lo imprime.
  - Si la lista tiene múltiples elementos, la divide por la mitad y procesa
    recursivamente cada mitad por separado.

  ### Ejemplo de uso:
      DivideYVenceras.recorrer([1, 2, 3, 4, 5])
      # Imprime:
      # Número: 1
      # Número: 2
      # Número: 3
      # Número: 4
      # Número: 5
  """

  @doc """
  Caso base: lista vacía.

  ## Parámetros:
    - `[]`: Lista vacía.

  ## Retorno:
    - `:ok`: Indica finalización exitosa.
  """
  def recorrer([]), do: :ok

  @doc """
  Caso base: lista con un solo elemento.

  Imprime el elemento individual en formato "Número: X".

  ## Parámetros:
    - `[x]`: Lista con un único elemento.

  ## Comportamiento:
    - Imprime el elemento en consola.
  """
  def recorrer([x]) do
    IO.puts("Número: #{x}")
  end

  @doc """
  Caso recursivo: lista con múltiples elementos.

  Divide la lista por la mitad y procesa recursivamente cada mitad.
  La división se realiza en el punto medio calculado con `div(length(lista), 2)`.

  ## Parámetros:
    - `lista`: Lista con dos o más elementos.

  ## Comportamiento:
    - Calcula el punto medio de la lista.
    - Divide la lista en dos sublistas: izquierda y derecha.
    - Procesa recursivamente primero la sublista izquierda.
    - Procesa recursivamente después la sublista derecha.

  ## Ejemplo:
      recorrer([1, 2, 3, 4])
      # Se divide en [1, 2] y [3, 4]
      # Procesa [1, 2] -> divide en [1] y [2] -> imprime ambos
      # Procesa [3, 4] -> divide en [3] y [4] -> imprime ambos
  """
  def recorrer(lista) do
    {izq, der} = Enum.split(lista, div(length(lista), 2))
    recorrer(izq)
    recorrer(der)
  end
end

DivideYVenceras.recorrer([1, 2, 3, 4, 5])
