	.data
	.align 0
str_pede_num: .asciz "Digite um numero: "

	.text
	.align 2
	.globl main
main:
	addi a7, zero, 4				# Pede numero do usuario
	la a0, str_pede_num
	ecall
	
	addi a7, zero, 5				# Le numero do usuario
	ecall
	
	blt a0, zero, encerra			# Tratando numero do usuario negativo
	add a1, zero, a0
	jal fibo
	
	addi a7, zero, 1				# Imprime o valor do fibonacci
	ecall
	
encerra:
	addi a7, zero, 10				# Encerrando o porgrama
	ecall
	
fibo:
	addi t0, zero, 1				# Valor 1 constante, usado para controlar caso de parada
	
	addi sp, sp, -8
	sw ra, 0(sp)				# Empilhando <ra>
	sw a1, 4(sp)				# Empilhando n
	
	ble a1, t0, retorna_n			# Caso de parada
		
	addi a1, a1, -1
	jal fibo					# Fibo(n - 1)
	
	addi sp, sp, -4
	sw a0, 0(sp)				# Empilhando valor de Fibo(n - 1)
	
	addi a1, a1, -1
	jal fibo					# Fibo(n - 2)

	lw a1, 0(sp)				# Desempilhando valor de Fibo(n - 1)
	addi sp, sp, 4
	
	add a0, a0, a1				# Somar
							
	j sai_fibo

retorna_n:
	add a0, zero, a1				# <a0> = n
	
sai_fibo:
	lw ra, 0(sp)					# Desempilhando <ra>
	lw a1, 4(sp)				# Desempilhando n
	addi sp, sp, 8
	
	jr ra