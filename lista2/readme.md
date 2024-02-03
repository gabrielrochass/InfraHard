Q5) (2,0) Crie dois programas em assembly MIPS, um produtor e um consumidor que acessam a memória atomicamente usando as instruções ll e sc. O produtor tenta escrever em um espaço na memória continuamente, mas só escreve se o espaço estiver vazio. O consumidor tenta ler continuamente em um espaço na memória, mas só lê quando o espaço tiver algum valor, quando o consumidor lê um valor ele o remove da memória. Ambos contam quantas vezes conseguiram ler/escrever com sucesso. (MARS não simula várias threads, então o ll e sc sempre funcionam nele)

Os assuntos envolvidos nessa questão são:

1. Assembly MIPS: É uma linguagem de baixo nível utilizada em arquiteturas MIPS (Microprocessor without Interlocked Pipeline Stages). É comumente usada em sistemas embarcados e dispositivos de hardware.

2. Memória Atômica: Refere-se à operação indivisível realizada pela CPU em relação à memória principal. Isso garante que operações de leitura e escrita em memória sejam realizadas de forma consistente, mesmo em ambientes concorrentes.

3. Instruções LL e SC (Load Linked e Store Conditional): São instruções especiais que permitem a implementação de operações de leitura e escrita atômicas em sistemas que suportam memória compartilhada e multiprocessadores. Load Linked (LL) é usado para carregar um valor da memória, enquanto Store Conditional (SC) é usado para armazenar um valor na memória se certas condições forem atendidas.

4. Produtor-Consumidor: É um padrão de programação concorrente em que um ou mais processos (produtores) geram dados e os colocam em uma área compartilhada de memória, enquanto um ou mais processos (consumidores) retiram esses dados da área compartilhada.

5. Controle de Concorrência: Envolve a implementação de mecanismos para garantir que os acessos concorrentes à memória compartilhada ocorram de forma segura e consistente, evitando condições de corrida e inconsistências nos dados.

---------------------------------
COMO RESPONDER:

1. Definição dos Requisitos:
Precisamos criar dois programas em assembly MIPS: um produtor e um consumidor.
Eles acessam a memória atomicamente usando as instruções ll (Load Linked) e sc (Store Conditional).
O produtor tenta escrever em um espaço na memória continuamente, mas só escreve se o espaço estiver vazio.
O consumidor tenta ler continuamente em um espaço na memória, mas só lê quando o espaço tiver algum valor. Quando o consumidor lê um valor, ele o remove da memória.
Ambos os programas devem contar quantas vezes conseguiram ler/escrever com sucesso.

2. Implementação do Produtor:
O produtor tenta escrever em um espaço na memória somente se estiver vazio.
Para isso, usamos ll para carregar o valor da memória e sc para armazenar o novo valor.
Se a operação sc for bem-sucedida, o produtor incrementa seu contador de escritas bem-sucedidas.

3. Implementação do Consumidor:
O consumidor tenta ler um valor da memória somente se houver algum valor presente.
Ele carrega o valor da memória com ll, verifica se é válido e, em caso afirmativo, remove o valor da memória.
Se a operação de leitura for bem-sucedida, o consumidor incrementa seu contador de leituras bem-sucedidas.

---------------
FUNÇÕES UTILIZADAS NO CÓDIGO:
1. sw (Store Word): Armazena um valor da CPU na memória.
2. beq (Branch if Equal): Desvia o fluxo de execução para o destino especificado se os dois registradores fornecidos forem iguais.
3. j (Jump): Salta para o endereço especificado.
4. jr (Jump Register): Salta para o endereço contido no registrador especificado.
5. jal (Jump and Link): Salta para o endereço especificado e armazena o endereço de retorno (o endereço da próxima instrução após o jal) no registrador $ra (registrador de retorno).
6. addi (Add Immediate): Adiciona um valor imediato a um registrador.
7. sc (Store Conditional): Condição de armazenamento. Tenta armazenar um valor em um endereço de memória. Se a operação for bem-sucedida, o registrador de destino é definido como 1, caso contrário, é definido como 0.
8. ll (Load Linked): Carrega um valor da memória para um registrador. Essa operação é "vinculada" a uma operação de armazenamento condicional, para que a CPU possa verificar se a memória foi modificada desde a última leitura.

-----------------------------------------
QUESTION 7
(2,5) Observe o código em assembly MIPS abaixo (considere que o código será executado em um processador pipeline de cinco estágios com um slot para Delayed Branch e com forwarding MEM -> EX):

(0,35) Transcreva o assembly acima para o pseudocódigo de sua preferência.
(0,1) Indique quais instruções não afetam o comportamento observável do programa.
(0,1) Indique quais instruções podem ser convertidas em instruções que usam menos ciclos.
(0,1) Indique quais instruções são repetidas desnecessariamente dentro de loops.
(0,1) Indique quais instruções não afetam a execução de nenhuma outra instrução.
(1,0) Utilize as informações listadas nas questões anteriores para otimizar o código o máximo possível, reduzindo os ciclos por instrução ao mínimo. Lembre-se de reordenar instruções para evitar stalls causados por conflitos estruturais e de dados.
(0,75) Faça o diagrama multiciclo da pipeline e calcule os CPI.

-> entendendo o codigo:

addi $a0, $zero, 5 = $a0 <- $zero + 5
add $t2, $zero, $s0 = $t2 <- $zero + $s0

rotulos sao utilizados para estruturar o fluxo de controle de um programa -> usadas em loops e condicionais. n tem efeito sobre a execucao do codigo (apenas marcadores). pode pular para partes especificas do codigo

begin_loop: rotulo de inicio de loop
blt $t0, $t4, if_end = pula para o rotudo if_end se $t0 < $t4

if_end:fim do bloco condicional iniciado pela instrucao blt
mult $s0, $t0 = $s0 x $t0 e armazena o resultado em um par de registradore sespeciais (HI e LO)
mflo $s0 = LO -> $s0

bne $t0, $a0, begin_loop = pula para begin_loop se $t0 != $a0

pseudocodigo:
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

---------------------
nao afetam a execucao de outras instrucoes:

addi $s2, $s1, 3
add $t3, $zero, $s0
add $s1, $s1, $t2
add $t2, $zero, $t3
add $s3, $s1, $s0
add $s2, $s2, $s0
