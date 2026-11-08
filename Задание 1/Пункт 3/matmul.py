import csv
import statistics
import matplotlib.pyplot as plt

files = {
    "-O0": ("matmul_O0.csv", "matmul-O0.png"),
    "-O2": ("matmul.csv", "matmul-O2.png"),
    "-O3 -march=native": ("matmul_O3.csv", "matmul-O3.png")
}

methods = ["ijk", "ikj", "jik", "jki", "kij", "kji"]

colors = [
    "#0072B2", "#E69F00", "#009E73",
    "#D55E00", "#CC79A7", "#56B4E9"
]

markers = ["o", "s", "^", "D", "v", "P"]

for flag, (filename, output) in files.items():

    data = {}

    with open(filename, "rb") as f:
        raw = f.read(2)

    encoding = (
        "utf-16"
        if raw in (b"\xff\xfe", b"\xfe\xff")
        else "utf-8-sig"
    )

    with open(filename, encoding=encoding) as f:
        reader = csv.DictReader(f)

        for row in reader:
            key = (row["method"].strip(), int(row["n"]))
            data.setdefault(key, []).append(
                float(row["seconds"])
            )

    plt.figure(figsize=(9, 6))

    for method, color, marker in zip(methods, colors, markers):

        ns = sorted(
            n for (m, n) in data if m == method
        )

        if not ns:
            continue

        med = [
            statistics.median(data[(method, n)])
            for n in ns
        ]

        plt.plot(
            ns,
            med,
            marker=marker,
            color=color,
            label=method
        )

    plt.xscale("log")
    plt.yscale("log")

    plt.xlabel("Размер матрицы n")
    plt.ylabel("Медиана времени, с")

    plt.title(f"{flag}")

    plt.legend(title="Метод")
    plt.grid(True, which="both", linestyle="--", alpha=0.5)

    plt.tight_layout()

    plt.savefig(output, dpi=150)
    plt.close()

    print(f"Создан график: {output}")

