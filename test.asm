.data
    valor: .word 0
    mutex: .word 1
    sinal_escrita: .word 0
    contador_escritas: .word 0
    contador_leituras: .word 0
    memoria_compartilhada: .space 4
    thread_produtor: .space 4
    thread_consumidor: .space 4

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
    lw $a0, contador_escritas
    lw $a1, contador_leituras

    # Finalizando o programa
    li $v0, 10
    syscall

produtor_thread:
    produtor_loop:
        # Verificando se o contador de escritas é igual a 12
        lw $t0, contador_escritas
        li $t1, 12
        beq $t0, $t1, fim_escrita

        # Tentando adquirir o mutex
        lw $t2, mutex
        beqz $t2, mutex_busy_produtor

        # Mutex livre, prosseguindo
        li $t2, 0
        sw $t2, mutex

        # Verificando se o consumidor leu o valor
        lw $t2, sinal_escrita
        beqz $t2, pode_escrever

        # Liberando o mutex
        li $t2, 1
        sw $t2, mutex

        j produtor_loop

    pode_escrever:
        # Escrevendo o valor na memória compartilhada
        li $t2, 42
        sw $t2, valor

        # Resetando o sinal de escrita
        li $t2, 0
        sw $t2, sinal_escrita

        # Liberando o mutex
        li $t2, 1
        sw $t2, mutex

        # Incrementando o contador de escritas
        lw $t2, contador_escritas
        addi $t2, $t2, 1
        sw $t2, contador_escritas

        # Espera um pouco antes de continuar (para simular um ambiente concorrente)
        li $v0, 33
        li $a0, 100000
        syscall

        j produtor_loop

    mutex_busy_produtor:
        # Esperando o mutex
        j produtor_loop

fim_escrita:
    jr $ra

consumidor_thread:
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

        # Setando o sinal de leitura para 1
        li $t0, 1
        sw $t0, sinal_escrita

        # Liberando o mutex
        li $t0, 1
        sw $t0, mutex

        # Incrementando o contador de leituras
        lw $t1, contador_leituras
        addi $t1, $t1, 1
        sw $t1, contador_leituras

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
