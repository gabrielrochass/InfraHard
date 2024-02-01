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
