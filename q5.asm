.data
    memory: .word 0            # Espaço na memória compartilhada
    success_writes: .word 0   # Contador de escritas bem-sucedidas
    success_reads: .word 0    # Contador de leituras bem-sucedidas

.text
main:
    # Inicialização do produtor e do consumidor
    la $a0, memory
    la $a1, success_writes
    la $a2, success_reads

    # Iniciar threads para o produtor e o consumidor
    jal producer
    jal consumer

producer:
    # Loop do produtor
    loop_producer:
        ll $t0, 0($a0)         # Load Linked
        beq $t0, $zero, write  # Se o espaço estiver vazio, escreva
        j loop_producer        # Caso contrário, continue tentando escrever

    write:
        li $t1, 1               # Novo valor para escrever
        sc $t1, 0($a0)          # Store Conditional
        beq $t1, $zero, loop_producer # Se falhar, tente novamente
        addi $t2, $zero, 1      # Incrementa contador de escritas bem-sucedidas
        add $t2, $t2, $a1
        sw $t2, 0($a1)
        j loop_producer

consumer:
    # Loop do consumidor
    loop_consumer:
        ll $t3, 0($a0)         # Load Linked
        beq $t3, $zero, loop_consumer # Se o espaço estiver vazio, continue lendo

        # Se houver um valor, leia e remova
        sw $zero, 0($a0)       # Remove o valor da memória
        addi $t4, $zero, 1     # Incrementa contador de leituras bem-sucedidas
        add $t4, $t4, $a2
        sw $t4, 0($a2)
        j loop_consumer

    # Fim do programa
    jr $ra

