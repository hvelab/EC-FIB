####################################################################
###### NOM I COGNOMS: owo
####################################################################

.data


A: .word    4,  3,  2,  1,
           -1,  7,  6,  5,
           -1, -1,  9,  8,
           -1, -1, -1, 10
.text
.globl main

main:
	li 	$t0,0		#i
	li 	$t2,4
	la	$t3,A
	li	$t7,3
fori: 
	bge	$t0,$t2,fi
	li	$t1,3		#j

forj: 
	blt	$t1,$t0,fiforj		#j<i salta
	
	sll	$t4,$t0,2		#4i
	addu	$t4,$t4,$t1		#4i+j
	sll	$t4,$t4,2
	addu	$t4,$t4,$t3		#@A[I][J]
	lw	$t4,0($t4)
	
	div	$t4,$t7
	mfhi	$t5
	
	sll	$t6,$t1,2
	addu	$t6,$t6,$t0
	sll	$t6,$t6,2
	addu	$t6,$t6,$t3		#@A[j][i]
	
	bne	$t5,$zero,else
	sw	$t4,0($t6)
	b 	cont
	
else: 
	sw	$zero,0($t6)

cont: 
	addiu	$t1,$t1,-1		#j--
	b	forj

fiforj: 
	addiu	$t0,$t0,1		#i++
	b	fori
fi: 

      jr  $ra 



