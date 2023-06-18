SORTEIO:
	addi sp, sp, -24
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw a0, 12(sp)
	sw a1, 16(sp)
	sw a7, 20(sp)
	
	mv s0, a1 #s0 -> ponteiro de memoria
	addi s0, s0, 8 # não sobreescrever a pizzaria
	
	mv s1, a0 #s1 -> quantidade que vou gerar agora
	
FOR_SORTEIO:
	
	li a7, 42 #gerar random
	li a1, 310 #upper bound
	ecall
	sw a0, 0(s0) #salva o x
	
	li a7, 42
	li a1, 230
	ecall
	sw a0, 4(s0) # salva o y
	
	addi s0, s0, 8 #avança a posição de memória
	addi s1, s1, -1 #diminui um na quantidade que preciso gerar
	bgt s1, zero, FOR_SORTEIO #volta se ainda nao terminou
	 
	lw a7, 20(sp)
	lw a1, 16(sp)
	lw a0, 12(sp)
	lw s1, 8(sp)
	lw s0, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 24
	
	ret
