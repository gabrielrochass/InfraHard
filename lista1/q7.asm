# variáveis para armazenar valores
.data
dividendo:  .word 0          # armazena o dividendo
divisor:    .word 0          # armazena o divisor
result:     .word 0          # armazena o resultado (quociente)
input_msg:  .asciiz "Digite o dividendo: "# msg de input 1
input_msg2: .asciiz "Digite o divisor: " # msg de input 2
newline:    .asciiz "\n" # printa quebra de linha

.text
.globl main

main:
    # solicita e recebe o dividendo
    li $v0, 4
    la $a0, input_msg
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # armazena o dividendo

    # solicita e recebe o divisor
    li $v0, 4
    la $a0, input_msg2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0  # armazena o divisor

    # inicializa o registrador para quociente
    li $t2, 0
    # li $t3, 0

    # verifica condições e executa a divisão
    beq $t0, $zero, store_values  # se dividendo = 0, encerra printando 0 e pula para sair
    beq $t1, $zero, error_divisor # se divisor = 0, printa erro e sai

    blt $t0, $zero, negative_dividend  # se dividendo < 0, executa divisão para números negativos

    positive_dividend:
        loop_positive:
            sub $t0, $t0, $t1  # subtrai o divisor do dividendo
            bge $t0, $zero, increment_positive  # se o dividendo >= 0, incrementa o quociente
            j exit_positive

        increment_positive:
            addi $t2, $t2, 1  # incrementa o quociente
            j loop_positive

    negative_dividend:
        neg $t0, $t0
        loop_negative:
            sub $t0, $t0, $t1  # subtrai o divisor do dividendo
            bge $t0, $zero, increment_negative  # se o dividendo >= 0, incrementa o quociente
            j exit_negative

        increment_negative:
            addi $t2, $t2, 1  # incrementa o quociente
            j loop_negative

    exit_positive:
        j store_values

    exit_negative:
        neg $t2, $t2  # transforma o quociente em negativo
        j store_values

    error_divisor:
        la $a0, error_message  # carrega mensagem de erro
        li $v0, 4              # printa string
        syscall
        j exit_program

    store_values:
        sw $t2, result  # armazena o quociente na variável RESULT
        
        # printa o quociente
        lw $a0, result
        li $v0, 1
        syscall

        # printa quebra de linha
        li $v0, 4
        la $a0, newline
        syscall

        j exit_program  # finaliza o programa

    exit_program:
        li $v0, 10  # Syscall para encerrar o programa
        syscall

    # Dados
    .data
    error_message: .asciiz "Erro: divisão por zero"  # msg de erro
