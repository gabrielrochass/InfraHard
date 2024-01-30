.data 
	mult_constant: .word 1664525
	add_constant: .word 1013904223
	newline: .asciiz "\n"
.text 
	move $t0, $zero #valor que irá iterar
	li $v0, 41
	syscall
	move $t6, $a0
	lw $t1, mult_constant 
	lw $t2, add_constant
	
	while:
		beq $t0, 10, saida
		
		mulu $t4, $t1, $t6
		addu $t5, $t4, $t2
		addi $t6, $t5, 0
		
		la $v0, 1
		move $a0, $t6
		syscall 
		
		li $v0, 4
		la $a0, newline
		syscall
		
		addi $t0, $t0, 1
		j while
		
	saida:
