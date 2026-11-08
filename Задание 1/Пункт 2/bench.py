import csv
import random
import statistics
import time

from student import matmul

n = 1024
runs = 5
rows = []

for run in range(1, runs + 1):
    a = [[random.random() for _ in range(n)] for _ in range(n)]
    b = [[random.random() for _ in range(n)] for _ in range(n)]

    t0 = time.perf_counter()
    c = matmul(a, b)
    t = time.perf_counter() - t0

    rows.append((run, t, 2 * n**3 / t / 1e9))
    print(f"run {run}: {t:.3f} s, {rows[-1][2]:.4f} GFLOPS, c[0][0]={c[0][0]:.3f}")

with open("python-matmul.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["run", "seconds", "gflops"])
    w.writerows(rows)

med = statistics.median(r[1] for r in rows)
print(f"median: {med:.3f} s, {2 * n**3 / med / 1e9:.4f} GFLOPS")
print(f"оценка для n = 1024: {med * 64:.0f} s")
print("""\nТак как у нас 3 вложенных цикла, то общее число итераций равняется n^3 из чего следует,что алгоритм имеет кубическую временную сложность.
А при увеличении размера матрицы с 256 до 1024, получаем (1024/256)^3 = (4)^3 = 64, из=за чего и получается, что оценка получается умножением на 64.
""")

x = (1024 ** 3) * 2
print(f"Общее количество операций при умножение матриц 1024x1024 = {x}") # операций 2147483648
