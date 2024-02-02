.data
    valor: .word 0
    mutex: .word 0
    contador_escritas: .word 0
    contador_leituras: .word 0
    memoria_compartilhada: .space 4
    thread_produtor: .space 4
    thread_consumidor: .space 4
    msg_produtor_sucesso: .asciiz "Produtor escreveu com sucesso.\n"
    msg_consumidor_leitura: .asciiz "Consumidor leu: "
    msg_consumidor_vazio: .asciiz "Espaço de memória vazio. Tentando novamente.\n"

.text
.globl main

main:
    # Inicializando a memória compartilhada
    li $t0, 0
    sw $t0, valor
    sw $t0, mutex
    sw $t0, contador_escritas
    sw $t0, contador_leituras

    # Criando a thread do produtor
    la $a0, memoria_compartilhada
    jal produtor_thread
    sw $v0, thread_produtor

    # Criando a thread do consumidor
    la $a0, memoria_compartilhada
    jal consumidor_thread
    sw $v0, thread_consumidor

    # Aguardando as threads terminarem
    jal wait_threads

    # Finalizando o programa
    li $v0, 10
    syscall

produtor_thread:
    # Loop infinito do produtor
    produtor_loop:
        # Tentando adquirir o mutex
        li $v0, 1
        lw $t0, mutex
        beqz $t0, mutex_acquired

        # Espaço de memória ocupado, tentando novamente
        li $v0, 0
        j produtor_loop

    mutex_acquired:
        # Escrevendo o valor na memória compartilhada
        li $t0, 42
        sw $t0, valor

        # Incrementando o contador de escritas
        lw $t0, contador_escritas
        addi $t0, $t0, 1
        sw $t0, contador_escritas

        # Imprimindo mensagem de sucesso
        la $a0, msg_produtor_sucesso
        li $v0, 4
        syscall

        j produtor_loop

consumidor_thread:
    # Loop infinito do consumidor
    consumidor_loop:
        # Tentando adquirir o mutex
        li $v0, 1
        lw $t0, mutex
        beqz $t0, mutex_acquired_consumidor

        # Espaço de memória vazio, tentando novamente
        li $v0, 0
        j consumidor_loop

    mutex_acquired_consumidor:
        # Lendo o valor da memória compartilhada
        lw $t0, valor

        # Verificando se o valor é zero
        beqz $t0, valor_nulo

        # Imprimindo o valor lido
        la $a0, msg_consumidor_leitura
        li $v0, 4
        syscall
        move $a0, $t0
        li $v0, 1
        syscall

        j consumidor_loop

    valor_nulo:
        # Imprimindo mensagem de espaço de memória vazio
        la $a0, msg_consumidor_vazio
        li $v0, 4
        syscall

        j consumidor_loop

wait_threads:
    # Aguardando as threads terminarem
    jal wait_thread_produtor
    jal wait_thread_consumidor

    jr $ra

wait_thread_produtor:
    # Aguardando a thread do produtor
    li $v0, 11
    lw $a0, thread_produtor
    syscall

    jr $ra

wait_thread_consumidor:
    # Aguardando a thread do consumidor
    li $v0, 11
    lw $a0, thread_consumidor
    syscall

    jr $ra
