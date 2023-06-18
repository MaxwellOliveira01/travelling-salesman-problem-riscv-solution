.include "code/MACROSv21.s"

.data
	N:			.word 4 # fixed starting point + N others ( 2 <= N < 20 )
	C:			.word 155, 115 # (x, y) of starting point
				.space 160 # memory to save generated points
	D: 			.space 1600 # memory to save the distantes between every pair of poitns

.text

MAIN:

	la t0, N
	lw a0, 0(t0)
	la a1, C
	la a2, D
	
	li a3, 0
	li a4, 0

	jal SORTEIO
	jal DESENHA
	jal ROTAS
	jal FIND_PATH 
	
#LOOP:
#	j LOOP

	li a7, 10
	ecall

.include "code/sorteio.asm"
.include "code/desenha.asm"
.include "code/rotas.asm"
.include "code/ordena.asm"

.include "code/SYSTEMv21.s"

