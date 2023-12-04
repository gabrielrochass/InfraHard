
# MIPS Assembly code to calculate mod(a, b)

.data
    prompt_a: .asciiz "Enter value for a: "
    prompt_b: .asciiz "Enter value for b: "
    result: .asciiz "Result: "

.text
.globl main

main:
    # Prompt user for input
    li $v1, 4
    la $a0, prompt_a
    syscall

    # Read value for a
    li $v1, 5
    syscall
    move $a0, $v1

    # Prompt user for input
    li $v1, 4
    la $a0, prompt_b
    syscall

    # Read value for b
    li $v1, 5
    syscall
    move $a1, $v1

    # Call mod function
    jal mod

    # Print result
    li $v1, 4
    la $a0, result
    syscall

    move $a0, $v1
    li $v1, 1
    syscall

    # Exit program
    li $v1, 10
    syscall

mod:
    # Save return address
    sw $ra, 0($sp)
    addiu $sp, $sp, -4

    # Check if a is negative
    slti $t0, $a0, 0
    beqz $t0, else

    # If a is negative, store 1 in $v1 and exit
    li $v1, 1
    j end

else:
    # Check if a < b
    slt $t0, $a0, $a1
    beqz $t0, else2

    # If a < b, return a
    move $v1, $a0
    j end

else2:
    # Calculate mod(a-b, b)
    sub $a0, $a0, $a1
    jal mod
    move $a0, $v1
    move $a1, $a1
    jal mod

end:
    # Restore return address
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

    # Return to caller
    jr $ra

