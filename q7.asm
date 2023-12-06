# Definindo as variáveis
.data
dividendo:  .word 0          # Armazena o dividendo
divisor:    .word 0          # Armazena o divisor
RESULT:     .word 0          # Armazena o resultado (quociente)
input_msg:  .asciiz "Digite o dividendo: "
input_msg2: .asciiz "Digite o divisor: "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Mensagem para entrada do dividendo
    li $v0, 4
    la $a0, input_msg
    syscall

    # Recebendo o dividendo
    li $v0, 5
    syscall
    move $t0, $v0  # Armazena o dividendo em $t0

    # Mensagem para entrada do divisor
    li $v0, 4
    la $a0, input_msg2
    syscall

    # Recebendo o divisor
    li $v0, 5
    syscall
    move $t1, $v0  # Armazena o divisor em $t1

    li $t2, 0       # Inicializa o registrador $t2 para o quociente
    li $t3, 0       # Inicializa o registrador $t3 para o resto

    # Verifica se o dividendo é zero
    beq $t0, $zero, zero_dividend
    # Verifica se o divisor é zero
    beq $t1, $zero, error_divisor

    # Verifica se o dividendo é negativo
    blt $t0, $zero, negativo
    positivo:
        loop_positivo:
            sub $t0, $t0, $t1  # Subtrai o divisor do dividendo
            bge $t0, $zero, increment_positivo  # Se o dividendo >= 0, incrementa o quociente
            j exit_positivo
        increment_positivo:
            addi $t2, $t2, 1  # Incrementa o quociente
            j loop_positivo
    negativo:
        neg $t0, $t0  # Transforma o dividendo em positivo
        loop_negativo:
            sub $t0, $t0, $t1  # Subtrai o divisor do dividendo
            bge $t0, $zero, increment_negativo  # Se o dividendo >= 0, incrementa o quociente
            j exit_negativo
        increment_negativo:
            addi $t2, $t2, 1  # Incrementa o quociente
            j loop_negativo

    exit_positivo:
        j store_values
    exit_negativo:
        neg $t2, $t2  # Transforma o quociente em negativo
        j store_values

    zero_dividend:
        j store_values

    error_divisor:
        la $a0, error_message  # Carrega o endereço da mensagem de erro em $a0
        li $v0, 4              # Código da syscall para imprimir string
        syscall
        j exit_program

    store_values:
        move $t3, $t0          # Move o valor final do dividendo para $t3 (resto)
        sw $t2, RESULT         # Armazena o quociente na variável RESULT
        sw $t3, REMAINDER      # Armazena o resto na variável REMAINDER

        # Imprime os valores do quociente e do resto
        lw $a0, RESULT         # Carrega o quociente para imprimir
        li $v0, 1              # Código da syscall para imprimir inteiro
        syscall

        li $v0, 4              # Código da syscall para imprimir string
        la $a0, newline        # Carrega a quebra de linha
        syscall

        j exit_program

    exit_program:
        li $v0, 10            # Código da syscall para sair do programa
        syscall

    # Dados
    .data
    error_message: .asciiz "Erro: divisão por zero"
