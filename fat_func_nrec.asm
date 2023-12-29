	.data
	.align 0
str_pede_num: .asciz "Digite um numero: "
str_final1: .asciz "O fatorial de "
str_final2: .asciz " é "
str_erro: .asciz "O numero digitado é negativo, logo nao possui fatorial"

	.text
	.align 2
	.globl main
main:
	addi a7, zero, 4				# Imprimindo str_pede_num
	la a0, str_pede_num
	ecall
	
	addi a7, zero, 5				# Lendo numero do usuario
	ecall
	
	add s0, zero, a0				# Salvando o numero do usuario em <s0>
	
	blt a0, zero, imprimir_erro		# Tratando caso de numero negativo
	
	jal fatorial					# Calculando o fatorial do numero do usuario
	
	add s1, zero, a0				# Salvando o fatorial do numero do usuario em <s1>
	
	j imprimir
	
imprimir_erro:
	addi a7, zero, 4				# Imprimindo str_erro
	la a0, str_erro
	ecall
	
	j encerra

imprimir:
	addi a7, zero, 4				# Imprimindo str_final1
	la a0, str_final1
	ecall
	
	addi a7, zero, 1				# Imprimindo o numero do usuario
	add a0, zero, s0
	ecall
	
	addi a7, zero, 4				# Imprimindo str_final2
	la a0, str_final2
	ecall
	
	addi a7, zero, 1				# Imprimindo o valor do fatorial
	add a0, zero, s1
	ecall	
	
encerra:
	addi a7, zero, 10				# Encerrando o programa
	ecall
	
										######## FUNCOES AUXILIARES ########
	
fatorial:
	# Funcao que calcula o fatorial de um numero
	# Parametros => a0: numero do usuario
	# Retornos => a0: fatorial do numero
	
	addi t0, zero, 1				# Serve para controlar o loop do fatorial (constante 1)
	
	add t1, zero, a0				# Copia do numero do usuario
	
	addi t2, zero, 1				# Valor do fatorial

loop_fatorial :
	ble t1, t0, sai_fatorial			# Caso <t1> <= <t0 = 1>, execucao vai para "sai_fatorial"
	
	mul t2, t2, t1				# Multiplicando o valor anterior do fatorial por <t1>
	
	addi t1, t1, -1				# Decrementando <t1>
	
	j loop_fatorial				# Recomeçando o loop do "loop_fatorial"

sai_fatorial:
	add a0, zero, t2				# Coloca o valor do fatorial em <a0>

	jr ra						# Retorna a função