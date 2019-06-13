	.data
A:	.word 1,2,3,4,5,6,7,8,9,10,11,12
B:	.word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
C:	.word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

	.text
	.globl main

main:	# Initializations
	li	$t0, 0		# i = 0
	li	$t1, 0		# sum = 0
	li	$t2, 16		# Total iterations
	li	$t3, 12		# A iterations

for:	sll	$t4, $t0, 2	# Compute array position
	
	# Check if clause
	bge	$t0, $t3, notif
	
	# sum = sum + A[i]
	la	$t5, A
	addu	$t5, $t4, $t5
	lw	$t5, 0($t5)
	addu	$t1, $t1, $t5

notif:	# sum = sum + B[i]
	la	$t5, B
	addu	$t5, $t4, $t5
	lw	$t5, 0($t5)
	addu	$t1, $t1, $t5

	# sum = sum + C[i]
	la	$t5, C
	addu	$t5, $t4, $t5
	lw	$t5, 0($t5)
	addu	$t1, $t1, $t5

	addiu	$t0, $t0, 1	# i++
	blt	$t0, $t2, for	# for finished?

	jr	$ra
