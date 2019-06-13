	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp, $sp, -56			#reservem espai a la pila per a histo[10]
	sw $s0, 40($sp)
	sw $s1, 44($sp)
	sw $s2, 48($sp)
	sw $ra, 52($sp)
	
	move $s0,$a0				#carreguem vec
	move $s1,$a1				#carreguem num
	
	li $s2,0				#inicialitzem k=0 per poder fer el for 
	li $t1, 10				#$t1=10 per la condició del for
	
	move $s3, $sp				#$s3 <- histo[0] (variable local) 
for:	beq $t0, $t1, cont			#if (k = 10) salta a continuació
	sw $zero, 0($s3)			#histo[k] = 0
	addiu $s3, $s3, 4			#histo[k+1] (k+4)
	addiu $t0, $t0, 1			#contador per al for (k++)
	b for					#torna al bucle 

cont:				
	li $t2, '0'				#max = '0'
	li $s2, 0				#k = 0 (per el for)
for2:	
	beq $s2, $s1, fi			#if(k=num) salta a fi
	move $a0, $sp				#passem per referència histo
	addu $a1, $s0, $s2			#($s0 = vec) + k (contador del for) ((ens dona la direcció de vec[k]))
	lb $a1, 0($a1)				#carrega el contingut vec[k] i el passa per referència
	addiu $a1, $a1, -48			#vec[k]-'0' (48 és '0' en ASCII)
	
	addiu $a2, $t2, -48			#max-'0' i passem per referència 
	
	jal	update				#crida a la subrutina update
	
	addiu $t2, $v0, '0'			#recull el resultat per $v0 i li suma '0'
						#max = '0' + update(histo......etc)
	addiu $s2, $s2, 1			#contador del for (k++)
	b for2					#torna a l'inici del bucle 

fi:	move $v0, $t2				#movem max a $v0 per fer return 

					
	lw $s0, 40($sp)				#desempilem
	lw $s1, 44($sp)
	lw $s2, 48($sp)
	lw $ra, 52($sp)
	addiu $sp, $sp, 56			#alliberem espai pila
	jr $ra					#tornem al main 

update:
	addiu	$sp, $sp, -16			#reservem espai per a (h,i,imax i $ra)		
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	
	move $s0, $a0				#$s0 = h
	move $s1, $a1				#$s1 = i
	move $s2, $a2				#$s2 = imax

	jal nofares				#crida a nofares()
	
	sll $t0, $s1, 2				#$t0 = i*4 per tenir la posició del vector
	addu $t0, $s0, $t0			#$t0 = h + (i*4) o sigui és la direcció de h[i]
	lw $t1, 0($t0)				#$t1 = *h[i]
	addiu $t1, $t1, 1			#h[i]++
	sw $t1, 0($t0)				#h[i] = h[i]++
	
	sll $t2, $s2, 2				#$t2 = imax * 4
	addu $t2, $s0, $t2			#$t2 = h + (imax*4)
	lw $t2, 0($t2)				#$t2 = *(h + (imax * 4))
	
	ble $t1, $t2, else			#if (h[i] < h [imax]) no es cumpleix i salta al else
	move $v0, $s1				#posem a $v0 la i per poder fer el return 
	b fi3					#salta al final per desempilar
	
else:	move $v0, $s2				#si no es compleix retorna imax 

fi3:	lw $s0, 0($sp)				#desempilem 
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addiu	$sp, $sp, 16
	jr $ra
