import csv
import os
import statistics
import matplotlib.pyplot as plt

script_dir = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(script_dir, "strassen.csv") if os.path.exists(os.path.join(script_dir, "strassen.csv")) else "strassen.csv"

with open(csv_path, "rb") as f:
    raw = f.read(2)
encoding = "utf-16" if raw in (b"\xff\xfe", b"\xfe\xff") else "utf-8-sig"

data = {}
with open(csv_path, encoding=encoding) as f:
    for row in csv.DictReader(f):
        key = (row["method"].strip(), int(row["n"]))
        data.setdefault(key, []).append(float(row["seconds"]))

plt.figure(figsize=(9, 6))
for method in ["naive", "strassen"]:
    ns = sorted(n for (m, n) in data if m == method)
    med = [statistics.median(data[(method, n)]) for n in ns]
    plt.plot(ns, med, "o-", label=method)

plt.xscale("log", base=2)
plt.yscale("log")
plt.xlabel("размер матрицы n")
plt.ylabel("медиана времени, с")
plt.title("Сравнение обычного умножения и алгоритма Штрассена")
plt.legend()
plt.grid(True, which="both", linestyle="--", alpha=0.5)
plt.tight_layout()

output_png = os.path.join(script_dir, "strassen.png")
plt.savefig(output_png, dpi=150)
print(f"График успешно сохранен: {output_png}")
