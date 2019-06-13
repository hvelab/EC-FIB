	.data
result: .word 0
num:	.byte ';'

	.text
	.globl main
	
main:	la    $s0,num 			#$s0 <- num
	lb    $s0,0($s0)			#$s0 <- *num
	la    $s1,result			#$s1 <- result
	
	#primera part primer if
	li    $s2,'a'			#$s2 <- 'a'
	blt   $s0,$s2,cond2		# if(num < a ) salta a l'altre part del if 
	li    $s2,'z'			#$s3 <- 'z'
	ble   $s0,$s2,fi			# if (num <= z ) es compleix el if i executa result=num;
	
cond2: 	#segona part primer if 
	li    $s2,'A'			#$s2 <- 'A'
	blt   $s0,$s2,cond3		#if(num < 'A') salta al if del else 
	li    $s2,'Z'			#$s2 <- 'Z'
	ble   $s0,$s2,fi			#if(num <= 'Z') es compleix el if i executa result=num; 
	
cond3:	#if dins del else
        li    $s2,'0'			#$s2 <- '0'
	blt   $s0, $s2, else		#if (num < '0') salta al else
	li    $s2,'9'			#$s2 <- '9'
	bgt   $s0,$s2, else 		
	addiu $s0,$s0,-48
	b     fi
	
else:   li    $s0,-1	
fi: 	sw    $s0,0($s1)		

	jr $ra

