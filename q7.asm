addi $a0, $zero, 5
addi $s0, $zero, 1
addi $s2, $s1, 3
add $t2, $zero, $s0
add $t3, $zero, $s0
addi $s2, $zero, 32
begin_loop:
addi $t4, $zero, 2
add $t0, $t0, 1
blt $t0, $t4, if_end
add $t3, $t1, $t2
add $s1, $s1, $t2
add $t1, $zero, $t2
add $t2, $zero, $t3    
if_end:
mult $s0, $t0
mflo $s0 
add $s1, $zero, $t1
bne $t0, $a0, begin_loop
add $s3, $s1, $s0
mult $s1, $s2
mflo $s2
add $s2, $s2, $s0  

---------------------
// Inicializar variáveis
$a0 = 5
$s0 = 1
$s2 = $s1 + 3
$t2 = $s0
$t3 = $s0
$s2 = 32

// Início do loop
begin_loop:
$t4 = 2
$t0 = $t0 + 1
if $t0 < $t4, vá para if_end
$t3 = $t1 + $t2
$s1 = $s1 + $t2
$t1 = $t2
$t2 = $t3

if_end:
$s0 = $s0 * $t0
$s0 = $lo
$s1 = $t1
se $t0 != $a0, vá para begin_loop

$s3 = $s1 + $s0
$s2 = $s1 * $s2
$s2 = $s2 + $s0

-----------------
# nao afeta o comportamento observavel do programa
# Uma instrução que "não afeta o comportamento observável" do programa é uma instrução cuja remoção não mudaria a saída ou os efeitos colaterais do programa.
addi $a0, $zero, 5
addi $s0, $zero, 1
add $t2, $zero, $s0
add $t3, $zero, $s0
addi $t4, $zero, 2
add $t0, $t0, 1

# Essas instruções estão apenas inicializando ou incrementando valores de registradores, mas esses registradores ($a0, $s0, $t2, $t3, $t4, $t0) não são usados em nenhuma operação subsequente que afetaria a saída ou os efeitos colaterais do programa.

---------------------
#nao afetam a execucao de outras instrucoes:

addi $s2, $s1, 3
add $t3, $zero, $s0
add $s1, $s1, $t2
add $t2, $zero, $t3
add $s3, $s1, $s0
add $s2, $s2, $s0
