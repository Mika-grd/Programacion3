defmodule Tres do

  defp longitud(contrasena) do
    if Enum.count(contrasena) >= 8 do
      {:ok, "Correcta", contrasena}
    else
      {:error, "debe tener al menos 8 caracteres", contrasena}
    end
  end

  defp mayuscula(mensaje) do
    contrasena = elem(mensaje, 2)

    if Enum.any?(contrasena, fn x -> x != String.downcase(x) end) do
      mensaje
    else
      {:error, "#{elem(mensaje, 1)}\nDebe tener al menos 1 mayúscula", contrasena}
    end
  end

  defp numero(mensaje) do
    contrasena = elem(mensaje, 2)

    if Enum.any?(contrasena, fn x ->
         try do
           _ = String.to_integer(x)
           true
         rescue
           _ -> false
         end
       end) do
      mensaje
    else
      {:error, "#{elem(mensaje, 1)}\nDebe tener al menos 1 numero", contrasena}
    end
  end

  defp espacio(mensaje) do
    contrasena = elem(mensaje, 2)

    if Enum.any?(contrasena, fn x -> x == " " end) do
      {:error, "#{elem(mensaje, 1)}\nNo debe contener espacios", contrasena}
    else
      mensaje
    end
  end

  def revisar_contrasena(contrasena) do
    chars = String.graphemes(contrasena)

    resultado = longitud(chars)
    resultado = mayuscula(resultado)
    resultado = numero(resultado)
    resultado = espacio(resultado)

    resultado
  end
end

contrasena = Util.ingresar("ingrese la contraseña: ", :texto)
IO.inspect(Tres.revisar_contrasena(contrasena))
