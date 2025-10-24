defmodule Concurrencia do

  def fn1(0, b) do
    IO.puts("fn1 caso base: a=0, b=#{b}")
    0 + b
  end
  def fn1(1, b) do
    IO.puts("fn1 caso base: a=1, b=#{b}")
    1 + b
  end
  def fn1(a, b) do
    res = a + b
    IO.puts("fn1: a=#{a}, b=#{b}, res=#{res}")
    fn1(a - 1, b)
  end

  def fn2(a, 0) do
    IO.puts("fn2 caso base: a=#{a}, b=0")
    a
  end
  def fn2(a, 1) do
    IO.puts("fn2 caso base: a=#{a}, b=1")
    a
  end
  def fn2(a, b) do
    res = a * b + (a * a + b)
    IO.puts("fn2: a=#{a}, b=#{b}, res=#{res}")
    fn2(a, b - 1)
  end

  def fn3(0, 0) do
    IO.puts("fn3 caso base: a=0, b=0")
    0
  end
  def fn3(1, 1) do
    IO.puts("fn3 caso base: a=1, b=1")
    1
  end
  def fn3(a, b) do
    IO.puts("fn3: a=#{a}, b=#{b}")
    fn3(0, 0)
  end

  def fn4(0, 0) do
    IO.puts("fn4 caso base: a=0, b=0")
    -9223372036854775808
  end
  def fn4(1, 1) do
    IO.puts("fn4 caso base: a=1, b=1")
    -9223372036854775808
  end
  def fn4(a, b) do
    IO.puts("fn4: a=#{a}, b=#{b}")
    -9223372036854775808
  end

  def main() do
    task1 = Task.async(fn -> fn1(2, 3) end)
    task2 = Task.async(fn -> fn2(2, 3) end)
    task3 = Task.async(fn -> fn3(2, 3) end)
    task4 = Task.async(fn -> fn4(2, 3) end)

    res1 = Task.await(task1, 5000)
    IO.puts("Resultado fn1: #{res1}")
    res2 = Task.await(task2, 5000)
    IO.puts("Resultado fn2: #{res2}")
    res3 = Task.await(task3, 5000)
    IO.puts("Resultado fn3: #{res3}")
    res4 = Task.await(task4, 5000)
    IO.puts("Resultado fn4: #{res4}")

    main()
  end
end

Concurrencia.main()
