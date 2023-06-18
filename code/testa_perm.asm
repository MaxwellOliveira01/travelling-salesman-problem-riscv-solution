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