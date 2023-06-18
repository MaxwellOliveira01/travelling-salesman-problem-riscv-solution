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












TESTA_PERM:
	
	# testa a permutação que tá salva em BRUTE e tem tamanho N
	# NÃO EDITAR REGISTRADORES!!!
	# lembrar que a pizzaria é a casa 0 e a N+1
	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t0, N
	lw t0, 0(t0)
	
	addi t0, t0, -1
	
	#t0 = N-1
	
	la t1, BRUTE # endereço da permutação a ser testada
	
	fsub.s ft0, ft0, ft0 #ft0 = 0 = ft0 - ft0
	
	# começa adicionando a distancia da pizzaria pra casa em brute[0]
	# isso é, ft0 = d[0][brute[0]] = &d + 4 * ( brute[0] )
	
	lw t4, 0(t1)  #t4 = brute[0]
	slli t4, t4, 2 #t4 = 4 * brute[0]
	
	la t5, D #t5 = d
	
	add t4, t4, t5 # t4 = &d + 4 * brute[0]
	
	flw ft0, 0(t4) #adiciona na soma acumulada d[0][brute[0]]

WHILE_TESTA_PERM:
	
	#lê o indice [i] e salva em t2
	lw t2, 0(t1)
	
	#lê o indice [i+1] e salva em t3
	lw t3, 4(t1)
	
	#pega a distancia da casa t2 para a t3 usando d[t2][t3] -> (&d + t2 * n + t3)
	
	la t4, N # t4 = &n
	lw t4, 0(t4) # t4 = n
	addi t4, t4, 1 # t4 = n + 1 -> n casas + pizzaria
	mul t4, t4, t2 # t4 = t2 * n
	add t4, t4, t3 # t4 = t2 * n + t3
	slli t4, t4, 2 # t4 *= 4 (pq são words?)
	
	la t5, D # t5 = d
	
	add t4, t4, t5 #t4 = &d + t2 * n + t3
	
	#faz a leitura do float em &t4
	
	flw ft1,0(t4) #ft1 = d[t2][t3]
	fadd.s ft0, ft0, ft1 # adiciona essa distancia na soma acumulada

	# incrementa i e testa a condição 
	addi t0, t0, -1
	addi t1, t1, 4
	bgt t0, zero, WHILE_TESTA_PERM

	# falta adicionar 
	# d[0][brute[n-1]]
	
	lw t4, 0(t1) #t4 = brute[n - 1]
	slli t4, t4, 2 #t4 = brute[n - 1] * 4
	la t5, D #t5 = d
	add t4, t4, t5 # t4 = &d + 4 * brute[n - 1]
	flw ft1, 0(t4) # pega a distancia
	fadd.s ft0, ft0, ft1 # adiciona na soma acumulada

	#if ft0 < &MINDIST:
	#salva BRUTE em BEST_PERM
	
	la t0, MIN_DIST
	flw ft1, 0(t0) # ft1 = ans atual
	
	flt.s t0, ft0, ft1 # checa se o que eu calculei agora é melhor que o que tá em MIN_DIST
	addi t0, t0, -1 #subtrai um do resultado acima
	
	bne t0, zero, FIM_TESTA_PERM # se o que eu calculei for pior, então pula pro final
	
	# se chegou até aqui é pq o que eu calculei é melhor que o que eu tinha!!!!!
	
	la t0, MIN_DIST
	fsw ft0, 0(t0) # atualiza a melhor resposta até aqui!!!!
	
	# for i = 0...N
	# BEST_PERM[i] = BRUTE[i]
	
	la t0, N
	lw t0, 0(t0)
	la t1, BEST_PERM
	la t2, BRUTE
	
UPDATE_BEST_PERM:
	lw t3, 0(t2) # t3 = brute[i]
	sw t3, 0(t1) # best_perm[i] = brute[i]
	addi t1, t1, 4 # move o ponteiro
	addi t2, t2, 4 # move o ponteiro
	addi t0, t0, -1
	bgt t0, zero, UPDATE_BEST_PERM
	
FIM_TESTA_PERM:

	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
