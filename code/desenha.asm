DESENHA:

	addi sp, sp, -36
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw a0, 12(sp)
	sw a1, 16(sp)
	sw a2, 20(sp)
	sw a3, 24(sp)
	sw a4, 28(sp)
	sw a7, 32(sp)
		
	mv s0, a1 # s0 -> ponteiro de memoria
	mv s1, a0 # s1 -> N
	
	#------ pinta toda a tela de branco ---------#
		
	li a0, 0xFFFFFFFF # cor
	li a1, 0 # frame
	li a7, 148 #ecall pra pintar
	ecall

	#------ começa a desenhar os pontos ---------#

	li a0, 65 # a0 -> indice da letra que vai ser desenhada
	li a3, 0x0700 # a primeira cor tem que ser preto com fundo vermelho
	
FOR_DESENHA:

	lw a1, 0(s0) #le o x
	lw a2, 4(s0) #le o y
	li a4, 0 #frame
	
	li a7, 111
	ecall
	
	li a3, 0x3800 # seta a cor para verde com fundo preto
	addi a0, a0, 1 # avança a letra
	addi s0, s0, 8 #avança a posição de memória
	addi s1, s1, -1 #diminui um na quantidade que preciso desenhar
	bge s1, zero, FOR_DESENHA #volta se ainda nao terminou
	
	lw a7, 32(sp)
	lw a4, 28(sp)
	lw a3, 24(sp)
	lw a2, 20(sp)
	lw a1, 16(sp)
	lw a0, 12(sp)
	lw s1, 8(sp)
	lw s0, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 36
	
	ret
