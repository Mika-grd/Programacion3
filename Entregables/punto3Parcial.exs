defmodule Parcial do

  # This is for the first point of the exam
  def calcular_costo_envio()do
    peso = Util.ingresar("Ingrese el peso del paquete en kg: ", :entero)

    tipo_cliente = determinar_tipo(Util.ingresar("Ingrese el tipo de cliente (corporativo, estudiante, regular): ", :texto))

    servicio = determinar_recargo(Util.ingresar("Ingrese el tipo de servicio (express, standard): ", :texto))

    base = calcular_base(peso)

    {descuento, subtotal} = aplicar_descuento(base, tipo_cliente)

    {recargo, total} = aplicar_recargo(subtotal, servicio)

    IO.puts("La tarifa base es: $#{base}. El descuento es de :$#{descuento}. El subtotal es: $#{subtotal}. El recargo por el tipo de servicio es: $#{recargo}. El costo de envío es: $#{total}")
  end

  defp calcular_base(peso) when peso <= 0 do
    IO.puts("El peso debe ser un número positivo.")
  end
  defp calcular_base(peso) do
    cond do
      peso <= 1 -> peso * 8_000
      peso <= 5 -> peso * 12_000
      peso > 5 -> peso * 20_000
    end
  end

  defp determinar_tipo(tipo_cliente) do
    case String.downcase(tipo_cliente) do
      "corporativo" -> :corporativo
      "estudiante" -> :estudiante
      "regular" -> :regular
      _ -> IO.puts("Tipo de cliente no válido. Se aplicará tarifa regular.")
           :regular
    end
  end

  defp aplicar_descuento(base, :corporativo) do
    descuento = base * 0.15
    subtotal = base - descuento
    {descuento, subtotal}
  end

  defp aplicar_descuento(base, :estudiante) do
    descuento = base * 0.10
    subtotal = base - descuento
    {descuento, subtotal}
  end

  defp aplicar_descuento(base, :regular) do
    {0, base}
  end

  defp determinar_recargo(servicio) do
    case String.downcase(servicio) do
      "express" -> 0.20
      "standard" -> 0
      _ -> IO.puts("Tipo de servicio no válido. Se aplicará recargo estándar.")
           0
    end
  end

  defp aplicar_recargo(subtotal, recargo) do
    recargo_monto = subtotal * recargo
    total = subtotal + recargo_monto
    {recargo_monto, total}
  end

  # This is for the second point of the exam
  def reservar_sillas(cine, sala, sillas) do
    if Map.has_key?(cine, sala) do
      Map.update(cine, sala, "no hay suficientes sillas", fn x ->
        if x >= sillas do
          x - sillas
        else
          "no hay suficientes sillas"
        end
      end)
    else
      {:error, "Sala no encontrada"}
    end
  end



  #All of this is for the third point of the exam
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


#Para la 1

Parcial.calcular_costo_envio()

#Para la 2

cine = %{
  "sala1" => 50,
  "sala2" => 30,
  "sala3" => 20
}

sala = Util.ingresar("Ingrese la sala (sala1, sala2, sala3): ", :texto)
sillas = Util.ingresar("Ingrese la cantidad de sillas a reservar: ", :entero)

IO.inspect(Parcial.reservar_sillas(cine, sala, sillas))

#Para la 3
contrasena = Util.ingresar("ingrese la contraseña: ", :texto)
IO.inspect(Parcial.revisar_contrasena(contrasena))
