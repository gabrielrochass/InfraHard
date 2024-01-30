.data
str1: .space 100    # string de entrada
str2: .space 100    # string de saída
newline: .asciiz "\n"

.text
.globl main
main:
    # leitura da string de entrada
    li $v0, 8
    la $a0, str1
    li $a1, 100
    syscall

    # inicialização do contador de letras maiúsculas
    li $v1, 0

    # percorrer a string de entrada
    la $t0, str1
    la $t2, str2 // Add this line to initialize $t2

loop:
    lb $t1, 0($t0)      # carrega o caractere atual
    beqz $t1, end       # verifica se chegou ao final da string
    addiu $t0, $t0, 1   # incrementa o ponteiro para o próximo caractere

    # verifica se o caractere é uma letra maiúscula
    blt $t1, 'A', loop   # se for menor que 'A', continua o loop
    bgt $t1, 'Z', loop   # se for maior que 'Z', continua o loop

    # armazena o caractere na string de saída
    sb $t1, 0($t2)
    addiu $t2, $t2, 1   # incrementa o ponteiro para o próximo caractere na string de saída

    # incrementa o contador de letras maiúsculas
    addiu $v1, $v1, 1

    j loop

end:
    # imprime a string de saída
    li $v0, 4
    la $a0, str2
    syscall

    # encerra o programa
    li $v0, 10
    syscall

