.include "code/MACROSv21.s"

.data
	N:			.word 4 # numero de CASAS a serem geradas! pizzaria + N casas
	C:			.word 155, 115
				.space 160
	D: 			.space 1600
	ANS:		.space 80 # 20 casas * 4 bytes
	BRUTE:		.space 80 # 20 casas * 4 bytes
	POSI:		.word 0 # indice livre no meu vetor
	MIN_DIST:	.word 0x70000000 # mindist = INF = 1.58456325E29
	BEST_PERM: 	.space 80 # melhor permutação -> 20 casas * 4 bytes	
	
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
	jal ORDENA
	jal DESENHA_ANS # desenha a melhor rota
	
LOOP:
	j LOOP

	li a7, 10
	ecall

.include "code/sorteio.asm"
.include "code/desenha.asm"
.include "code/rotas.asm"
.include "code/ordena.asm"
.include "code/desenha_ans.asm"

.include "code/SYSTEMv21.s"

