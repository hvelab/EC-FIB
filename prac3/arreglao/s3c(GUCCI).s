	# Sessio 3

	.data 
mat:	.word 0,0,2,0,0,0
	.word 0,0,4,0,0,0
	.word 0,0,6,0,0,0
	.word 0,0,8,0,0,0
resultat: .word 0
	.text 
	.globl main
main:
# Escriu aqui el teu codi del main
	addiu $sp,$sp,-4		#empilar
	sw    $ra, 0($sp)
	
	la    $t6,resultat			#$s0 <- @resultat
	la    $a0,mat				#$a0 <- @mat (i la passa com a paràmetre)
	jal   suma_col				#salt a subrutina
	sw    $v0,0($t6)			#guarda el resultat que retorna a resultat
	
	lw    $ra,0($sp)			#desempila
	addiu $sp,$sp,4
	
	jr    $ra
	
	

suma_col:
# Escriu aqui el teu codi de la subrutina

	li  $t0,0				#$t0 <- i = 0 (per al for)
	li  $t1,0				#$t1 <- suma = 0 
	li  $t2,4				#$t2 = 4 (per la condició de sortida del for)

for:    beq   $t0,$t2,fi			#if (i = 4) salta a la fi 

	#@mat[i][2] = mat + (i*6+2)*4
	li    $t3,6
	mult  $t0,$t3				#i*6
	mflo  $t5				#$t0 <- i*6
	addiu $t5,$t5,2				#$t0 <- (i*6)+2
	sll   $t5, $t5,2			#$t0 <- (i*6+2)*4		 
	addu  $t5, $t5, $a0			#$t0 <- @m + (i*6+2)*4
	lw    $t4,0($t5)			#carrega contingut de mat[i][2]
	
	addu  $t1,$t1,$t4			#suma = suma + mat[i][2]
	addiu $t0,$t0,1				#i++
	b for 
	
fi: 	move $v0,$t1
	jr $ra
	
	
	
	





