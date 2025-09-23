defmodule Matrioshka do
  @moduledoc """
  ## Módulo Matrioshka
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 23 de septiembre de 2025
  **Licencia:** GNU GPL V3

  Este módulo simula el proceso de abrir matrioshkas (muñecas rusas anidadas).
  Implementa un contador recursivo que muestra el progreso de abrir cada nivel
  de matrioshkas hasta llegar al final.

  ### Funcionamiento:
  - Solicita al usuario la cantidad inicial de matrioshkas.
  - Cuenta recursivamente desde el nivel 1 hasta agotar todas las matrioshkas.
  - Muestra mensajes descriptivos para cada nivel.
  - Maneja casos especiales para la primera matrioshka y el final.

  ### Ejemplo de uso:
      Matrioshka.contar_mostrar_matrioshkas()
      # Entrada: 3
      # Salida:
      # Hay una matrioshka.
      # Ahora hay 2 matrioshkas!
      # Ahora hay 3 matrioshkas!
      # No hay más matrioshkas :(
  """

  @doc """
  Función principal de la aplicación.

  Solicita al usuario la cantidad de matrioshkas e inicia el proceso de conteo.

  ## Comportamiento:
    - Solicita la cantidad de matrioshkas al usuario mediante `Util.ingresar/2`.
    - Inicia el conteo recursivo desde el nivel 1.

  ## Retorno:
    - Resultado de la función `contar_mostrar/2`.
  """
  def contar_mostrar_matrioshkas() do
    n = Util.ingresar("Ingrese la cantidad de matrioshkas: ", :entero)
    contar_mostrar(n, 1)
  end

  @doc """
  Caso base: no quedan más matrioshkas.

  ## Parámetros:
    - `0`: Número de matrioshkas restantes.
    - `_nivel`: Nivel actual (ignorado en este caso).

  ## Comportamiento:
    - Imprime mensaje de finalización.
  """
  def contar_mostrar(0, _nivel) do
    IO.puts("No hay más matrioshkas :(")
  end

  @doc """
  Caso especial: primera matrioshka.

  Maneja el mensaje específico para la primera matrioshka con texto singular.

  ## Parámetros:
    - `n`: Número de matrioshkas restantes.
    - `1`: Nivel actual (primera matrioshka).

  ## Comportamiento:
    - Imprime mensaje especial para la primera matrioshka.
    - Continúa recursivamente con el siguiente nivel.
  """
  def contar_mostrar(n, 1) do
    IO.puts("Hay una matrioshka.")
    contar_mostrar(n - 1, 2)
  end

  @doc """
  Caso recursivo: matrioshkas nivel 2 en adelante.

  Maneja el conteo para todos los niveles después del primero.

  ## Parámetros:
    - `n`: Número de matrioshkas restantes.
    - `nivel`: Nivel actual de matrioshkas (2 o mayor).

  ## Comportamiento:
    - Imprime el número actual de matrioshkas en formato plural.
    - Decrementa el contador y avanza al siguiente nivel.
    - Continúa recursivamente hasta agotar todas las matrioshkas.

  ## Ejemplo:
      contar_mostrar(3, 2)
      # Imprime: "Ahora hay 2 matrioshkas!"
      # Llama recursivamente a contar_mostrar(2, 3)
  """
  def contar_mostrar(n, nivel) do
    IO.puts("Ahora hay #{nivel} matrioshkas!")
    contar_mostrar(n - 1, nivel + 1)
  end
end

Matrioshka.contar_mostrar_matrioshkas()
