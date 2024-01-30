.data
    prompt_a: .asciiz "Digite o valor de a: "
    prompt_b: .asciiz "Digite o valor de b: "
    result: .asciiz "Resultado: "

.text
.globl main

main:
    # Solicitar entrada do usuário para a
    li $v0, 4
    la $a0, prompt_a
    syscall

    # Ler valor de a
    li $v0, 5
    syscall
    move $a0, $v0

    # Solicitar entrada do usuário para b
    li $v0, 4
    la $a0, prompt_b
    syscall

    # Ler valor de b
    li $v0, 5
    syscall
    move $a1, $v0

    # Chamar a função mod
    jal mod

    # Imprimir resultado
    li $v0, 4
    la $a0, result
    syscall

    move $a0, $v0  # Mova o resultado para $a0 antes de imprimir
    li $v0, 1
    syscall

    # Encerrar programa
    li $v0, 10
    syscall

mod:
    # Salvar endereço de retorno
    sw $ra, 0($sp)
    addiu $sp, $sp, -4

    # Verificar se a é negativo
    slti $t0, $a0, 0
    beqz $t0, else

    # Se a for negativo, armazenar 1 em $v0 e sair
    li $v0, 1
    j end

else:
    # Verificar se a < b
    slt $t0, $a0, $a1
    beqz $t0, else2

    # Se a < b, retornar a
    move $v0, $a0
    j end

else2:
    # Calcular mod(a-b, b)
    sub $a0, $a0, $a1
    move $t1, $a1
    jal mod
    move $a0, $v0
    move $a1, $t1
    jal mod

end:
    # Restaurar endereço de retorno
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

    # Retornar ao chamador
    jr $ra
