#!/bin/bash

# Luiz Felipe e Silva Machado - 20201014050008
# Sara Maria Caldas Rego - 20212014050020

##############################################################################
#																			 #
# Efetua a leitura do arquivo /etc/passwd e envia a saída para o comando 	 #
# awk que, utilizando como separador ":", exibirá a 3ª e a 1ª	 			 #
# colunas as quais, são, respectivamente o uid e o login do usuário. o 		 #
# comando sort com o parâmetro -n é empregado para agrupar a saída pelo uid. #
#																			 #
##############################################################################

cat /etc/passwd | awk -F':' '{print $3,$1}' | sort -n


