#!/bin/bash



# Função que exibe o menu inicial
function menu() {
	echo "Opções:"
	echo -e "\t 1) Informações da CPU (nome, frequência, etc)"
	echo -e "\t 2) Informações sobre a memória total, usada e disponível"
	echo -e "\t 3) Informações sobre o sistema operacional"
	echo -e "\t 4) Número de processos em execução"
	echo -e "\t 5) Dez processos com mais uso de memória (pid nome mem)"
	echo -e "\t 6) Endereços IPv4 da máquina"
	echo -e "\t 7) A tabela de rotas IPV4 (destino/mascara -> gateway)"
	echo -e "\t CTRL + C) SAIR"
	echo -e "\t Digite sua opção:"
}

#Função que verifica o modelo, o nº de cores e a frequência do processador.
#Basicamente, é procurado o parâmetro dentro do arquivo e os valores são extraídos por meio do comando
#cut utilizando um determinado separador.
function lsCPU(){
	echo -e "Modelo do processador: $(grep -w "model name" /proc/cpuinfo | cut -d@ -f1 | cut -d: -f2| uniq)"
	echo -e "Número de cores: $(grep -w "cpu cores" /proc/cpuinfo | cut -d: -f2 | uniq)"
	echo -e "Frequência do processador $(grep -w "model name" /proc/cpuinfo | cut -d@ -f2 | uniq)"
}

# Idem à função anterior, porém busca-se os valores no arquivo /proc/meminfo
function lsRAM(){
	echo -e "Memória total $(grep -w "MemTotal"  /proc/meminfo | cut -d: -f2)"
	echo -e "Memória em uso: $(grep -w "Active:"  /proc/meminfo | cut -d: -f2)"
	echo -e "Memória disponível: $(grep -w "MemAvailable"  /proc/meminfo | cut -d: -f2)"
}

# Função que lista os 10 processos com maior consumo de memória.
# Busca-se no arquivo status dentro dos diretórios correspondentes a processos o valor do parâmetro
# Vmsize. A listagem é decrescente é utiliza o valor nmérico de VmSize(3ª coluna). É extraído o valor do PID do
# processo.  Em seguida, são buscadasm no arquivo status dentro do diretório do processo, o nome e o uso de memória(VmSize)  
function top10(){
	for x in $(grep "VmSize" /proc/[0-9]*/status | sort -rn -t: -k3 | head -n 10 | cut -d/ -f3); do
		echo -e "---------------------------------------------------"
		echo "Nome: " $(grep "Name" /proc/$x/status | cut -d: -f2)
		echo "PID: $x"
		echo -e "Uso de memória: " $(grep "VmSize" /proc/$x/status | cut -d: -f2)
	done
}

function print_ipv4() {
	for P in 6 4 2 0;
	do
		echo -n $((16#${1:$P:2})). 
	done
}

# Função que exibe a tabela de roteamento da máquina
# Basicamente os parâmetros solicitados são extraídos de /proc/net/route e enviados
# para a função print_ipv4 que converte para a notação decimal do IPv4.
function print_route_table(){

	for x in $(sed -n '2,$p' /proc/net/route | awk '{print $2, $3, $8}'); do
		DEST=$(echo $x | awk '{print $1}') 
		GAT=$(echo $x | awk '{print $2}') 
		MASK=$(echo $x | awk '{print $3}') 
		echo -e "$(print_ipv4 $DEST| tr -t':.' ' ')/$(print_ipv4 $MASK|tr ':.' ' ') -> $(print_ipv4 $GAT|tr ':.' ' ')"
	done
}



# Loop que fica em execução até ser informado o CTRL+C(código 130)
while [[ $? -ne 130 ]]; do
	menu
	read op

	case $op in # Basicamente, é verificado o valor informado e invocada a função correspondente a funcionalidade desejado.
		1)
			lsCPU
			;;
		2)
			lsRAM
			;;

		3)
			cat /proc/version | awk '{print "Distro: " $8,$9 "\nVersão do Kernel: "$3}'
			;;
		4)
			# Verifica a quantidade de diretórios correspondentes a processos.
			echo -e 'Número de processos "em execução":' $(ls -d /proc/[0-9]* | wc -l)
			;;
		5)
			top10
			;;
		6)
			# Verifica os endereços IP da máquina
			grep -B 1 "/32 link BROADCAST" /proc/net/fib_trie | grep "|--" | awk '{print $2}'
			;;
		7)
			print_route_table
			;;

		*)
			echo -e "Entrada inválida!"
			;;

	esac
	
done


