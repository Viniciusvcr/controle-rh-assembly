# Registro
#   Nome      : string (31 bytes)
#   rua       : string (31 bytes)
#   numero    : int    (4 bytes)
#   bairro    : string (31 bytes)
#   CEP       : string (9 bytes)
#   cidade    : string (31 bytes)
#   telefone  : string (10 bytes)
#   email     : string (31 bytes)
#   data_nasc : string (11 bytes)
#   gênero    : int (4 bytes)
#   CPF       : string (12 bytes)
#   RG        : string (10 bytes)
#   data_contr: string (11 bytes)
#   cargo     : string (31 bytes)
#   salario   : double (8 bytes)
#   prox      : int (4 bytes)
#
# Total de bytes: 269 bytes

.section .data
    # Mensagens do sistema
    mens_abertura:          .asciz "Bem vindo ao controle de RH\n\n"
    mens_sair:              .asciz "Saindo do programa... Obrigado por utilizar!\n"
    mens_inserir:           .asciz "Inserir funcionário:\n\n"
    mens_remover:           .asciz "Remover funcionário:\n\n"
    mens_consult:           .asciz "Consulta de funcionário:\n\n"
    mens_relat:             .asciz "Relatório de funcionários:\n\n"
    mens_invalido:          .asciz "Opção inválida!\n\n"
    mens_nao_encontrado:    .asciz "\n\nNome não encontrado na lista!\n\n"
    mens_remocao_concluida: .asciz "\n\nRemoção do(a) funcionário(a) %s concluída com sucesso!\n\n"
    mens_lista_vazia:       .asciz "Não há funcionários cadastrados no sistema!\n\n"
    str_menu:               .asciz "Escolha uma opção do programa:\n\t1 - Inserir funcionário\n\t2 - Remover funcionário\n\t3 - Consultar funcionário\n\t4 - Relatório de registros\n\t0 - Sair do programa\n> "

    # Mensagens de pedidos ao usuário
    pede_nome:         .asciz "Insira o NOME do funcionário: "
    pede_rua:          .asciz "Insira a RUA do funcionário: "
    pede_numero:       .asciz "Insira o NÚMERO da casa do funcionário: "
    pede_bairro:       .asciz "Insira o BAIRRO do funcionário: "
    pede_cep:          .asciz "Insira o CEP do funcionário: "
    pede_cidade:       .asciz "Insira a CIDADE do funcionário: "
    pede_telefone:     .asciz "Insira o TELEFONE do funcionário: "
    pede_email:        .asciz "Insira o EMAIL do funcionário: "
    pede_data_nasc:    .asciz "Insira a DATA DE NASCIMENTO do funcionário: "
    pede_genero:       .asciz "Insira o gênero do funcionário (<M>asculino, <F>eminino): "
    pede_cpf:          .asciz "Insira o CPF do funcionário: "
    pede_rg:           .asciz "Insira o RG do funcionário: "
    pede_data_contr:   .asciz "Insira a DATA DE CONTRATO do funcionário: "
    pede_cargo:        .asciz "Insira o CARGO do funcionário: "
    pede_salario:      .asciz "Insira o SALÁRIO do funcionário: "
    pede_nome_remover: .asciz "Insira o NOME do funcionário que deseja REMOVER: "
    pede_nome_consult: .asciz "Insira o NOME do funcionário que deseja CONSULTAR: "

    # Mensagens para escrita do registro na tela
    mostra_nome:       .asciz "FUNCIONÁRIO(A) %s: \n"
    mostra_rua:        .asciz "\tRUA          : %s\n"
    mostra_numero:     .asciz "\tNÚMERO       : %d\n"
    mostra_bairro:     .asciz "\tBAIRRO       : %s\n"
    mostra_cep:        .asciz "\tCEP          : %s\n"
    mostra_cidade:     .asciz "\tCIDADE       : %s\n"
    mostra_telefone:   .asciz "\tTELEFONE     : %s\n"
    mostra_email:      .asciz "\tEMAIL        : %s\n"
    mostra_data_nasc:  .asciz "\tNASCIMENTO   : %s\n"
    mostra_genero:     .asciz "\tGÊNERO       : %c\n"
    mostra_cpf:        .asciz "\tCPF          : %s\n"
    mostra_rg:         .asciz "\tRG           : %s\n"
    mostra_data_contr: .asciz "\tCONTRATADO EM: %s\n"
    mostra_cargo:      .asciz "\tCARGO        : %s\n"
    mostra_salario:    .asciz "\tSALARIO      : R$ %.2lf\n"

    # Mensagens de conclusão (Inserção e consulta de registros)
    conclui_insercao: .asciz "\nNovo funcionário cadastrado com sucesso!\n\n"
    divisor_reg:      .asciz "=================================================================\n\n"

    # Constantes de escolhas para o menu
    func_inserir:   .int 1
    func_remover:   .int 2
    func_consultar: .int 3
    func_relatorio: .int 4
    func_sair:      .int 0

    # Formatadores para scanf e printf
    int_fmt:      .asciz "%d"
    double_fmt:   .asciz "%lf"
    char_fmt:     .asciz "%c"

    # Constante NULL
    NULL: .int 0

    # Variáveis da lista encadeada
    list_header: .int 0
    tam_reg:     .int 269

    # Outras variáveis
    nome_inserido: .int 0
    resp_menu: .int 0

.section .text

.globl _start

# Função para mostrar o menu e esperar a escolha do usuário
# Esta função altera o estado do registrador %eax
menu:
    pushl $str_menu
    call printf # Imprime na tela o menu do sistema
    addl $4, %esp # Remove str_menu da pilha

    pushl $resp_menu # Variável que a resposta do usuário será armazenada
    pushl $int_fmt # Formatador de inteiros para o scanf
    call scanf # Chamada do scanf
    movl resp_menu, %eax # move a resposta do menu de escolhas para %eax
    addl $8, %esp # Remove resp_menu e int_fmt da pilha
    
    ret

######################### Funções primárias #########################
# Estas são as funções principais do Controle de RH

# Função para inserir um funcionário nos registros
# Altera os mesmos registradores que printf/scanf/fgets
inserir_funcionario:
    pushl $mens_inserir
    call printf # Escreve na tela a mensagem de abertura da função
    addl $4, %esp # Remove a string de mensagem de abertura da pilha

    pushl $pede_nome
    call printf # Solicita o nome do novo funcionário (para ordenação dos registros)
    addl $4, %esp # remove $pede_nome da pilha
    pushl $nome_inserido # Empilha o endereço da variável que recebera o input do usuário
    call gets # Limpa o buffer (veio da leitura de inteiro do menu do programa)
    call gets # Efetivamente lê o nome do novo funcionário
    addl $4, %esp # Remove $nome_inserido da pilha

    movl $NULL, %eax; # Move o endereço da constante NULL para %eax
    cmpl %eax, list_header # Verifica se a lista é vazia
    je aloca_primeiro # se a lista for vazia, aloca o primeiro
    jne aloca_ordenado # se a lista não for vazia, aloca e faz as operações de inserção ordenada

    # aloca_primeiro e aloca_final pulam para o procedimento auxiliar "le_registro", que contém o ret

remover_funcionario:
    pushl $mens_remover
    call printf # Escreve na tela a mensagem de abertura da função
    pushl $pede_nome_remover 
    call printf # Escreve na tela a mensagem de pedido do nome para consulta
    addl $8, %esp # Remove as strings de mensagem da pilha
   
    pushl $nome_inserido # Empilha o endereço da variável para leitura do nome
    call gets # Esvazia o buffer
    call gets # Lê o nome de consulta
    addl $4, %esp # Desempilha o endereço da variável para leitura do nome

    movl list_header, %ebx # Move a cabeça da lista para %ebx
    movl $NULL, %ecx # %ecx = registro anterior (NULL no início)

    loop_remove:
        cmpl $NULL, %ebx # Compara %ebx com $NULL (Verifica se está no fim)
        je nao_encontrado

        pushl %ecx
        pushl %ebx # Empilha o registro atual (nome é primeiro campo do registro)
        pushl $nome_inserido # Empilha o nome de consulta
        call strcmp # Chama a função de comparação de strings
        addl $4, %esp
        popl %ebx
        popl %ecx
        cmpl $0, %eax # Compara o resultado de strcmp com 0
        je remove # Desvia o fluxo para procedimento de remoção se a comparação der igual

        movl %ebx, %ecx # Avança %ecx (que agora é o atual)
        movl 265(%ebx), %ebx # Coloca o conteúdo do campo próx em %ebx
        jmp loop_remove # Retorna ao começo do loop

    remove:
        cmpl $NULL, %ecx 
        je remove_primeiro # Se o registro anterior for nulo, desvia para função de remover_primeiro

        movl 265(%ebx), %edx # Move o atual.prox para %edx
        movl %edx, 265(%ecx) # anterior.prox = atual.prox
        jmp desaloca # Desvia o fluxo para a desalocação do registro

    # Procedimento para remover o primeiro da lista
    remove_primeiro:
        movl 265(%ebx), %edx # Move o endereço contido em atual.prox para %edx
        movl %edx, list_header # Redireciona a cabeça da lista para o endereço contido em %edx (atual.prox)
        jmp desaloca # Desvia o fluxo para a desalocação do registro

    # Procedimento para desalocar um registro que deve estar em %ebx
    desaloca: 
        pushl %ebx # Empilha o endereço do atual
        call free # Destrói o registro atual
        addl $4, %esp # Remove %ebx da pilha
        
        pushl $nome_inserido
        pushl $mens_remocao_concluida
        call printf # Imprime a mensagem de remoção concluída
        addl $8, %esp # Remove as strings da pilha

    ret

consultar_funcionario:
    pushl $mens_consult
    call printf # Escreve na tela a mensagem de abertura da função
    pushl $pede_nome_consult 
    call printf # Escreve na tela a mensagem de pedido do nome para consulta
    addl $8, %esp # Remove as strings de mensagem da pilha

    pushl $nome_inserido # Empilha o endereço da variável para leitura do nome
    call gets # Esvazia o buffer
    call gets # Lê o nome de consulta
    addl $4, %esp # Desempilha o endereço da variável para leitura do nome

    movl $list_header, %edi # Move o endereço da cabeça da lista para %edi
    movl $NULL, %ebx # Move o endereço de NULL para %ebx
    
    # %edi = Endereço do registro atual
    loop_consulta:
        cmpl (%edi), %ebx # Compara o conteúdo de %edi com $NULL
        je nao_encontrado # Se (%edi) == $NULL, fim de lista, nome não encontrado

        pushl (%edi) # Empilha o registro atual (nome é primeiro campo do registro)
        pushl $nome_inserido # Empilha o nome de consulta
        call strcmp # Chama a função de comparação de strings
        addl $8, %esp
        pushl $encerra_consulta # Empilha o endereço de retorno do procedimento call_mostra_registro
        cmpl $0, %eax # Compara o resultado de strcmp com 0
        je call_mostra_registro # Se forem iguais, desvia para call_mostra_registro

        addl $4, %esp # Remove o endereço de retorno ($encerra_consulta) caso a busca deva continuar
        movl (%edi), %edi # Move o conteúdo de %edi (o registro, de fato) para %edi
        addl $265, %edi # Avança ao campo próx (o endereço de prox)
        jmp loop_consulta # Retorna ao começo do loop

    encerra_consulta: ret

relatorio_regs:
    pushl $mens_relat
    call printf # Escreve na tela a mensagem de abertura da função
    addl $4, %esp # Remove a string de abertura da pilha

    movl $list_header, %edi # Move o endereço da cabeça da lista para o registrador %edi
    movl $NULL, %ebx # Move o endereço da constante NULL para %ebx

    cmpl (%edi), %ebx # Caso o conteúdo de %edi (cabeça da lista) seja igual NULL, não há registros
    je nao_ha_registros # Desvia o fluxo para a função auxiliar

    loop_relat:
        pushl $loop_relat # Empilha o endereço de retorno a ser utilizado por call_mostra_registro
        cmpl (%edi), %ebx # Compara o conteúdo de %edi e o endereço de NULL
        jne call_mostra_registro # Se a comparação não for igual, há um registro em %edi, então mostre-o
                                 # Se a comparação for igual, chegamos ao final da lista
        
        addl $4, %esp # Remove o pushl $loop_relat que sobrou

        ret # Sai da função

# Procedimento padrão para fechar o programa
# Imprime uma mensagem de saída na tela e encerra com sucesso
sair:
    pushl $mens_sair
    call printf
    addl $4, %esp
    pushl $0
    call exit

_start:
    movl $NULL, list_header # Inicializa a lista com o endereço de NULL
    
    pushl $mens_abertura
    call printf # Imprime a mensagem de abertura do sistema
    addl $4, %esp # Remove a string de abertura da lista

    menu_loop:
        call menu # Faz a chamada do procedimento do menu, escolha do usuário em %eax

        # Case 1
        movl func_inserir, %ebx 
        cmpl %eax, %ebx
        je call_inserir

        # Case 2
        movl func_remover, %ebx 
        cmpl %eax, %ebx
        je call_remover

        # Case 3
        movl func_consultar, %ebx 
        cmpl %eax, %ebx
        je call_consultar

        # Case 4
        movl func_relatorio, %ebx 
        cmpl %eax, %ebx
        je call_relatorio

        # Case 0
        movl func_sair, %ebx
        cmpl %eax, %ebx
        je sair

        # Case Default
        pushl $mens_invalido
        call printf
        addl $4, %esp
        jmp menu_loop
    
######################### Procedimentos de transição #########################
# Estes procedimentos são usados no menu para a chamada das respectivas funções

call_inserir:
    call inserir_funcionario # Chama a função principal de inserção
    
    pushl $conclui_insercao
    call printf # Imprime a mensagem de conclusão de inserção
    addl $4, %esp # Remove a mensagem da pilha
    
    jmp menu_loop # Retorna ao menu

call_remover:
    call remover_funcionario # Chama a função de principal de remoção
    
    jmp menu_loop # Retorna ao menu

call_consultar:
    call consultar_funcionario # Chama a função princial de consulta
    
    jmp menu_loop # Retorna ao menu

call_relatorio:
    call relatorio_regs # Chama a função principal de relatório

    jmp menu_loop # Retorna ao menu

# Função para chamar o procedimento mostra_registro
# A função que usou jump para cá deve ter empilhado o endereço de retorno
call_mostra_registro:
    call mostra_registro
    
    ret

######################### Procedimentos de auxiliares #########################
# Estes procedimentos são usados por outros procedimentos/funções para realizarem suas tarefas

# Imprime uma mensagem caso o nome não seja encontrado na lista, encerrando a função
nao_encontrado: 
    pushl $mens_nao_encontrado
    call printf
    addl $4, %esp

    ret

# Imprime uma mensagem de que a lista está vazia, saindo da função
# Usado pela função de relatório para uma melhor interação com o usuário
nao_ha_registros:
    pushl $mens_lista_vazia
    call printf
    addl $4, %esp

    ret

# Aloca um registro de tam_reg tamanho e o retorna em %eax
# Esta função altera o registrador %eax
aloca_reg:
    pushl tam_reg
    call malloc
    addl $4, %esp
    
    ret

# Aloca um registro quando a lista está vazia
# Esta função altera os registradores %edi, %eax e %ebx
aloca_primeiro:
    call aloca_reg
    movl $NULL, %ebx
    movl %ebx, 265(%eax)
    movl %eax, list_header

    jmp le_registro

# Aloca um registro quando a lista não está vazia, orientando os ponteiros
# Esta função altera os registradores %eax e %ebx
aloca_ordenado:
    # %ebx = atual
    # %ecx = anterior
    movl list_header, %ebx # Move o conteúdo de lista_header para %ebx
    movl $NULL, %ecx # Move o endereço de NULL para %ecx (antes do primeiro não há nada)

    loop_aloca_ordenado:
        cmpl $NULL, %ebx # Caso %ebx seja nulo, chegamos ao final da lista, apenas insira o novo registro
        je inserir # Desvia o fluxo para o procedimento de inserção padrão

        pushl %ecx # Salva %ebx na pilha (backup)
        pushl %ebx # Empilha %ebx para comparação (strcmp vai até o \0, portanto não há problemas)
        pushl $nome_inserido # Empilha o nome_inserido para comparação
        call strcmp # Compara o nome inserido para o novo registro com o nome no registro atual (resultado em %eax)
        addl $4, %esp # Remove nome_inserido da pilha
        popl %ebx # Remove %ebx da pilha, movendo-o para %ebx novamente 
        popl %ecx # Remove %ecx da pilha, movendo-o para %ecx novamente
        cmpl $0, %eax # Compara 0 ao resultado de strcmp
        jle inserir # Caso o novo_nome seja alfabeticamente menor ou igual que o do registro atual,
                    # insere na frente de %ecx, ou seja, na frente do anterior e atrás do atual

        # Caso contrário, avance na lista
        movl %ebx, %ecx # Auxiliar de anterior recebe o endereço de atual
        movl 265(%ebx), %ebx # Auxiliar de atual recebe o endereço do próx armazenado no registro
        jmp loop_aloca_ordenado # Retorna ao início do loop

    # Procedimento de inserção de aloca_ordenado
    inserir: 
        pushl %ecx # Backup do ponteiro auxiliar %ecx
        pushl %ebx # Backup do ponteiro auxiliar %ebx
        call aloca_reg # Chama a função de alocação do registro, resultado em %eax
        popl %ebx # Recupera o backup do registrador 
        popl %ecx # Recupera o backup do registrador 

        cmpl $NULL, %ecx # Compara o anterior com $NULL
        je insere_primeiro # Caso sejam iguais, deve haver uma inserção no início da lista
                           # Caso contrário, adequa os ponteiros da lista

        # Adequação dos ponteiros 
        movl %ebx, 265(%eax) # novo.prox = atual
        movl %eax, 265(%ecx) # anterior.prox = novo

        jmp le_registro # Procede para a leitura dos demais campos do registro

        # Adequação dos ponteiros no caso de inserção no início
        insere_primeiro:
            movl %ebx, 265(%eax) # novo.prox = atual
            movl %eax, list_header # cabeça da lista = novo

            jmp le_registro # Procede para a leitura dos demais campos do registro

# Procedimento para mostrar um registro inteiro
# Requer que o endereço do registro a ser mostrado esteja em %edi
mostra_registro:
    movl (%edi), %edi

    pushl %edi
    pushl $mostra_nome
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    pushl %edi
    pushl $mostra_rua
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    pushl (%edi)
    pushl $mostra_numero
    call printf
    addl $4, %edi
    addl $8, %esp

    pushl %edi
    pushl $mostra_bairro
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    pushl %edi
    pushl $mostra_cep
    call printf
    addl $4, %esp
    popl %edi
    addl $9, %edi

    pushl %edi
    pushl $mostra_cidade
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    pushl %edi
    pushl $mostra_telefone
    call printf
    addl $4, %esp
    popl %edi
    addl $10, %edi

    pushl %edi
    pushl $mostra_email
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    pushl %edi
    pushl $mostra_data_nasc
    call printf
    addl $4, %esp
    popl %edi
    addl $11, %edi

    pushl (%edi)
    pushl $mostra_genero
    call printf
    addl $4, %edi
    addl $8, %esp

    pushl %edi
    pushl $mostra_cpf
    call printf
    addl $4, %esp
    popl %edi
    addl $12, %edi

    pushl %edi
    pushl $mostra_rg
    call printf
    addl $4, %esp
    popl %edi
    addl $10, %edi

    pushl %edi
    pushl $mostra_data_contr
    call printf
    addl $4, %esp
    popl %edi
    addl $11, %edi

    pushl %edi
    pushl $mostra_cargo
    call printf
    addl $4, %esp
    popl %edi
    addl $31, %edi

    fldl (%edi) # Carrega o conteúdo de %edi na PFU
    subl $8, %esp # Abre espaço para o double na pilha do sistema
    fstpl (%esp) # Carrega o double para a pilha do sistema
    pushl $mostra_salario
    call printf
    addl $12, %esp
    
    addl $8, %edi # Deixa %edi apontando para prox

    pushl $divisor_reg
    call printf # Imprime um divisor de registros após mostrá-lo
    addl $4, %esp # Remove a string de divisão da pilha

    ret # Retorna ao chamante

# Procedimento para ler um registro completo
# Utiliza fgets para leitura de strings e scanf para leitura de inteiros e caracteres
le_registro:
    movl %eax, %edi # Faz %edi apontar para o novo registro
    
    pushl $nome_inserido # Insere o nome já lido na pilha
    pushl %edi # Insere o endereço de destino do nome
    call strcpy # Copia a string de nome lida para o novo registro
    popl %edi # Recupera o novo registro da pilha
    addl $4, %esp # Remove $nome_inserido da pilha
    
    addl $31, %edi # Avança ao próximo campo

    pushl $pede_rua
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi # Avança ao próximo campo

    pushl $pede_numero
    call printf
    addl $4, %esp
    pushl %edi
    pushl $int_fmt
    call scanf
    addl $4, %esp
    popl %edi

    addl $4, %edi # Avança ao próximo campo    

    pushl $pede_bairro
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    call gets
    popl %edi

    addl $31, %edi # Avança ao próximo campo

    pushl $pede_cep
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $9, %edi # Avança ao próximo campo

    pushl $pede_cidade
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi # Avança ao próximo campo

    pushl $pede_telefone
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $10, %edi # Avança ao próximo campo

    pushl $pede_email
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi # Avança ao próximo campo

    pushl $pede_data_nasc
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $11, %edi # Avança ao próximo campo

    pushl $pede_genero
    call printf
    addl $4, %esp
    pushl %edi
    pushl $char_fmt
    call scanf
    addl $4, %esp
    popl %edi

    addl $4, %edi # Avança ao próximo campo

    pushl $pede_cpf
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    call gets
    popl %edi

    addl $12, %edi # Avança ao próximo campo

    pushl $pede_rg
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $10, %edi # Avança ao próximo campo

    pushl $pede_data_contr
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $11, %edi # Avança ao próximo campo

    pushl $pede_cargo
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi # Avança ao próximo campo

    pushl $pede_salario
    call printf
    addl $4, %esp
    pushl %edi
    pushl $double_fmt
    call scanf
    addl $4, %esp
    popl %edi

    ret
