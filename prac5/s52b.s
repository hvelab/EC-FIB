	.data	
vec:    .word   20, -18, 45, 12,-1,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64

	.text
	.globl main
main:
        li      $t0, 0          # $t0 = i
        la      $t4, vec        # $t4 = &vec
fori:
        li 	$t7,4
        bge     $t0, $t7, end_fori

        move    $t3, $t0        # $t3 = max
        addiu   $t1, $t0, 1     # $t1 = j
forj:
	li	 $t7,5
        bge     $t1, $t7, end_forj	
        sll     $t5, $t1, 2
        addu    $t5, $t5, $t4	
        lw      $t5, 0($t5)     # $t5 = vec[max]
        sll     $t6, $t3, 2
        addu    $t6, $t6, $t4
        lw      $t6, 0($t6)     # $t6 = vec[j]
        ble     $t5, $t6, end_if
        move    $t3, $t1
end_if:
        addiu   $t1, $t1, 1     # j++
        b       forj
end_forj:
        sll     $t5, $t0, 2
        addu    $t5, $t5, $t4   # $t5 = @vec[i]
        lw      $t2, 0($t5)     # $t2 = aux = vec[i]
        sll     $t6, $t3, 2
        addu    $t6, $t6, $t4	# $t6 = @vec[max]
        lw      $t7, 0($t6)     # $t7 = vec[max]
        sw      $t7, 0($t5)
        sw      $t2, 0($t6)
        addiu   $t0, $t0, 1     # i++
        b       fori
end_fori:
	jr	$ra
