defmodule Taller do

    def s2([[]]) do
      0
    end

    def s2(matriz) do
      {suma, cuenta} = sub_s2(matriz, 0)
      if cuenta == 0, do: 0, else: suma / cuenta
    end

    def sub_s2([], _), do: {0, 0}

    def sub_s2([fila | tail], i) do
      {suma_fila, cuenta_fila} = sub_s2_fila(fila, i, 0)
      {suma_rest, cuenta_rest} = sub_s2(tail, i + 1)
      {suma_fila + suma_rest, cuenta_fila + cuenta_rest}
    end

    def sub_s2_fila([], _i, _j), do: {0, 0}
    def sub_s2_fila([x | xs], i, j) when j > i do
      {suma, cuenta} = sub_s2_fila(xs, i, j + 1)
      {x + suma, 1 + cuenta}
    end
    def sub_s2_fila([_x | xs], i, j) do
      sub_s2_fila(xs, i, j + 1)
    end

    def s1([[]]) do
      0
    end

    def s1(matriz) do
      sub_s1(matriz, 0)
    end

    def sub_s1([], _), do: 0

    def sub_s1([fila | tail], i) do
      suma_fila = sub_s1_fila(fila, i, 0)
      suma_fila + sub_s1(tail, i + 1)
    end

    def sub_s1_fila([], _i, _j), do: 0
    def sub_s1_fila([x | xs], i, j) when j < i do
      x + sub_s1_fila(xs, i, j + 1)
    end
    def sub_s1_fila([_x | xs], i, j) do
      sub_s1_fila(xs, i, j + 1)
    end

    def s3(a, b) do
      a*b
    end

    def s4(mensaje) do
        Util.mostrar_mensaje(mensaje)
    end

    def main() do

        matriz = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]

        t1 = Task.async(fn -> s1(matriz) end)
        a = Task.await(t1)
        Util.mostrar_mensaje(a)

        t2 = Task.async(fn -> s2(matriz) end)
        b = Task.await(t2)
        Util.mostrar_mensaje(b)

        c = s3(a, b)

        s4(c)
    end

end

Taller.main()
# output: 19
# 3.6666666666666665
# 69.66666666666666
