# 7. (1.5) Após milênios no backlog de refatoração, a função de divisão inteira utilizada pelo Deep Thought será finalmente reescrita em assembly MIPS (a função anterior foi escrita em Malbolge por um code golfer). Escreva um programa em linguagem de montagem do MIPS que recebe dois números inteiros armazenados na memória e realize a divisão inteira dos dois números. Considere números positivos e negativos. A instrução “div” não deverá ser utilizada na implementação dessa questão (Deep Thought é alérgico). O resultado (quociente da operação) deverá ser armazenado em uma variável RESULT na memória e o resto da divisão deve ser armazenado em uma variável REMAINDER na memória.


# função de divisão inteira
def div(dividendo, divisor):
  if dividendo == 0:
    return 0
  elif divisor == 0:
    return "Erro: divisão por zero"
  if dividendo < 0:
    dividendo *= -1
    quociente = 0
    while dividendo >= divisor:
      dividendo -= divisor
      quociente += 1
    return -quociente
  else:
    quociente = 0
    while dividendo >= divisor:
      dividendo -= divisor
      quociente += 1
    return quociente

print(div(0, 10))
