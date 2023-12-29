	.data
	.align 2
vetor: .word 6, 5, 4, 3, 2, 1, 0
	.align 0
espaco: .asciz " "

	.text
	.align 2
	.globl main
main:
	addi s0, zero, 7				# Tamanho do vetor (MAX)
	
	addi t0, zero, 0				# Contador do primeiro_loop" (i), começa em 0
		
	addi s3, zero, 4
	
	la s1, vetor					# Ponteiro para o vetor
	
loop:
	beq t0, s0, fim_loop1			# Sai caso i == MAX
	
	addi t1, s0, -1				# Contador do "segundo_loop" (j), começa em MAX - 1
	
loop2:
	beq t1, t0, fim_loop2			# Sai caso j == i
	
	addi t6, t1, -1				# Recebe j - 1
	mul t6, t6, s3				# Recebe 4 * (j - 1)
	add t6, t6, s1				# Recebe &vetor[j - 1]
	lw t3, 0(t6)					# Recebe vetor[j - 1]
	lw t4, 4(t6)					# Recebe vetor[j]
	
	ble t3, t4, nao_troca			#Trocando
		sw t3, 4(t6)
		sw t4, 0(t6)
	
nao_troca:
	addi t1, t1, -1				# Decrementando j
	
	j loop2
	
fim_loop2:
	addi t0, t0, 1				# Incrementando i
	
	j loop	
	
fim_loop1:
	addi t0, zero, 0
	
	add t6, zero, s1
	
print:
	beq t0, s0, encerra
	
	lw t5, 0(t6)
	addi a7, zero, 1
	add a0, zero, t5
	ecall
	
	addi a7, zero, 4
	la a0, espaco
	ecall
	
	addi t6, t6, 4
	
	addi t0, t0, 1
	
	j print	
	
encerra:
	addi a7, zero, 10
	ecall