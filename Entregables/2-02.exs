defmodule Interoperabilidad do
  @moduledoc """
  ## Módulo Interoperabilidad
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 26 de agosto de 2025
  **Licencia:** GNU GPL V3

  Este módulo implementa tres ejercicios que muestran la comunicación entre
  programas escritos en Java y scripts en Elixir.

  ### Ejercicio 1: Eco de mensaje
  - Java envía un mensaje a Elixir.
  - Elixir retorna el mismo mensaje en mayúscula.
  - Java lo muestra en pantalla.

  ### Ejercicio 2: Longitud de una palabra
  - Java envía una palabra ingresada por el usuario.
  - Elixir devuelve la cantidad de letras de esa palabra.
  - Java muestra el número.

  ### Ejercicio 3: Cálculo de salario neto
  - Java captura mediante formulario:
      - Nombre
      - Horas trabajadas
      - Valor por hora
  - Elixir calcula el salario neto:
      - Hasta 160 horas → salario base.
      - Más de 160 horas → horas extra pagadas al 125%.
  - Elixir retorna un mensaje con el salario neto del empleado.
  - Java lo muestra en un `JOptionPane`.
  """

  @doc """
  Función principal.

  Recibe los argumentos enviados desde Java y despacha al ejercicio
  correspondiente.

  ## Parámetros:
    - `args` (`[String.t]`): Lista de argumentos enviados desde Java.

  Los casos posibles son:
    - `["eco", mensaje]`
    - `["longitud", palabra]`
    - `["salario", nombre, horas_trabajadas, valor_por_hora]`
  """
  def main(args) do
    case args do
      ["eco", mensaje] ->
        eco_mensaje(mensaje) |> Util.mostrar_mensaje()

      ["longitud", palabra] ->
        longitud_palabra(palabra) |> Util.mostrar_mensaje()

      ["salario", nombre, horas_str, valor_hora_str] ->
        with {horas, _} <- Integer.parse(horas_str),
             {valor_hora, _} <- Float.parse(valor_hora_str) do
          calcular_salario(nombre, horas, valor_hora)
          |> Util.mostrar_mensaje()
        else
          _ -> Util.mostrar_error("Error: parámetros inválidos para salario.")
        end

      _ ->
        Util.mostrar_error("Error: argumentos no válidos")
    end
  end

  @doc """
  ## Ejercicio 1: Eco de mensaje
  Retorna el mensaje recibido en mayúsculas.

  ## Parámetros:
    - `mensaje` (`String.t`): Mensaje enviado desde Java.

  ## Retorno:
    - Mensaje en mayúsculas (`String.t`).
  """
  defp eco_mensaje(mensaje) do
    mensaje
    |> String.upcase()
  end

  @doc """
  ## Ejercicio 2: Longitud de palabra
  Retorna la cantidad de caracteres de una palabra.

  ## Parámetros:
    - `palabra` (`String.t`): Palabra enviada desde Java.

  ## Retorno:
    - Número de letras convertido a cadena (`String.t`), listo para mostrar.
  """
  defp longitud_palabra(palabra) do
    palabra
    |> String.length()
    |> Integer.to_string()
  end

  @doc """
  ## Ejercicio 3: Cálculo de salario neto

  Calcula el salario neto de un empleado.

  - Si trabaja hasta 160 horas → salario base.
  - Si trabaja más de 160 horas → horas extra al 125%.

  ## Parámetros:
    - `nombre` (`String.t`): Nombre del empleado.
    - `horas_trabajadas` (`integer`): Número de horas trabajadas.
    - `valor_hora` (`float`): Valor de la hora trabajada.

  ## Retorno:
    - Cadena con el salario neto del empleado.
  """
  defp calcular_salario(nombre, horas_trabajadas, valor_hora) do
    if horas_trabajadas > 160 do
      horas_extra = horas_trabajadas - 160
      salario_base = 160 * valor_hora
      salario_extra = horas_extra * valor_hora * 1.25
      salario_total = salario_base + salario_extra

      "Empleado #{nombre}, su salario neto es $#{Float.round(salario_total, 2)}"
    else
      salario_total = horas_trabajadas * valor_hora
      "Empleado #{nombre}, su salario neto es $#{Float.round(salario_total, 2)}"
    end
  end
end


Interoperabilidad.main(["eco", "hola mundo"])
Interoperabilidad.main(["longitud", "programacion"])
Interoperabilidad.main(["salario", "Carlos", "170", "25.5"])
