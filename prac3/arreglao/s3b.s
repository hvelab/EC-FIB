# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
mat1: 	.space 120 #5*6*4
mat4:   .word 2,3,1,2,4,3
col:	.word 2

	.text 
	.globl main
main:
# Escriu aqui el programa principal

	addiu   $sp, $sp, -4
	sw	$ra, 0($sp)
	la 	$s1, mat1		#@mat1[0][0] 
	la 	$a0, mat4		#@mat4
	lw 	$a1, 8($a0) 		#@mat4[0][2]
	la 	$a2, col		#@col
	lw 	$a2, 0($a2)		#$a2 <- col
	
	jal 	subr
	
	sw      $v0, 108($t2)		#mat1[4][3] <- subr(mat4,mat4[0][2],col)
	
	la 	$a0, mat4		#@mat4	
	li	$a1,1			#1 
	li 	$a2,1			#1
	jal	subr			#subr(mat4,1,1)
	
	sw 	$v0,0($s1)		#mat1[0][0] <- subr(mat4,1,1)
	
	lw 	$ra,0($sp)		#desempilar
	addiu 	$sp,$sp,4		
	jr 	$ra			#fi :) 


subr:
# Escriu aqui el codi de la subrutina
	#mat1 + j*6*4
	#@mat[i][j] = mat + (i*NC+j)*T
	addiu $sp,$sp,-4
	sw $ra, 0($sp)
	
	la $t0, mat1			#$t0 <- @mat1
	li $t1, 6			#$t1 <- 6
	mult $a2,$t1 			#@mat1[j][5] = mat1 + (j*6+5)*4 // j*6
	mflo $t2
	addiu $t2, $t2, 5		#(j*6)+5
	sll $t2,$t2, 2			#(j*6+5)*4
	addu $t2,$t2,$t0		#$t2 = (j*6+5)*4 + @mat1 = @mat1[j][5]
	
	#x + i*12 + j*4
	#@x[i][j] = x + (i*3+j)*4
	li $t1, 3			#$t1 <- 3
	mult $a1,$t1			#i*3
	mflo $t3			#$t3 <- i*3
	addu $t3,$t3,$a2		#$t3 <- (i*3)+j
	sll $t3, $t3,2			#$t3 <- (i*3+j)*4		 
	addu $t3, $t3, $a0		#$t3 <- @x + (i*3+j)*4
	
	lw $t6, 0($t3)
	sw $t6, 0($t2)
	
	lw $ra, 0($sp)
	addiu $sp,$sp,4
	
	move $v0, $a1
	jr $ra	


