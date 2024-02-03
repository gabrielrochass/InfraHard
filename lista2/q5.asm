.data
    valor: .word 0
    mutex: .word 1
    contador_escritas: .word 0
    contador_leituras: .word 0
    memoria_compartilhada: .space 4
    thread_produtor: .space 4
    thread_consumidor: .space 4
    msg_produtor_sucesso: .asciiz "Produtor escreveu com sucesso.\n"
    msg_consumidor_leitura: .asciiz "Consumidor leu: "
    msg_consumidor_vazio: .asciiz "Espaço de memória vazio. Tentando novamente.\n"
    msg_contador_escritas: .asciiz "Número de escritas bem-sucedidas: "
    msg_contador_leituras: .asciiz "Número de leituras bem-sucedidas: "

.text
.globl main

main:
    # Inicializando a memória compartilhada
    li $t0, 0
    sw $t0, valor
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

    # Exibindo o número de escritas e leituras bem-sucedidas
    li $v0, 4
    la $a0, msg_contador_escritas
    syscall
    lw $a0, contador_escritas
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, msg_contador_leituras
    syscall
    lw $a0, contador_leituras
    li $v0, 1
    syscall

    # Finalizando o programa
    li $v0, 10
    syscall

produtor_thread:
    # Loop infinito do produtor
    produtor_loop:
        # Tentando adquirir o mutex
        lw $t0, mutex
        beqz $t0, mutex_busy_produtor

        # Mutex livre, prosseguindo
        li $t0, 0
        sw $t0, mutex

        # Escrevendo o valor na memória compartilhada
        li $t0, 42
        sw $t0, valor

        # Liberando o mutex
        li $t0, 1
        sw $t0, mutex

        # Incrementando o contador de escritas
        lw $t0, contador_escritas
        addi $t0, $t0, 1
        sw $t0, contador_escritas

        # Imprimindo mensagem de sucesso
        li $v0, 4
        la $a0, msg_produtor_sucesso
        syscall

        # Espera um pouco antes de continuar (para simular um ambiente concorrente)
        li $v0, 33
        li $a0, 100000
        syscall

        j produtor_loop

    mutex_busy_produtor:
        # Esperando o mutex
        j produtor_loop

consumidor_thread:
    # Loop infinito do consumidor
    consumidor_loop:
        # Tentando adquirir o mutex
        lw $t0, mutex
        beqz $t0, mutex_busy_consumidor

        # Mutex livre, prosseguindo
        li $t0, 0
        sw $t0, mutex

        # Lendo o valor da memória compartilhada
        lw $t0, valor

        # Verificando se o valor é zero
        beqz $t0, valor_nulo

        # Imprimindo o valor lido
        li $v0, 4
        la $a0, msg_consumidor_leitura
        syscall
        move $a0, $t0
        li $v0, 1
        syscall

        # Incrementando o contador de leituras
        lw $t0, contador_leituras
        addi $t0, $t0, 1
        sw $t0, contador_leituras

        # Liberando o mutex
        li $t0, 1
        sw $t0, mutex

        # Espera um pouco antes de continuar (para simular um ambiente concorrente)
        li $v0, 33
        li $a0, 100000
        syscall

        j consumidor_loop

    mutex_busy_consumidor:
        # Esperando o mutex
        j consumidor_loop

    valor_nulo:
        # Liberando o mutex
        li $t0, 1
        sw $t0, mutex

        # Imprimindo mensagem de espaço de memória vazio
        li $v0, 4
        la $a0, msg_consumidor_vazio
        syscall

        # Espera um pouco antes de continuar (para simular um ambiente concorrente)
        li $v0, 33
        li $a0, 100000
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
