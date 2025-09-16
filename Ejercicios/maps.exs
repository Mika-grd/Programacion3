#TODO: sumar los elementos de un mapa con el Enum.reduce e imprimir el valor
#El parcial va solo hasta reduce btw


mi_mapa = %{"nombre" => "Elixir", "version" => "1.15"}

mi_mapa_atom = %{nombre: "ELixir" , version: 1.15}

IO.puts("#{inspect(mi_mapa)}\n#{inspect(mi_mapa_atom)}")

version = Map.get(mi_mapa_atom, "version", "No existe esa clave")

version2 = mi_mapa_atom.version

IO.puts("#{version}, #{version2}")
