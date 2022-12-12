#!/bin/bash

# Luiz Felipe e Silva Machado - 20201014050008
# Sara Maria Caldas Rego - 20212014050020

for x in $(cat /etc/passwd | awk -F':' '{print $3}'); do
	USERS=$(cat /etc/passwd | awk -F':' '{print $3, $1}'| grep -w "$x" | awk '{print $2}' | tr '\n' ', ') 
	echo "$x $USERS" | sort -n  
done

#Linha 4: Gera uma lista com todos os UIDs dos usuários presentes no arquivo /etc/passwd. Utilizando ":" como separador
# para o awk, a 3ª coluna(uid) é recuperada. Na linha 5 é gerada uma lista com os logins dos usuários que tiverem o uid igual
# ao valor da variável x. a saída é enviada para o comando tr que substitui as quebras de linha(\n) por uma vírcgula e um espaço.
#Linha 6:  Por fim, o UID, juntamente com a lista de todos os usuários que possuem esse uid é exibida de forma ordenada numericamente.