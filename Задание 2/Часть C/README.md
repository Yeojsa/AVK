# Часть C

## C1. Команды и биты

#### 1. Ассемблерный код на x86-64 (`x86-64 gcc -O2`)

```asm
f_and:
	movzx	eax, dil     
	ret
f_or:
	mov	eax, edi
	or	eax, 1          
	ret
f_shl:
	lea	eax, [0+rdi*8]  
	ret
f_sar:
	mov	eax, edi
	sar	eax, 3         
	ret
f_xor:
	mov	eax, edi
	shr	eax, 16         
	xor	eax, edi       
	ret
```

#### 2. Ассемблерный код на RISC-V (`RISC-V rv64gc gcc -O2`)

```asm
f_and:
	andi	a0, a0, 255    
	ret
f_or:
	ori	a0, a0, 1       
	ret
f_shl:
	slliw	a0, a0, 3    
	ret
f_sar:
	sraiw	a0, a0, 3      
	ret
f_xor:
	srliw	a5, a0, 16    
	xor	a0, a5, a0     
	ret
```

#### Сравнение названий команд (x86-64 vs RISC-V) и отличие `sar` от `shr`

|    Операция в C    |  Команда x86-64   |       Команда RISC-V        | Расшифровка в RISC-V                  |
|:------------------:|:-----------------:|:---------------------------:|:--------------------------------------|
|     `x & 0xff`     | `and` *(`movzx`)* | `andi` (с регистром `and`)  | AND Immediate                         |
|      `x \| 1`      |       `or`        |  `ori` (с регистром `or`)   | OR Immediate                          |
|      `x << 3`      |   `shl` / `sal`   |      `slliw` (`slli`)       | Shift Left Logical Immediate Word     |
|      `x >> 3`      |       `sar`       |      `sraiw` (`srai`)       | Shift Right Arithmetic Immediate Word |
|     `x >> 16`      |       `shr`       |      `srliw` ( `srli`)      | Shift Right Logical Immediate Word    |
|      `a ^ b`       |       `xor`       |       `xor` (`xori`)        | eXclusive OR                          |

 - `shr`  - логический сдвиг вправо для беззнаковых чисел (`unsigned`). Освобождающиеся слева старшие биты всегда заполняются нулями (`0`).
  - `sar`- арифметический сдвиг вправо для знаковых чисел (`int`). Освобождающиеся слева старшие биты заполняются копиями знакового (31-го) бита сохраняя знак числа в дополнительном коде.

---

## C2. Деление и обмен

### 1. Деление и остаток на константу  и деление на переменную

```c
int d7(int x)         { return x / 7; }
int m7(int x)         { return x % 7; }
int div_var(int x, int y) { return x / y; }
```

**Ассемблер (`x86-64 gcc -O2`):**
```asm
d7:
	movsxd	rax, edi
	imul	rax, rax, -1840700269  
	shr	rax, 32
	add	eax, edi
	sar	eax, 2                  
	 sar	edi, 31                
	sub	eax, edi
	ret

m7:
	movsxd	rax, edi
	imul	rax, rax, -1840700269   
	shr	rax, 32
	add	eax, edi
	sar	eax, 2
	mov	edx, edi
	sar	edx, 31
	sub	eax, edx                
	lea	edx, [0+rax*8]          
	sub	edx, eax                
	mov	eax, edi
	sub	eax, edx               
	ret

div_var:
	mov	eax, edi
	cdq                           
	idiv	esi                   
	ret
```
Деление на известную во время компиляции константу `7` компилятор заменяет быстрым умножением на фиксированную дробь $\approx \frac{2^{34}}{7}$ (магическая константа `-1840700269` / `0x92492493`) и сдвигами (`imul` + `shr` + `sar`), так как инструкция `idiv` занимает 10–40 тактов, а `imul` всего 3 такта. Остаток `x % 7` вычисляется через $x - (x / 7) \cdot 7$, где умножение на 7 делается как `8*q - q` (`lea` + `sub`). Как только делитель становится переменной (`y`), компилятор не знает константу заранее и генерирует медленную инструкцию **`idiv`** ( **`div`** для `unsigned`).

---

### 2. Циклический обмен трёх переменных

```c
void swap3_tmp(int *a, int *b, int *c) {
    int t = *a; *a = *b; *b = *c; *c = t;
}

void swap3_xor(int *a, int *b, int *c) {
    *a ^= *b; *b ^= *a; *a ^= *b;
    *b ^= *c; *c ^= *b; *b ^= *c;
}

void swap3_arith(int *a, int *b, int *c) {
    *a = *a + *b; *b = *a - *b; *a = *a - *b;
    *b = *b + *c; *c = *b - *c; *b = *b - *c;
}
```

**Ассемблер (`x86-64 gcc -O2`):**
```asm
 1. Через временную переменную
swap3_tmp:
	mov	eax, DWORD PTR [rdi]
	mov	ecx, DWORD PTR [rsi]
	mov	DWORD PTR [rdi], ecx
	mov	ecx, DWORD PTR [rdx]
	mov	DWORD PTR [rsi], ecx
	mov	DWORD PTR [rdx], eax
	ret

 2. Через XOR 
swap3_xor:
	mov	eax, DWORD PTR [rsi]
	xor	 eax, DWORD PTR [rdi]
	mov	DWORD PTR [rdi], eax
	xor	eax, DWORD PTR [rsi]
	mov	DWORD PTR [rsi], eax
	xor	DWORD PTR [rdi], eax
	mov	eax, DWORD PTR [rdx]
	xor	eax, DWORD PTR [rsi]
	mov	DWORD PTR [rsi], eax
	xor	eax, DWORD PTR [rdx]
	mov	DWORD PTR [rdx], eax
	xor	DWORD PTR [rsi], eax
	ret
```
- **Что сгенерировал компилятор:**
  - **Обмен через временную переменную** даёт простое чтение в регистры (`mov`) и запись в новом порядке без арифметических операций. Никакая дополнительная память в стеке под `int t` не выделяется, переменная `t` находится в регистре `eax`.
  - **XOR-обмен и арифметический обмен** при передаче обычных указателей не сворачиваются в простой обмен регистров, так как компилятор учитывает возможный алиасинг указателей и вынужден выполнять последовательность зависимых `xor` или `add`/`sub`. Арифметический вариант для знакового `int` содержит риск неопределённого поведения (UB) при знаковом переполнении `*a + *b`. Если переменные локальные, компилятор полностью выбрасывает и XOR, и сложения, сводя код к пересылкам `mov`, что и в `swap3_tmp`.

---

## C3. Таблица функций

| Функция | `x86-64` | `x86-64-v3` | `rv64gc` | `rv64gc_zbb` | Какие специальные инструкции появились                                                         |
| :--- | :---: | :---: | :---: | :---: |:-----------------------------------------------------------------------------------------------|
| **`bswap32`** | 3 | 3 | 20 | 3 | `bswap`; `rev8` + `srli`)                                                                      |
| **`is_pow2`** | 8 | 7 | 6 | 6 | `blsr`; `seqz`/`snez`                                                                          |
| **`parity32`** | 14 | 14 | 15 | 3 | `cpopw` + `andi a0, a0, 1`                                                                     |
| **`popcount32`** | 19 | 3 | 22 | 2 | `popcnt`; `cpopw`                                                                              |
| **`ctz32`** | 10 | 4 | 18 | 2 | `rep bsf` + `cmove` ; `tzcnt` ; `ctzw`; `bne`!                                                 |
| **`clz32`** | 31 | 31 | 29 | 29 | `setbe` / `sltu` ; в `lzcnt` / `clzw`                                                          |
| **`next_pow2`** | 22 | 22 | 24 | 7 | `clz` + `ror` / сдвиг ; `adc`                                                                  |
| **`sign_extend`** | 8 | 8 | 8 | 8 | `sal` + `lea`  `sll`                                                                           |
| **`sat_add32`** | 12 | 12 | 13 | 13 | Линейный код (`xor`, `and`, `sar` / `sraw`) без ветвлений                                      |

---

### Ответы на вопросы 

#### 1. На базовых профилях `x86-64` и `rv64gc` компилятор транслирует все сдвиги, маски и умножение на `0x01010101` . При включении `-march=x86-64-v3` и `-march=rv64gc_zbb`  оптимизатор GCC распознаёт SWAR-алгоритм Хэмминга и заменяет всю функцию одной аппаратной инструкцией:
```asm
x86-64-v3 
popcount32:
	xor	eax, eax
	popcnt	eax, ecx
	ret

rv64gc_zbb 
popcount32:
	cpopw	a0, a0
	ret
```

#### 2. Инструкция `bswap` входит в базовый набор команд `x86-64` без флагов `-march` (`mov eax, ecx` + `bswap eax` + `ret`). В базовом RISC-V (`rv64gc`) команды перестановки байтов нет, и только при подключении расширения `-march=rv64gc_zbb` появляется инструкция обращения байтов 64-битного регистра **`rev8`** с последующим сдвигом `srli a0, a0, 32`.

#### 3. Двоичный поиск в `clz32` использует цепочку зависимых переменных сдвигов `x <<= s`, которую компилятор не умеет сворачивать в идиому подсчёта нулей, поэтому в коде остаются все 5 шагов. При использовании `__builtin_clz(x)` компилятор сразу знает смысл операции и заменяет её на `bsr` + `xor 31`, одну инструкцию **`lzcnt`** (`x86-64-v3`) или **`clzw`** (`rv64gc_zbb`).

#### 4. GCC распознаёт умножение на константу де Брёйна `0x077CB531` с таблицей и заменяет `ctz32` на `rep bsf` + `cmove` (`x86-64`), **`tzcnt`** (`x86-64-v3`) или **`ctzw`** (`rv64gc_zbb`). У Clang (и у GCC на `rv64gc`) появляется переход, так как таблица де Брёйна сворачивается во внутренний `ctz(x)` (не определённый при `0`), а поправка `+ ((x == 0) << 5)` превращается в условие `x == 0 ? 32 : ctz(x)`, которое без аппаратной `tzcnt`/`ctzw` компилируется в `test` и переход `je` / `bne`.

#### 5. На базовом профиле `rv64gc` безветвевая `ctz32` компилируется с условным переходом `bne`:
```asm
ctz32:
    bne    a0, zero, .L9           
    li     a0, 32
    ret
.L9:
    lla    a5, debruijn32.0
    negw   a4, a0
    and    a0, a0, a4
    li     a4, 125612032
    addi   a4, a4, 1329            
    mulw   a0, a0, a4
    srliw  a0, a0, 27
    add    a5, a5, a0
    lbu    a0, 0(a5)
    ret
```
Компилятор вычисляет, что при `x == 0` всё выражение `debruijn32[idx] + ((x == 0) << 5)` равно `32`, и из-за отсутствия `cmov` в базовом `rv64gc` ставит проверку `bne a0, zero, .L9`, чтобы не делать лишнее умножение и чтение из памяти.