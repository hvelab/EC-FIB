
.data
vector: .space 400

	.text
	.globl main
main:
        move    $t1, $zero          # $t1 = sum
        la      $t2, vector         # $t2 = @vector[i]
        li      $t3, 99		    # $t3 = i
        sll	$t5, $t3,2	    # $t5 = 99*4
        addu 	$t2, $t2, $t5	    # $t2 = @v[99]
        move    $t0, $zero          # $t0 = 0
        
for:
        ble     $t3, $t0, fi
        lw      $t4, 0($t2)
        addu    $t1, $t1, $t4
        addiu   $t2, $t2, -4
        addiu   $t3, $t3, -1
        b       for
fi:
	jr	$ra