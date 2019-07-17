
# PRACTICA 1 #######################

	.data
	fib: 	.word 0,1,0,0,0,0,0,0,0,0
	
			
	.text
	.globl main
main:
	li  $s0, 2		# i = 2
while: 
	
	slti $t0, $s0, 10 	#condición salto 
	beq $t0, $zero, fi	#salto
	la $t1, fib 		# st1 <- adress fib
	sll $t5, $s0, 2		# i*4
	addu $t6, $t1, $t5	# $t6 <- @fib + (i*4) 
	lw $t2, -4($t6)		# $t2 <- (fib[i-1])
	lw $t3, -8($t6)		# $st3 <- (fib[i-2]
	addu $t4, $t3, $t2	# fib[i-1] + fib[i-2]
	sw $t4, 0($t6)		# @fib <- fib[i-1] + fib[i-2]
	
	addiu $s0, $s0, 1
	b while
	
	
	
fi: 
	jr $ra		# main retorna al codi de startup

