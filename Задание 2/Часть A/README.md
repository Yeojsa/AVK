 # Часть А
 

#### Граничные случаи и результаты проверок

Все функции реализованы и проходят граничные случаи.

| Функция | Вход | Ожидание |  Статус  |
| :---: | :---: | :---: |:--------:|
| `bswap32` | `0x0A0B0C0D` | `0x0D0C0B0A` | Проходит |
| `is_pow2` | `0, 1, 2, 1ull << 63` | `0, 1, 1, 1` |    Проходит    |
| `parity32` | `7, 3` | `1, 0` |    Проходит    |
| `popcount32` | `0, 0xFFFFFFFF` | `0, 32` |    Проходит    |
| `sign_extend` | `0xF, 4; 0x7, 4; 0x80, 8; ~0ull, 64` | `-1, 7, -128, -1` |    Проходит    |
| `sat_add32` | `INT32_MAX, 1; INT32_MIN, -1` | `INT32_MAX, INT32_MIN` |    Проходит    |

---

### Анализ ассемблерного кода (`-O2`)

#### 1. `is_pow2` и  `is_pow2_branchy`

**Безветвевая версия (`bits.s`, x86-64 `-O2`):**
```asm
"is_pow2":
	lea	rax, -1[rcx]
	test	rax, rcx
	sete	dl
	xor	eax, eax
	test	rcx, rcx
	setne	al
	and	eax, edx
	ret
```
В безветвевой версии нет условных переходов: компилятор вычисляет `x - 1` через `lea`, проверяет `x & (x - 1)` и `x != 0` инструкциями `test`, выставляет байтовые флаги через `sete` / `setne` и объединяет их побитовым `and`.

**Ветвящаяся версия (`branch.s`, x86-64 `-O2`):**
```asm
"is_pow2_branchy":
	test	rcx, rcx
	jne	.L9
	jmp	.L5
.L4:
	test	cl, 1
	jne	.L5
	shr	rcx
.L9:
	cmp	rcx, 1
	jne	.L4
	mov	eax, 1
	ret
.L5:
	xor	eax, eax
	ret
```
На `-O2` компилятор не свернул побитовый цикл `while (x > 1)` в формулу `x & (x - 1)`, а оставил полноценный цикл со сдвигом `shr rcx` и тремя условными переходами (`jne .L9`, `jne .L5`, `jne .L4`).

**Ветвящаяся и безветвевая версии на RISC-V (`RISC-V rv64gc gcc -O2`):**
```asm
# Безветвевая is_pow2 
is_pow2:
	addi	a5, a0, -1
	and	a5, a5, a0
	seqz	a5, a5          # a5 = ((x & (x - 1)) == 0)
	snez	a0, a0          # a0 = (x != 0)
	and	a0, a0, a5
	ret

# Ветвящаяся is_pow2_branchy 
is_pow2_branchy:
	beq	a0, zero, .L5
	li	a4, 1
	j	.L3
.L4:
	andi	a5, a0, 1
	bne	a5, zero, .L5
	srli	a0, a0, 1
.L3:
	bne	a0, a4, .L4
	li	a0, 1
	ret
.L5:
	li	a0, 0
	ret
```
На RISC-V также, безветвевая версия транслируется в несколько линейных инструкций с псевдоинструкциями установки флага `seqz` и `snez`, а `is_pow2_branchy` сохраняет цикл и условные переходы `beq` / `bne`.

---

#### 2. `sat_add32` и `sat_add32_branchy`

**Безветвевая версия (`bits.s`, x86-64 `-O2`):**
```asm
"sat_add32":
	lea	r8d, [rcx+rdx]
	mov	eax, ecx
	shr	ecx, 31
	xor	eax, r8d
	xor	edx, r8d
	add	ecx, 2147483647
	and	eax, edx
	xor	ecx, r8d
	sar	eax, 31
	and	eax, ecx
	xor	eax, r8d
	ret
```
Линейный код без переходов и без `cmov`. Выражение `(s & ~mask) | (sat & mask)` оптимизатор упростил в форму `s ^ ((sat ^ s) & mask)` через три `xor` и одного `and`, а размножение бита переполнения `0u - ov` заменил сдвигом вправо `sar eax, 31`.

**Ветвящаяся версия (`branch.s`, x86-64 `-O2`):**
```asm
"sat_add32_branchy":
	movsxd	rcx, ecx
	movsxd	rdx, edx
	mov	eax, 2147483647
	add	rcx, rdx
	cmp	rcx, 2147483647
	jg	.L11
	cmp	rcx, -2147483648
	mov	eax, -2147483648
	cmovge	eax, ecx
.L11:
	ret
```
В `sat_add32_branchy` компилятор сделал условный переход `jg .L11` для верхней границы (`s > INT32_MAX`), а вторую ветку (`s < INT32_MIN`) заменил на пересылку **`cmovge eax, ecx`**. А внутри `main` GCC заменил оба условия на пару `cmovl` и `cmovg`:
```asm
	add	r9, r12
	cmp	r9, rdx
	cmovl	r9, rdx
	mov	edx, 2147483647
	cmp	r9, rdx
	cmovg	r9, rdx
```

**Ветвящаяся и безветвевая версии на RISC-V (`RISC-V rv64gc gcc -O2`):**
```asm
# Безветвевая sat_add32 (RISC-V)
sat_add32:
	addw	a5, a0, a1
	xor	a4, a0, a5
	xor	a1, a1, a5
	and	a4, a4, a1
	srliw	a0, a0, 31
	li	a3, 2147483648
	addi	a3, a3, -1      # INT32_MAX (0x7fffffff)
	addw	a0, a0, a3
	sraw	a4, a4, 31      # маска переполнения (0 или -1)
	xor	a0, a0, a5
	and	a0, a0, a4
	xor	a0, a0, a5
	ret

# Ветвящаяся sat_add32_branchy (RISC-V)
sat_add32_branchy:
	add	a0, a0, a1
	li	a5, 2147483648
	addi	a4, a5, -1      # a4 = 2147483647 (INT32_MAX)
	bgt	a0, a4, .L4     # переход при переполнении вверх
	neg	a5, a5          # a5 = -2147483648 (INT32_MIN)
	blt	a0, a5, .L5     # переход при переполнении вниз
	sext.w	a0, a0
	ret
.L4:
	mv	a0, a4
	ret
.L5:
	mv	a0, a5
	ret
```
Компилятор в `sat_add32_branchy` сделал две ветки с условными переходами **`bgt`** и **`blt`**. В безветвевой версии `sat_add32` программа компилируется в последовательность 32-битных арифметических и побитовых инструкций без единого перехода.