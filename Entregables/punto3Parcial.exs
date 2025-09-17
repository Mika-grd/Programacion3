defmodule Tres do
  defp longitud(contrasena) do
    if Enum.count(contrasena) >= 8 do
      {:ok, "Correcta", contrasena}
    else
      {:error, "debe tener al menos 8 caracteres", contrasena}
    end
  end

  defp mayuscula({:ok, "Correcta", contrasena}) do
    if Enum.any?(contrasena, fn x -> x != String.downcase(x) end) do
      {:ok, "Correcta", contrasena}
    else
      {:error, "Debe tener al menos 1 mayúscula", contrasena}
    end
  end
  defp mayuscula({:error, msg, contrasena}) do
    if Enum.any?(contrasena, fn x -> x != String.downcase(x) end) do
      {:error, msg, contrasena}
    else
      {:error, msg <> " Debe tener al menos 1 mayúscula.", contrasena}
    end
  end

  defp numero({:ok, "Correcta", contrasena}) do
    if Enum.any?(contrasena, fn x ->
         try do
           _ = String.to_integer(x)
           true
         rescue
           _ -> false
         end
       end) do
      {:ok, "Correcta", contrasena}
    else
      {:error, "Debe tener al menos 1 numero", contrasena}
    end
  end
  defp numero({:error, msg, contrasena}) do
    if Enum.any?(contrasena, fn x ->
         try do
           _ = String.to_integer(x)
           true
         rescue
           _ -> false
         end
       end) do
      {:error, msg, contrasena}
    else
      {:error, msg <> " Debe tener al menos 1 numero.", contrasena}
    end
  end

  defp espacio({:ok, "Correcta", contrasena}) do
    if Enum.any?(contrasena, fn x -> x == " " end) do
      {:error, "No debe contener espacios", contrasena}
    else
      {:ok, "Correcta", contrasena}
    end
  end
  defp espacio({:error, msg, contrasena}) do
    if Enum.any?(contrasena, fn x -> x == " " end) do
      {:error, msg <> " No debe contener espacios.", contrasena}
    else
      {:error, msg, contrasena}
    end
  end

  def revisar_contrasena(contrasena) do
    String.graphemes(contrasena)
    |> longitud()
    |> mayuscula()
    |> numero()
    |> espacio()
  end
end

contrasena = Util.ingresar("ingrese la contraseña: ", :texto)
IO.inspect(Tres.revisar_contrasena(contrasena))
