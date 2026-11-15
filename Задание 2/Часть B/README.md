# Часть B

### Анализ ассемблерного кода (`bits_2.s`, x86-64 `-O2`)

#### 1. `ctz32`

```asm
"ctz32":
	xor	eax, eax
	xor	edx, edx
	rep bsf	eax, ecx
	test	ecx, ecx
	cmove	eax, edx
	sete	dl
	movzx	edx, dl
	sal	edx, 5
	add	eax, edx
	ret
```
Автоматически свернул обращение к массиву и умножение в аппаратную инструкцию поиска младшего единичного бита **`rep bsf eax, ecx`**, дополнив её условной пересылкой `cmove` и установкой флага `sete` для случая `x == 0` без единого условного перехода.

---

#### 2. `clz32`

```asm
"clz32":
	xor	eax, eax
	cmp	ecx, 65535
	mov	edx, ecx
	setbe	al
	sal	eax, 4
	mov	ecx, eax
	sal	edx, cl
	xor	ecx, ecx
	cmp	edx, 16777215
	setbe	cl
	sal	ecx, 3
	sal	edx, cl
	add	eax, ecx
	xor	ecx, ecx
	cmp	edx, 268435455
	setbe	cl
	sal	ecx, 2
	sal	edx, cl
	add	eax, ecx
	xor	ecx, ecx
	cmp	edx, 1073741823
	setbe	cl
	add	ecx, ecx
	sal	edx, cl
	add	eax, ecx
	mov	ecx, edx
	not	ecx
	shr	ecx, 31
	sal	edx, cl
	cmp	edx, 1
	adc	eax, ecx
	ret
```
5 шагов скомпилировались линейно без ветвлений: каждое сравнение (`cmp`) переводится в `0` или `1` инструкцией **`setbe`**, сдвигается на нужный шаг (`sal eax, 4`, `sal ecx, 3`, `sal ecx, 2`, `add ecx, ecx`), сдвигает рабочее значение `sal edx, cl` и суммируется в регистре `eax`. 

---

#### 3. `next_pow2`

```asm
"next_pow2":
	cmp	rcx, 1
	adc	rcx, -1
	mov	rdx, rcx
	shr	rdx
	or	rdx, rcx
	mov	rax, rdx
	shr	rax, 2
	or	rax, rdx
	mov	rdx, rax
	shr	rdx, 4
	or	rdx, rax
	mov	rax, rdx
	shr	rax, 8
	or	rax, rdx
	mov	rdx, rax
	shr	rdx, 16
	or	rdx, rax
	mov	rax, rdx
	shr	rax, 32
	or	rax, rdx
	add	rax, 1
	ret
```
**Обработка `x == 0` и области определения $x \le 2^{63}$ в `next_pow2`**: выражение `x -= (uint64_t)(x != 0)` компилятор свернул в пару инструкций `cmp rcx, 1` и `adc rcx, -1`  при `rcx == 0` возникает  `CF = 1`, поэтому к `rcx` прибавляется `-1 + 1 = 0`, а при `rcx >= 1` (`CF = 0`) вычитается `1`. Далее выполняются 6 сдвигов `shr` + `or` и  `add rax, 1`. При $x \le 2^{63}$ результат помещается в `uint64_t`, а при $x > 2^{63}$ степень $2^{64}$ выходит за пределы и переполняется в `0`.
