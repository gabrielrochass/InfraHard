addi $a0, $zero, 5
addi $s0, $zero, 1
addi $s2, $s1, 3
add $t2, $zero, $s0
add $t3, $zero, $s0
addi $s2, $zero, 32
begin_loop:
addi $t4, $zero, 2
add $t0, $t0, 1
blt $t0, $t4, if_end
add $t3, $t1, $t2
add $s1, $s1, $t2
add $t1, $zero, $t2
add $t2, $zero, $t3    
if_end:
mult $s0, $t0
mflo $s0 
add $s1, $zero, $t1
bne $t0, $a0, begin_loop
add $s3, $s1, $s0
mult $s1, $s2
mflo $s2
add $s2, $s2, $s0  
