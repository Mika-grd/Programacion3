IO.puts("=== DIAGNÓSTICO DE NODO ===")
IO.puts("Mi nodo: #{inspect(node())}")
IO.puts("Cookie: #{inspect(Node.get_cookie())}")
IO.puts("\nIntentando conectar a diferentes variaciones...")

variaciones = [
  :"nodoservidor@Miguels-MacBook-Air",
  :"nodoservidor@localhost",
  :"nodoservidor@127.0.0.1"
]

Enum.each(variaciones, fn nodo ->
  IO.puts("\nProbando: #{inspect(nodo)}")
  case Node.connect(nodo) do
    true ->
      IO.puts("  ✅ ¡CONECTADO!")
      IO.puts("  Nodos visibles: #{inspect(Node.list())}")
    false ->
      IO.puts("  ❌ Falló")
    :ignored ->
      IO.puts("  ⚠️  Ignorado (mismo nodo?)")
  end
end)

IO.puts("\n=== FIN DEL DIAGNÓSTICO ===")
