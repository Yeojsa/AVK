import os
import platform
from cpuinfo import get_cpu_info

print(""" 
Модель, число ядер, потоков, базовая частота, размеры L1d, L2, L3.

Get-CimInstance Win32_Processor | Format-List Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

Name                      : 13th Gen Intel(R) Core(TM) i9-13900HX
NumberOfCores             : 24
NumberOfLogicalProcessors : 32
MaxClockSpeed             : 2200

Get-CimInstance Win32_CacheMemory | Format-Table Purpose, InstalledSize

Purpose  InstalledSize
-------  -------------
L1 Cache           384
L1 Cache           256
L2 Cache         16384
L3 Cache         36864
L1 Cache           512
L1 Cache          1024
L2 Cache         16384
L3 Cache         36864
""")

print("Через Python")

print("platform.machine()   =", platform.machine())
print("os.cpu_count()       =", os.cpu_count())
print("platform.processor() =", platform.processor())

info = get_cpu_info()
flags = info.get("flags", [])

for f in ("sse4_2", "avx", "avx2", "avx512f"):
    print(f"  {f:<10}: {'есть' if f in flags else 'нет'}")


print("\nПик одного ядра: ")
freq_str = info.get("hz_actual_friendly")
f_ghz = float(freq_str.split()[0].replace(",", "."))
W = 8
NFMA = 2
peak = f_ghz * 2 * NFMA * W

print(f"Пик P-core = {f_ghz} * 2 * {NFMA} * {W}  = {peak:.1f} GFLOPS на ядро для avx2")

"""
Через Python
platform.machine()   = AMD64
os.cpu_count()       = 32
platform.processor() = Intel64 Family 6 Model 183 Stepping 1, GenuineIntel
  sse4_2    : есть
  avx       : есть
  avx2      : есть
  avx512f   : нет

Пик одного ядра: 
Пик P-core = 2.419 * 2 * 2 * 8  = 77.4 GFLOPS на ядро для avx2"""

print("""\nКэш - это сверхбыстрая память процессора в которой хранятся часто используемые данные и инструкции, чтобы процессор не обращался каждый раз к более медленной оперативной памяти.
Несколько ядер нужны процессору для одновременного выполнения разных задач и ускорения параллельных вычислений. 
Такт - это один цикл работы процессора в течение которого выполняются определённые операции.
""")

