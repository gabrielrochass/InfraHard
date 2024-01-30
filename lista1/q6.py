# fazer o módulo de números positivos
# função recursiva que recebe dois número (a e b) e retorne a mod b

# se a for negativo, armazeno o valor 1 no registrador v1 e encerre o programa

# Um Rootkit deu a um invasor mais poderes do que ele deveria ter, e ele conseguiu deletar da codebase do Deep Thought o código responsável por fazer módulo de números positivos, com o comprometimento do cálculo do GCD (Greater Common Divisor), implemente (recursivamente) na linguagem de montagem do MIPS, uma função que receba dois números (a e b) e retorne a mod b. Se “a” for negativo, armazene o valor 1 no registrador v1 e encerre o programa.

def mod(a, b):
    if a < 0:
        v1 = 1
        return v1
    else:
        if a < b:
            return a
        else:
            return mod(a-b, b)


a = int(input())
b = int(input())
# print(mod(a, b))
mod(a, b)
