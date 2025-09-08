defmodule SolutionList do
  @spec is_valid_sudoku(board :: [[char]]) :: boolean
  def is_valid_sudoku(board) do
    rows = List.duplicate([], 9)
    cols = List.duplicate([], 9)
    boxes = List.duplicate([], 9)
    check(board, 0, 0, rows, cols, boxes)
  end

  defp check(_board, 9, _j, _rows, _cols, _boxes), do: true
  defp check(board, i, 9, rows, cols, boxes), do: check(board, i + 1, 0, rows, cols, boxes)
  defp check(board, i, j, rows, cols, boxes) do
    val = board |> Enum.at(i) |> Enum.at(j)
    cond do
      val == ?. ->
        check(board, i, j + 1, rows, cols, boxes)
      Enum.member?(Enum.at(rows, i), val) or
      Enum.member?(Enum.at(cols, j), val) or
      Enum.member?(Enum.at(boxes, div(i, 3) * 3 + div(j, 3)), val) ->
        false
      true ->
        b = div(i, 3) * 3 + div(j, 3)
        rows = List.replace_at(rows, i, [val | Enum.at(rows, i)])
        cols = List.replace_at(cols, j, [val | Enum.at(cols, j)])
        boxes = List.replace_at(boxes, b, [val | Enum.at(boxes, b)])
        check(board, i, j + 1, rows, cols, boxes)
    end
  end
end

defmodule SolutionMap do
  @spec is_valid_sudoku(board :: [[char]]) :: boolean
  def is_valid_sudoku(board) do
    init = Map.new(0..8, fn i -> {i, MapSet.new()} end)
    rows = init
    cols = init
    boxes = init
    Enum.reduce_while(0..8, {rows, cols, boxes}, fn i, {rows, cols, boxes} ->
      Enum.reduce_while(0..8, {rows, cols, boxes}, fn j, {rows, cols, boxes} ->
        val = Enum.at(Enum.at(board, i), j)
        if val == ?. do
          {:cont, {rows, cols, boxes}}
        else
          b = div(i, 3) * 3 + div(j, 3)
          if MapSet.member?(rows[i], val) or
             MapSet.member?(cols[j], val) or
             MapSet.member?(boxes[b], val) do
            {:halt, false}
          else
            rows = Map.put(rows, i, MapSet.put(rows[i], val))
            cols = Map.put(cols, j, MapSet.put(cols[j], val))
            boxes = Map.put(boxes, b, MapSet.put(boxes[b], val))
            {:cont, {rows, cols, boxes}}
          end
        end
      end)
      |> case do
        false -> {:halt, false}
        acc -> {:cont, acc}
      end
    end)
    |> case do
      false -> false
      _ -> true
    end
  end
end

defmodule SolutionRecMap do
  @spec is_valid_sudoku(board :: [[char]]) :: boolean
  def is_valid_sudoku(board) do
    init = Map.new(0..8, fn i -> {i, MapSet.new()} end)
    check(board, 0, 0, init, init, init)
  end

  defp check(_board, 9, _j, _rows, _cols, _boxes), do: true
  defp check(board, i, 9, rows, cols, boxes), do: check(board, i + 1, 0, rows, cols, boxes)
  defp check(board, i, j, rows, cols, boxes) do
    val = board |> Enum.at(i) |> Enum.at(j)
    cond do
      val == ?. ->
        check(board, i, j + 1, rows, cols, boxes)
      MapSet.member?(rows[i], val) or
      MapSet.member?(cols[j], val) or
      MapSet.member?(boxes[div(i, 3) * 3 + div(j, 3)], val) ->
        false
      true ->
        b = div(i, 3) * 3 + div(j, 3)
        rows = Map.put(rows, i, MapSet.put(rows[i], val))
        cols = Map.put(cols, j, MapSet.put(cols[j], val))
        boxes = Map.put(boxes, b, MapSet.put(boxes[b], val))
        check(board, i, j + 1, rows, cols, boxes)
    end
  end
end

defmodule Pretty do
  def print_board(board) do
    IO.puts("+-------+-------+-------+")
    Enum.with_index(board)
    |> Enum.each(fn {row, idx} ->
      row
      |> to_string()
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join(&1, " "))
      |> Enum.join(" | ")
      |> then(&IO.puts("| #{&1} |"))
      if rem(idx + 1, 3) == 0, do: IO.puts("+-------+-------+-------+")
    end)
  end
end


board_full_1 = [
  ~c"534678912",
  ~c"672195348",
  ~c"198342567",
  ~c"859761423",
  ~c"426853791",
  ~c"713924856",
  ~c"961537284",
  ~c"287419635",
  ~c"345286179"
]

board_full_2 = [
  ~c"417369825",
  ~c"632158947",
  ~c"958724316",
  ~c"825437169",
  ~c"791586432",
  ~c"346912758",
  ~c"289643571",
  ~c"573291684",
  ~c"164875293"
]

board_slow_valid = [
  ~c".........",
  ~c".........",
  ~c".........",
  ~c"....1....",
  ~c".........",
  ~c".........",
  ~c".........",
  ~c".........",
  ~c"........."
]

board_slow_valid_2 = [
  ~c"53..7....",
  ~c"6..195...",
  ~c".98....6.",
  ~c"8...6...3",
  ~c"4..8.3..1",
  ~c"7...2...6",
  ~c".6....28.",
  ~c"...419..5",
  ~c"........."
]

boards = [
  [
    ~c"53..7....",
    ~c"6..195...",
    ~c".98....6.",
    ~c"8...6...3",
    ~c"4..8.3..1",
    ~c"7...2...6",
    ~c".6....28.",
    ~c"...419..5",
    ~c"....8.179"
  ],
  [
    ~c"83..7....",
    ~c"6..195...",
    ~c".98....6.",
    ~c"8...6...3",
    ~c"4..8.3..1",
    ~c"7...2...6",
    ~c".6....28.",
    ~c"...419..5",
    ~c"....8..79"
  ],
  [
    ~c"83..7....",
    ~c"6..195...",
    ~c".98....6.",
    ~c"8...6...3",
    ~c"4..8.3..1",
    ~c"7...2...6",
    ~c".6....28.",
    ~c"...419..5",
    ~c"....8..79"
  ],
  board_full_1,
  board_full_2,
  board_slow_valid,
  board_slow_valid_2
]


Enum.each(boards, fn board ->
  Pretty.print_board(board)
  {time1, res1} = :timer.tc(fn -> SolutionList.is_valid_sudoku(board) end)
  {time2, res2} = :timer.tc(fn -> SolutionMap.is_valid_sudoku(board) end)
  {time3, res3} = :timer.tc(fn -> SolutionRecMap.is_valid_sudoku(board) end)

  IO.puts("SolutionList: #{res1} in #{time1} µs")
  IO.puts("SolutionMap: #{res2} in #{time2} µs")
  IO.puts("SolutionRecMap: #{res3} in #{time3} µs")
  IO.puts("")
end)
