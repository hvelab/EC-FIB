# PRACTICA 1 #######################

	.data
	
A:	.word 3,5,7
punter:	.word 0

	.text
	.globl main
	
main:	la $t0, punter		# $t0 <- @punter
	la $t1, A		# $t1 <- @A
	addiu $t1, $t1, 8	# $t1 <- @A[2]
	sw $t1, 0($t0)		# punter <- A[2]
	
	lw $t0, 0($t0)		# $t0 <- @punter
	lw $t0, 0($t0)		# $t0 <- punter
	addiu $s0, $t0, 2	# $s0 <- punter + 2
	
	la $t0, punter 		# $t0 <- punter
	lw $t0, 0($t0)		# $t0 <- *punter
	addiu $t0, $t0, -8	# temp <- *(punter -2) 
	lw $t0, 0($t0)		# temp <- temp
	addu $s0, $s0, $t0	# temp <- *(punter -2)  + temp
	
	la $t0, A		# $t0 <- @A
	sw $s0, 4($t0)		# A[1] = temp
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	jr $ra		# main retorna al codi de startup
