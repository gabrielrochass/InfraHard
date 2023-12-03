'''
Foi descoberta uma conspiração para impedir que a resposta para a vida, o universo e tudo o mais fosse encontrada. 
Felizmente, os rebeldes utilizaram um protocolo de esteganografia extremamente inseguro. Para ser capaz de decodificar as mensagens, 
escreva um programa em linguagem de montagem do MIPS que recebe uma null-terminated string e armazena apenas as letras maiúsculas em outra string. 
Em seguida, armazene a quantidade de letras maiúsculas no registrador v1 e encerre o programa.
'''
# recebe uma string e armazena apenas as letras maiúsculas em outra string

# recebe uma string
str1 = input()
str2 = ''
# armazena apenas as letras maiúsculas em outra string
for i in str1:
    if i.isupper():
        str2 += i

