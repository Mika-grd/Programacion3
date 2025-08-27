defmodule Devuelta do
  @moduledoc """
  ## Módulo Devuelta
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 26 de agosto de 2025
  **Licencia:** GNU GPL V3

  Este módulo permite calcular la devuelta (cambio) en una transacción de pago.

  Flujo de la aplicación:
  1. Solicita el valor total de la factura.
  2. Solicita el valor entregado por el cliente.
  3. Calcula la devuelta restando ambos valores.
  4. Genera y muestra un mensaje con el resultado.
  """

  @doc """
  Función principal de la aplicación.

  Solicita al usuario:
    - El valor total de la factura (entero).
    - El valor entregado por el cliente (entero).

  Luego:
    - Calcula la devuelta.
    - Genera el mensaje con el resultado.
    - Muestra el mensaje en consola.
  """
  def main do
    valor_total =
      "Ingrese valor total de la factura: "
      |> Util.ingresar(:entero)

    valor_entregado =
      "Ingrese valor entregado para el pago: "
      |> Util.ingresar(:entero)

    calcular_devuelta(valor_entregado, valor_total)
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end

  @doc """
  Calcula la cantidad de dinero que debe devolverse al cliente.

  ## Parámetros:
    - `valor_pagado` (`integer`): Valor entregado por el cliente.
    - `valor_total` (`integer`): Valor total de la factura.

  ## Retorno:
    - Devuelta (`integer`): Diferencia entre lo pagado y el valor de la factura.
  """
  def calcular_devuelta(valor_pagado, valor_total) do
    valor_pagado - valor_total
  end

  @doc """
  Genera el mensaje de salida mostrando el valor de la devuelta.

  ## Parámetros:
    - `devuelta` (`integer`): Valor calculado de la devuelta.

  ## Retorno:
    - Cadena de texto con el resultado.
  """
  defp generar_mensaje(devuelta) do
    "El valor de devuelta es $ #{devuelta}"
  end
end

Devuelta.main()
