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
	
	la    $s4,resultat			#$s0 <- @resultat
	la    $a0,mat				#$a0 <- @mat (i la passa com a paràmetre)
	jal   suma_col				#salt a subrutina
	sw    $v0,0($s4)			#guarda el resultat que retorna a resultat
	
	lw    $ra,0($sp)			#desempila
	addiu $sp,$sp,4
	
	jr    $ra
	
	

suma_col:
# Escriu aqui el teu codi de la subrutina
	addiu $sp, $sp, -16			#empilar
	sw    $ra,  0($sp)
	sw    $s0,  4($sp)
	sw    $s1,  8($sp)
	sw    $s2, 12($sp)
	
	move  $s0,$a0				#$s0 <- mat
	move  $s1,$zero				#$s1 <- i = 0 (per al for)
	move  $s2,$zero				#$s2 <- suma = 0 
	
	
	
	li    $t0,4				#$t0 = 4 (per la condició de sortida del for)

for:    beq   $s1,$t0,fi			#if (i = 4) salta a la fi 

	#@mat[i][2] = mat + (i*6+2)*4
	li    $t4,6
	mult  $s1,$t4				#i*6
	mflo  $t3				#$t3 <- i*6
	addiu $t3,$t3,2				#$t3 <- (i*6)+2
	sll   $t3, $t3,2			#$t3 <- (i*6+2)*4		 
	addu  $t4, $t3, $a0			#$t4 <- @m + (i*6+2)*4
	lw    $t1,0($t4)			#carrega contingut de mat[i][2]
	
	addu  $s2,$s2,$t1			#suma = suma + mat[i][2]
	addiu $s1,$s1,1				#i++
	b for 
	
fi: 	move $v0,$s2				#retorn i desempilar 
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	jr $ra
	
	
	
	





