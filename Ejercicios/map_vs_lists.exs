defmodule Benchmark do
  # Benchmark 1: Fast Lookups (Map vs List)
  def lookup_map_vs_list do
  IO.puts("Benchmark 1: Lookup Performance (Map vs List)\n")

    # Generate large map
    map_data = for i <- 1..10_000, into: %{}, do: {"user_#{i}", %{age: i}}

    {map_time, _} = :timer.tc(fn ->
      Enum.each(1..1_000, fn i ->
        Map.get(map_data, "user_#{i}") # For each i from 1 to 1,000: Looks up "user_#{i}" in map_data using Map.get
      end)
    end)

  IO.puts("Map lookup time: #{map_time / 1_000} ms")

    # Generate large list
    list_data = for i <- 1..10_000, do: %{"name" => "user_#{i}", "age" => i}

    {list_time, _} = :timer.tc(fn ->
      Enum.each(1..1_000, fn i ->
        Enum.find(list_data, fn user -> user["name"] == "user_#{i}" end) # For each i from 1 to 1,000: Searches list_data for a map where "name" matches "user_#{i}" using Enum.find.
      end)
    end)

  IO.puts("List search time: #{list_time / 1_000} ms")
    IO.puts("\nConclusion: Use maps for fast lookups by key.")
  end

  # Benchmark 2: Sequential Processing (List vs Map)
  def sequential_list_vs_map do
  IO.puts("\nBenchmark 2: Sequential Processing (List vs Map)\n")

    # List of numbers
    numbers = Enum.to_list(1..1_000_000)

    {list_time, list_sum} = :timer.tc(fn ->
      Enum.sum(numbers) #sums all numbers, quite easy tbh
    end)

  IO.puts("List sum time: #{list_time / 1_000} ms (Sum: #{list_sum})")

    # Same numbers as map
    number_map = for i <- 1..1_000_000, into: %{}, do: {i, i}

    {map_time, map_sum} = :timer.tc(fn ->
      number_map
      |> Map.values()
      |> Enum.sum() #gets all values then sums them
    end)

  IO.puts("Map sum time: #{map_time / 1_000} ms (Sum: #{map_sum})")
    IO.puts("\nConclusion: Use lists for fast sequential processing.")
  end

  # Summary Table
  def summary do
    IO.puts("""

Summary Table

| Operation              | List         | Map         | Winner |
|-----------------------|--------------|-------------|--------|
| Lookup by key         | Slow        | Fast       | Map    |
| Sequential traversal  | Fast        | Slower     | List   |
| Insert at front       | Fast        | N/A        | List   |
| Update by key         | N/A         | Fast       | Map    |
| Preserves duplicates  | Yes         | No         | List   |
| Structured records    | Clumsy      | Clear      | Map    |

Use maps for lookups and structured data.
Use lists for order-sensitive, sequential, or duplicated data.

""")
  end

  # Run all benchmarks
  def run_all do
    lookup_map_vs_list()
    sequential_list_vs_map()
    summary()
  end
end

# Run everything when this file is executed
Benchmark.run_all()
