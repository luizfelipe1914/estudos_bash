#### Projeto 01

Scripts desenvolvidos para a atividade avaliativa referente ao conteúdo de Shell Script da disciplina de Programação para Redes do curso superior em Tecnologia em Rees de Computaores  do IFRN - Campus Natal-Central.

Semestre letivo de 2022.1 - Prof. [Galileu Batista de Sousa](http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K4727366J9&tokenCaptchar=03AEkXODAaGpY2beD45stI7rw4-hZSO0DqjYeYSIpJJVAqBn6McoEEq11RoIEMzxHY0D1DkxJRKXBO__Yk2mv9UBnGtWuQDVKrFq4aVde3IKJndSO3Rxn66cQ0Nmt-na5RN2QIayZHtzAASN_UuJRdu0rSAkaiFZciqV-MX7e-ItB4mvS-y44EY2EI6SkrtMe9j3cZAMyaZfCylBiaTzENXcXOQXpRDcRA25n633zFCug2K3kiJ06Wn6Gao2qtouzwaBIQWVBtfwcyqqvUiVmluwlcvDXow2nty3yAdihQam0TQMvVEd_dG2JZavd8SMhnDsBknEsbJnAj6QhUt7CTdbk65HdgFa182rlJfSWSnGz4jbjZUTeztuBO18sbkNQWgOvjDEcrrmJoI1tmYAeCifym5KkfntZ7sICt99-rvS48CEDKAVr-3jwn0dZDbzwrFzWq6q_c-tDIuCavQC8NPvJlNjEYegzQRGPUB0mLRr295zX4tQWb-YMuIVjgFrDTw5psuy-apBe2Tvj3i2VDEKnSCj9CkZhytG7FPmTd4XgCikOISMdfdN8) 



[Questão 01](./Q01/Q01.sh) . 

Existem algumas possibilidades de verificação de segurança relacionadas a
usuários em um ambiente Linux. Nesse sentido:


 a.  Faça um script que verifica se mais de um usuário tem o mesmo userid, pois, em geral, trata-se de uma forma de ocultar usuários que o administrador desconhece. Para essa versão busque os dados em /etc/passwd. Apresente um conjunto ordenado linhas, em que aparecem o userid e o login do usuário. Veja o exemplo:

```shell
0 root
0 hidden-root
5 gbat
5 galileu.gbs
5 gbat2k
```

 b. Repita o exercício anterior, mas mostre no segunte formato:

```shell
0 root, hidden-root
5 gbat, galileu.gbs, gbat2k
```

 c.  Ainda para fins de verificação de segurança, faça um script que mostra
todos os usuários que têm como programa inicial algum tipo de shell
(considere que uma shell tem no seu nome, excluído o caminho, o texto
sh). Apresente um conjunto ordenado linhas, em que aparecem o login
do usuário e a shell que ele utiliza.

[Questão 02](./Q02/Q02.sh) .

O diretório /proc contém centenas de informações sobre o sistema operacional e o hardware em que um Linux está executando. Faça um programa em bash que oferece repetidamente ao usuário o seguinte menu:

```shell
Opções:
    1) Informações da CPU (nome, frequência, etc)
    2) Informações sobre a memória total, usada e disponível
    3) Informações sobre o sistema operacional
    4) Número de processos em execução
    5) Dez processos com mais uso de memória (pid nome mem)
    6) Endereços IPv4 da máquina
    7) A tabela de rotas IPV4 (destino/mascara -> gateway)
Digite sua opção:
```

Dicas:

* As informações de CPU podem ser obtidas em /proc/cpuinfo. Mostre apenas as informações mais relevantes.

* As informações sobre uso de memória estão em /proc/meminfo.

* As informações sobre uso de memória estão em /proc/version.

* Cada processo tem uma pasta em /proc, contendo o seu pid.
  Ou seja, pastas em /proc cujo nome é formado por números
  representam processos.
  
  * ls -d pode ser usado para listar apenas os nomes de
    subdiretórios no presente diretório.

* A memória de um processo pode ser obtida no arquivo status,no diretório do processo em /proc. Como referência para esse exercício use o valor em VmSize.

* Os endereços IPV4 da máquina estão em /proc/net/fib_trie em cada uma das linhas logo acima de /32 host LOCAL.
  
  * Você pode usar grep -B 1 texto_a_buscar arquivo para que uma linha antes (o B é de before) do que for encontrado também seja exibido.

* A tabela de rotas pode ser encontrada em /proc/net/route.
  
  * É possível exibir um endereço IP que está em hexadeci-
    mal, little-endian, usando a seguinte função:
    
    ```shell
    print_ipv4() {
        for P in 6 4 2 0:
        do
            echo -n $((16#${1:$P:2})).
        done
    }
    ```
  
  * Uma chamada:
  
  * ```shell
    print_ipv4 0002000A # exibirá 10.0.2.0.
    ```
  
  * Em caso de uso dessa função, modifique-a para não exibir o . ao final.
