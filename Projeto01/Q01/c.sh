#!/bin/bash

# Luiz Felipe e Silva Machado - 20201014050008
# Sara Maria Caldas Rego - 20212014050020

grep "sh$" /etc/passwd | awk -F":" '{print "Usuário:"$1 " shell:" $7}'

# Busca pelas linhas terminadas em "sh" no arquivo /etc/passwd e envia a saída para o awk que, utilizando ":" como separador, 
# recupera a 1ª coluna(nome de usuário)
# e a 7ª(shell do usuário)