.data

	# variables to compute best answer, do not change
	
	ANS:		.space 80 # 20 casas * 4 bytes
	BRUTE:		.space 80 # 20 casas * 4 bytes
	POSI:		.word 0 # indice livre no meu vetor
	MIN_DIST:	.word 0x70000000 # mindist = INF = 1.58456325E29
	BEST_PERM: 	.space 80 # melhor permutação -> 20 casas * 4 bytes	
	
.text

FIND_PATH:
	# recebe N em a0
	# recebe o ponteiro de memoria para as posicoes das casas em a1
	# recebe o ponteiro de memoria para as distancias em D
	# recebe a quantidade de casas já visitadas em a3
	# recebe a mask das casas visitadas em a4
	
	addi sp, sp, 4
	sw ra, 0(sp)
	
	call ORDENA
	call DESENHA_ANS
	
	lw ra, 0(sp)
	addi sp, sp, -4
	
	ret


ORDENA:
	# recebe N em a0
	# recebe o ponteiro de memoria para as posicoes das casas em a1
	# recebe o ponteiro de memoria para as distancias em D
	# recebe a quantidade de casas já visitadas em a3
	# recebe a mask das casas visitadas em a4
	
	addi sp, sp, -40
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	sw a3, 16(sp)
	sw a4, 20(sp)
	sw s0, 24(sp)
	sw s1, 28(sp)
	sw s2, 32(sp)
	sw s3, 36(sp)

	#if quantidade de casas != N, continua recursao:
	#beq a3, a0, FIM_WHILE_ORDENA
	bne a3, a0, REC
	
	#se chegou até aqui é pq é uma permutação!!!!!!
	
	call TESTA_PERM
	
	j FIM_WHILE_ORDENA


REC:

	#for i 1...n e olha na mask se não tá visitada
	
	li s3, 1
		
WHILE_ORDENA:
	#while s3 <= n
	
	#checa o s0-esimo bit pra ver se a casa já não foi visitada
	
	li s2, 1
	sll s2, s2, s3 #t2 = 2^s3
	and s0, s2, a4 #t0 = mask & (2^s0)
	bnez s0, INC_ORDENA #t0 != 0 -> a casa s0 tá livre
	
	# a j-esima casa tá disponivel
	# salva ela em brute[posi] e vai recursivo
	la s0, POSI
	lw s0, 0(s0) # pega o indice disponivel
	
	la s1, BRUTE # pega o endereço do vetor
	add s1, s1, s0 #t1 = &brute[posi]
	sw s3, 0(s1) #brute[posi] = s0
	
	#arruma as variaveis para a recursao
	
	addi a3, a3, 1 # visitei mais uma casa
	add a4, a4, s2 #mask = mask | (1 << s0)
	
	# le, incrementa e salva a posicao atual
	la s0, POSI
	lw t0, 0(s0) 
	addi t0, t0, 4
	sw t0, 0(s0)
	
	call ORDENA # Chama recursivo
	
	# desmarca esse cara
	sub a4, a4, s2
	
	#nao visitei mais essa casa
	addi a3, a3, -1
	
	#decrementa a posicao de salvar atual
	la s0, POSI
	lw t0, 0(s0) 
	addi t0, t0, -4
	sw t0, 0(s0)
	
INC_ORDENA:
	addi s3, s3, 1
	ble s3, a0, WHILE_ORDENA #testa se deve continuar ou nao

FIM_WHILE_ORDENA:
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	lw a3, 16(sp)
	lw a4, 20(sp)
	lw s0, 24(sp)
	lw s1, 28(sp)
	lw s2, 32(sp)
	lw s3, 36(sp)
	addi sp, sp, 40
	
	ret
		
.include "testa_perm.asm"
.include "desenha_ans.asm"