

# PRACTICA 1 #######################

	.data
		cadena: .byte -1,-1,-1,-1,-1,-1
		vec: 	.word 5,6,8,9,1 
	
			
	.text
	.globl main
main:
	li  $s0, 0		# i = 0
while: 
	
	li $t0,5		# $t0 = 5
	li $s1, 4		# $s1 = 4
	bge $s0,$t0, fi		# salto
	
	la $t1, cadena 		# st1 <- cadena
	sll $t5, $s0, 2		# i*4
	addu $t6, $t1, $t5	# $t6 <- @cadena + (i*4) 
	
	la $t7,  vec		# $t7 <- @vec
	addu $t7, $t7, $t5	# $t7 <- @vec + (i*4)
	subu $t7, $s1, $t7 	# $t7 < -@( 4 - (@vec + (i*4)))
	lw $t7, 0($t7)		# $t7 <- 4 - (@vec + (i*4))
	addiu $t2, $t7, '0' 	# $t2 <- 4 - (@vec + (i*4)) + '0'
	sb $t2, 0($t6)		# cadena [i] = 4 - (@vec + (i*4)) + '0'
	
	addiu $s0, $s0, 1
	b while
	
fi: 	
	la $t5, cadena 
	sb $zero, 5($t5)
	
	li $v0, 4
	la $a0, cadena
	syscall
	
	jr $ra		# main retorna al codi de startup

