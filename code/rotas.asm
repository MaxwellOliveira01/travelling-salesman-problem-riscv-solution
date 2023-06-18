ROTAS:
	# recebe N em a0
	# recebe o ponteiro de memoria para as posicoes das casas em a1
	# recebe o ponteiro de memoria para as distancias em D
	
	# for i = 0....N
	#	for j = 0...N
	#		d[i][j] = distancia(c[i], c[j])
	
	addi sp, sp, -44
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw a0, 16(sp)
	sw a1, 20(sp)
	sw a2, 24(sp)
	sw a3, 28(sp)
	sw a4, 32(sp)
	sw a5, 36(sp)
	sw a7, 40(sp)
	
	mv s0, a1 # s0 -> ponteiro de memoria das casas
	mv s1, a0 # s1 -> N
	mv s2, a2 # s2 -> ponteiro de memoria das distancias
	
	li t0, 0 # i = 0
						
FORI_ROTAS:
	
	#pega a casa[i] em t3
	slli t3, t0, 3 # i * 2 pq cada casa tem 2 coords e * 4 quantidade de bytes por valor
	add t3, t3, s0
	lw t4, 0(t3)
	lw t3, 4(t3) 
	#(t4, t3) = (x, y) da casa[i]
	
	fcvt.s.w ft1, t3
	fcvt.s.w ft0, t4
	# (ft0, ft1) = (x, y) da casa[i]
	
	li t1, 0 # j = 0
	
FORJ_ROTAS:
	
	#pega a casa[j]
	slli t5, t1, 3
	add t5, t5, s0
	lw t6, 0(t5)
	lw t5, 4(t5)
	#(t6, t6) = (x, y) da casa[j]
	
	# ------- Usa ecall para desenhar as linhas -------- #
	
	#desenha apenas se i < j (pq se i == j a linha buga, ????)
	
	bge t0, t1, CALC_DIS

	mv a0, t4
	mv a1, t3
	mv a2, t6
	mv a3, t5
	li a4, 0
	li a5, 0
	li a7, 147
	ecall
	
	
	# ---------- Calcula a distancia -------- #
	
CALC_DIS:

	fcvt.s.w ft3, t5
	fcvt.s.w ft2, t6
	 #(ft3, ft2) = (x, y) da casa[j]
	
	fsub.s ft3, ft3, ft1 # diferença numa coord 
	fsub.s ft2, ft2, ft0 # diferença na outra coord
	
	fmul.s ft3, ft3, ft3 # quadrado da diferença
	fmul.s ft2, ft2, ft2 # quadrado da outra diferença
	
	fadd.s ft3, ft3, ft2 # soma o quadrado das diferenças
	
	fsqrt.s ft3, ft3 # tira a raiz
	
	fsw ft3, 0(s2) # salva em d[i][j]
	
	addi s2, s2, 4 # move o ponteiro de d
	
	addi t1, t1, 1 # j++
	ble t1, s1, FORJ_ROTAS # if j <= n continua processando
	
	addi t0, t0, 1 #i++
	ble t0, s1, FORI_ROTAS # if i <= n continua processando
	
	lw a7, 40(sp)
	lw a5, 36(sp)
	lw a4, 32(sp)
	lw a3, 28(sp)
	lw a2, 24(sp)
	lw a1, 20(sp)
	lw a0, 16(sp)
	lw s2, 12(sp)
	lw s1, 8(sp)
	lw s0, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 44
	
	ret
