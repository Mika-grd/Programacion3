defmodule Util do
  @moduledoc """
  ## Módulo Util
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 26 de agosto de 2025

  Este módulo contiene funciones auxiliares para:
  - Mostrar mensajes en consola o en error estándar.
  - Solicitar datos al usuario en distintos formatos (`:texto`, `:entero`, `:real`).
  - Invocar un programa Java externo con parámetros.

  Proporciona una interfaz sencilla para entradas/salidas en aplicaciones de consola.
  """

  @doc """
  Ejecuta un programa Java externo enviando un mensaje como argumento.

  ## Parámetros:
    - `mensaje` (`String.t`): Texto que se enviará al programa Java.

  ## Retorno:
    - Una tupla `{salida, codigo}` con la salida del proceso y el código de salida.
  """
  def mostrar_mensaje_java(mensaje) do
    System.cmd("java", ["funcional1", mensaje])
  end

  @doc """
  Imprime un mensaje en la salida estándar.

  ## Parámetros:
    - `mensaje` (`String.t`): Texto a mostrar.

  ## Ejemplo:
      iex> Util.mostrar_mensaje("Hola")
      Hola
  """
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  @doc """
  Muestra un mensaje en la salida de error estándar.

  ## Parámetros:
    - `mensaje` (`String.t`): Texto de error a mostrar.
  """
  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  @doc """
  Solicita una entrada de texto desde la consola.

  ## Parámetros:
    - `mensaje` (`String.t`): Texto de instrucción para el usuario.

  ## Retorno:
    - Cadena de texto ingresada (sin saltos de línea).
  """
  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  @doc """
  Solicita al usuario que ingrese un número entero.

  ## Parámetros:
    - `mensaje` (`String.t`): Texto de instrucción para el usuario.

  ## Manejo de errores:
    - Si el valor ingresado no es un entero válido, se muestra un error
      y se vuelve a solicitar la entrada.

  ## Retorno:
    - Número entero ingresado.
  """
  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_integer()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número entero\n"
        |> mostrar_error()

        mensaje
        |> ingresar(:entero)
    end
  end

  @doc """
  Solicita al usuario que ingrese un número real (decimal).

  ## Parámetros:
    - `mensaje` (`String.t`): Texto de instrucción para el usuario.

  ## Manejo de errores:
    - Si el valor ingresado no es un número real válido, se muestra un error
      y se vuelve a solicitar la entrada.

  ## Retorno:
    - Número real ingresado.
  """
  def ingresar(mensaje, :real) do
    try do
      mensaje
      |> Util.ingresar(:texto)
      |> String.to_float()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número real\n"
        |> Util.mostrar_error()

        mensaje |> Util.ingresar(:real)
    end
  end
end
