defmodule Descuento do
  @moduledoc """
  ## Módulo Descuento
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 26 de agosto de 2025
  **Licencia:** GNU GPL V3

  Este módulo implementa un ejercicio que calcula el descuento y el valor final
  de un producto a partir del valor inicial y un porcentaje ingresado por el cliente.

  Flujo de la aplicación:
  1. Solicita el valor del producto.
  2. Solicita el porcentaje de descuento.
  3. Calcula el valor del descuento.
  4. Calcula el valor final del producto.
  5. Muestra los resultados en un mensaje.
  """

  @doc """
  Función principal de la aplicación.

  Solicita al usuario:
    - El valor del producto (entero).
    - El porcentaje de descuento (real).

  Luego:
    - Calcula el valor del descuento.
    - Calcula el valor final.
    - Muestra un mensaje con los resultados.
  """
  def main do
    valor_producto =
      "Ingrese el valor del producto: "
      |> Util.ingresar(:entero)

    porcentaje_descuento =
      "Ingrese el porcentaje de descuento: "
      |> Util.ingresar(:real)

    valor_descuento = calcular_valor_descuento(valor_producto, porcentaje_descuento)
    valor_final = calcular_valor_final(valor_producto, valor_descuento)

    generar_mensaje(valor_descuento, valor_final)
    |> Util.mostrar_mensaje()
  end

  @doc """
  Calcula el valor del descuento.

  ## Parámetros:
    - `valor_producto` (`integer` o `float`): El valor inicial del producto.
    - `porcentaje_descuento` (`float`): El porcentaje de descuento expresado como decimal (ej: 0.2 para 20%).

  ## Retorno:
    - Valor del descuento (`float`).
  """
  defp calcular_valor_descuento(valor_producto, porcentaje_descuento) do
    valor_producto * porcentaje_descuento
  end

  @doc """
  Calcula el valor final del producto restando el descuento.

  ## Parámetros:
    - `valor_producto` (`integer` o `float`): Valor inicial del producto.
    - `valor_descuento` (`float`): Monto del descuento.

  ## Retorno:
    - Valor final (`float`).
  """
  defp calcular_valor_final(valor_producto, valor_descuento) do
    valor_producto - valor_descuento
  end

  @doc """
  Genera el mensaje de salida con los resultados.

  El mensaje incluye:
    - El valor del descuento (redondeado a 1 decimal).
    - El valor final del producto (redondeado a 1 decimal).

  ## Retorno:
    - Cadena de texto con los valores listos para mostrar.
  """
  defp generar_mensaje(valor_descuento, valor_final) do
    valor_descuento = Float.round(valor_descuento, 1)
    valor_final = Float.round(valor_final, 1)

    "Valor de descuento de $#{valor_descuento} y el valor final $#{valor_final}"
  end
end

Descuento.main()
