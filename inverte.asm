	.data
	.align 0
str_pede_str: .asciz "Digite uma palavra: "

	.text
	.align 2
	.globl main
main:
	addi a7, zero, 4			# Imprime str_pede_str
	la a0, str_pede_str
	ecall
	
	addi a7, zero, 8			# Le string do usuario
	addi a1, zero, 40
	ecall
	
	add t0, zero, a0			# Ponteiro para a string lida
	addi t1, zero, -1		# Contandor de quantos caracteres há na string
	
contar:
	lb t2, 0(t0)				# Lendo 1 char
	
	beq t2, zero, inicializar_inverte
	
	addi t1, t1, 1			# contador++
	addi t0, t0, 1
		
	j contar
	
inicializar_inverte:
	addi t6, t1, 1

	addi a7, zero, 9
	add a0, zero, t6
	ecall
	
	add t3, zero, a0			# Ponteiro para a nova string (instável)
	add s0, zero, a0			# Ponteiro para a nova string (estável)
	
	addi t0, t0, -2
		
inverte:
	addi t4, zero, 0		# Contador para controlar o loop

loop2:
	beq t4, t1, fim_loop2
	
	lb t5, 0(t0)
	sb t5, 0(t3)
	
	addi t0, t0, -1
	addi t3, t3, 1
	
	addi t4, t4, 1
	
	j loop2
	
fim_loop2:
	add t5, zero, zero
	sb t5, 0(t3)
	
	addi a7, zero, 4
	add a0, zero, s0
	ecall
	
	addi a7, zero, 10
	ecall
