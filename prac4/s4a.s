	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	sw	$v0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:
	li 	$t0,0 					# $t0 <- 0 
	slt 	$a1, $a0, $t0				# *s = 1 si cf < 0 i 0 si >
	la 	$t1, signe
	sw 	$a1, 0($t1)				# guardar signe a memòria
	
	sll 	$a0, $a0, 1				# cf << 1
	bne 	$a0,$t0, else 				# salta if cf != 0
	li 	$t1, 0					# exp = 0
	b 	fi
else:
	li 	$t1, 18					# exp = 18 
while: 
	blt 	$a0, $t0, fiwhile 			# si (cf < 0 ) salta a fiwhile
	sll 	$a0, $a0, 1				# cf << 1
	addiu   $t1, $t1, -1				# exp--
	b 	while 

fiwhile: 
	srl 	$a0, $a0, 8 				# cf >> 8 
	li 	$t2, 0x7FFFFF				# carregar màscara de bits 
	and 	$a0,$a0,$t2				# cf & 0x7FFFFF
	addiu 	$t1, $t1, 127				# exp = exp +127

fi:	
	la	$t0, exponent
	sw	$t1,0($t0)				# guardar exponent a memòria
	la	$t0, mantissa
	sw	$a0,0($t0)				# guardar mantissa a memòria
	jr      $ra
	
compon:
	sll 	$a0, $a0, 31				# signe << 31
	sll	$a1, $a1, 23				# exponent << 23
	or 	$t1, $a0, $a1				# signe | exponent
	or 	$t1, $t1, $a2				# signe | exponent | mantissa
	
	move 	$v0, $t1				#return 
	jr 	$ra					# :) 

