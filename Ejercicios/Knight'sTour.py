import sys

# Para 6x6 se hace 100,000,000,000,000,000,000,000,000,000,000 operaciones
# Es decir 10^18 años
# O(8^N^2)

def es_valido(x, y, N, tablero):
    return 0 <= x < N and 0 <= y < N and tablero[x][y] == -1


def contar_tours(x, y, mov_num, tablero, mov_x, mov_y, N):
    """Cuenta recursivamente todas las rutas válidas del caballo que
    visitan todas las casillas (tour) empezando en (x,y) con mov_num pasos ya asignados.

    Retorna el número de tours completos encontrados desde este estado.
    """
    if mov_num == N * N:
        return 1

    total = 0
    for i in range(8):
        nuevo_x = x + mov_x[i]
        nuevo_y = y + mov_y[i]
        if es_valido(nuevo_x, nuevo_y, N, tablero):
            tablero[nuevo_x][nuevo_y] = mov_num
            total += contar_tours(nuevo_x, nuevo_y, mov_num + 1, tablero, mov_x, mov_y, N)
            tablero[nuevo_x][nuevo_y] = -1

    return total


def imprimir_tablero(tablero, N):
    for i in range(N):
        for j in range(N):
            print(f"{tablero[i][j]:2}", end=" ")
        print()


def main(argv):
    if len(argv) < 4:
        print("Usage: Knight'sTour.py N start_x start_y")
        return

    try:
        N = int(argv[1])
        start_x = int(argv[2])
        start_y = int(argv[3])
    except ValueError:
        print("Arguments must be integers")
        return

    tablero = [[-1 for _ in range(N)] for _ in range(N)]

    mov_x = [2, 1, -1, -2, -2, -1, 1, 2]
    mov_y = [1, 2, 2, 1, -1, -2, -2, -1]

    tablero[start_x][start_y] = 0

    total = contar_tours(start_x, start_y, 1, tablero, mov_x, mov_y, N)
    print(f"Total tours found from ({start_x},{start_y}) on {N}x{N}: {total}")


if __name__ == '__main__':
    main(sys.argv)