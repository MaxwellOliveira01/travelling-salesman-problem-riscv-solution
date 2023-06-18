DESENHA_ANS:
	# A melhor resposta já está computada em BEST_PERM
	# Agora basta desenhar uma reta vermelha em best_perm[i] e best_perm[i + 1] pra todo i < n 
	# (lembrar das extremidades ligando com a pizzaria)
	
	addi sp, sp, -36
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	sw a3, 16(sp)
	sw a4, 20(sp)
	sw a5, 24(sp)
	sw a6, 28(sp)
	sw a7, 32(sp)
	
	# for i = 0 .... n - 1
	
	#t0 = N - 1
	la t0, N
	lw t0, 0(t0)
	addi t0, t0, -1 
	
	la t1, BEST_PERM
	
	# desenha a reta da pizzaria pra primeira casa
	# a pizzaria tem id = 0
	
	li t2, 0
	# acha as coordenadas da pizzaria
	la t4, C
	add t2, t2, t4 #
	#agora le (x, y) de 0(t2) e 4(t2)
	lw a2, 0(t2)
	lw a3, 4(t2)
	
	#t3 = BEST_PERM[0]
	lw t3, 0(t1)
	
	# acha as coordenadas do i-esimo cara
	# &c + t2 * 4 (word) * 2(duas coordenadas p/casa)
	slli t3, t3, 3 # t2 = t2 * 4 * 8
	la t4, C
	add t3, t3, t4 # t2 = &c + 4 * 2 * t2
	
	#agora le (x, y) de 0(t2) e 4(t2)
	lw a0, 0(t3)
	lw a1, 4(t3)	
	
	li a4, 0x0007 # cor vermelha
	li a5, 0 # frame
	li a7, 147 # codigo
	ecall # chama
	
FOR_DESENHA_ANS:
	
	#t2 = BEST_PERM[i]
	lw t2, 0(t1)
	
	# acha as coordenadas do i-esimo cara
	# &c + t2 * 4 (word) * 2(duas coordenadas p/casa)
	slli t2, t2, 3 # t2 = t2 * 4 * 8
	la t4, C
	add t2, t2, t4 # t2 = &c + 4 * 2 * t2
	
	#agora le (x, y) de 0(t2) e 4(t2)
	lw a2, 0(t2)
	lw a3, 4(t2)	
	
	# t3 = BEST_PERM[i + 1]
	lw t3, 4(t1)
	# faz a mesma coisa de cima aqui
	slli t3, t3, 3
	la t4, C
	add t3, t3, t4
	
	# agora le
	lw a0, 0(t3)
	lw a1, 4(t3)
	
	li a4, 0x0007 # cor vermelha
	li a5, 0 # frame
	li a7, 147 # codigo
	ecall # chama
	
	addi t1, t1, 4 # move o ponteiro de best perm 
	addi t0, t0, -1 # diminui um na quantidade restante
	bgt t0, zero, FOR_DESENHA_ANS  # testa
	
	# quando sair daqui vai faltar desenhar exatamente uma reta
	# que é a reta de best_perm[n - 1] para a pizzaria
	
	# acha as coordenadas da pizzaria
	li t2, 0
	la t4, C
	add t2, t2, t4 #
	#agora le (x, y) de 0(t2) e 4(t2)
	lw a2, 0(t2)
	lw a3, 4(t2)
	
	# acha as coordenadas de best_perm[n - 1]
	# t3 = BEST_PERM[n - 1]
	lw t3, 0(t1)
	slli t3, t3, 3
	la t4, C
	add t3, t3, t4
	# agora le
	lw a0, 0(t3)
	lw a1, 4(t3)
	
	li a4, 0x0007 # cor vermelha
	li a5, 0 # frame
	li a7, 147 # codigo
	ecall # chama	
	
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	lw a3, 16(sp)
	lw a4, 20(sp)
	lw a5, 24(sp)
	lw a6, 28(sp)
	lw a7, 32(sp)
	addi sp, sp, 36
	
	ret
