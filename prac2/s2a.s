	.data

	.text
	.globl main
main:
	li $s1, 23 # Y
	li $s0, 8  # X

# COPIA EL TEU CODI AQUI
	li   $t0,1
	sllv $t1,$t0,$s0
	subu $t1,$t1,$t0
	xor  $s1,$t1,$s1


	jr $ra
