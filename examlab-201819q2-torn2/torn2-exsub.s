####################################################################
###### NOM I COGNOMS: owo
####################################################################


  .data
input:  .asciiz "ABCDEFGHIJ"
        .space 9
output: .space 20
    .text
    .globl main

# ESCRIU AQUI EL TEU CODI
func2: 

   	addu	$a0,$a0,$a1
   	lb	$v0,0($a0)
   	addiu	$v0,$v0,-0x41
   	
   	jr 	$ra

func1: 
    
    addiu	$sp,$sp,-16
    sw		$ra,0($sp)	
    sw		$s0,4($sp)		#vin
    sw		$s1,8($sp)		#vout
    sw		$s2,12($sp)		#i
    
    move	$s0,$a0
    move	$s1,$a1
    move	$s2,$zero
    
 while: 
	li 	$t0,'\0'
	
	addu	$t1,$s0,$s2		#@vin[i]
	lb	$t1,0($t1)
	
	beq	$t1,$t0,fora
	move	$a0,$s0
	move	$a1,$s2
	jal 	func2
	
	addu	$t2,$s1,$s2		#vout[i]
	addiu	$t3,$v0,0x30
	sb	$t3,0($t2)
	
	addiu	$s2,$s2,1
	b 	while
	
fora: 
	
	addu	$t2,$s1,$s2
	sb	$zero,0($t2)
	
	lw	$ra,0($sp)	
     	lw	$s0,4($sp)		#vin
    	lw	$s1,8($sp)		#vout
    	lw	$s2,12($sp)		#i
    	addiu	$sp,$sp,16
	jr 	$ra
	



# NO CANVIEU RES DEL CODI A PARTIR D'AQUESTA LINIA     
main:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    la $a0, input
    la $a1, output
    jal func1 
    li  $v0, 4      
    la $a0, output 
    syscall
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra
