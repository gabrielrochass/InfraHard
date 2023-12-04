# Código Assembly MIPS para calcular mod(a, b)

.data
    prompt_a: .asciiz "Digite o valor de a: "
    prompt_b: .asciiz "Digite o valor de b: "
    result: .asciiz "Resultado: "

.text
.globl main

main:
    # Solicitar entrada do usuário
    li $v0, 4
    la $a0, prompt_a
    syscall

    # Ler valor de a
    li $v0, 5
    syscall
    move $a0, $v0

    # Solicitar entrada do usuário
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

    move $a0, $v0
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
    beqz $t0, senao

    # Se a for negativo, armazenar 1 em $v0 e sair
    li $v0, 1
    j fim

senao:
    # Verificar se a < b
    slt $t0, $a0, $a1
    beqz $t0, senao2

    # Se a < b, retornar a
    move $v0, $a0
    j fim

senao2:
    # Calcular mod(a-b, b)
    sub $a0, $a0, $a1
    jal mod
    move $a0, $v0
    move $a1, $a1
    jal mod

fim:
    # Restaurar endereço de retorno
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

    # Retornar ao chamador
    jr $ra
    

