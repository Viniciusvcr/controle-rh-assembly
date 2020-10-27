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
#   salario   : int (4 bytes)
#   prox      : int (4 bytes)
#
# Total de bytes: 265 bytes

.section .data
    // TODO Arrumar tabs
    mens_abertura: .asciz "Bem vindo ao controle de RH\n\n"
    mens_sair:     .asciz "Saindo do programa... Obrigado por utilizar!\n"
    mens_inserir:  .asciz "Inserir funcionário:\n\n"
    mens_remover:  .asciz "Remover funcionário:\n\n"
    mens_consult:  .asciz "Consulta de funcionário:\n\n"
    mens_relat:    .asciz "Relatório de funcionários:\n\n"
    mens_invalido: .asciz "Opção inválida!\n\n"
    mens_nao_encontrado: .asciz "\n\nNome não encontrado na lista!\n\n"
    mens_remocao_concluida: .asciz "\n\nRemoção do(a) funcionário(a) %s concluída com sucesso!\n\n"
    mens_lista_vazia: .asciz "Não há funcionários cadastrados no sistema!\n\n"
    str_menu:      .asciz "Escolha uma opção do programa:\n\t1 - Inserir funcionário\n\t2 - Remover funcionário\n\t3 - Consultar funcionário\n\t4 - Relatório de registros\n\t0 - Sair do programa\n> "
    resp_menu:     .int 0

    pede_nome:       .asciz "Insira o NOME do funcionário: "
    pede_rua:        .asciz "Insira a RUA do funcionário: "
    pede_numero:     .asciz "Insira o NÚMERO da casa do funcionário: "
    pede_bairro:     .asciz "Insira o BAIRRO do funcionário: "
    pede_cep:        .asciz "Insira o CEP do funcionário: "
    pede_cidade:     .asciz "Insira a CIDADE do funcionário: "
    pede_telefone:   .asciz "Insira o TELEFONE do funcionário: "
    pede_email:      .asciz "Insira o EMAIL do funcionário: "
    pede_data_nasc:  .asciz "Insira a DATA DE NASCIMENTO do funcionário: "
    pede_genero:     .asciz "Insira o gênero do funcionário (<M>asculino, <F>eminino): "
    pede_cpf:        .asciz "Insira o CPF do funcionário: "
    pede_rg:         .asciz "Insira o RG do funcionário: "
    pede_data_contr: .asciz "Insira a DATA DE CONTRATO do funcionário: "
    pede_cargo:      .asciz "Insira o CARGO do funcionário: "
    pede_salario:    .asciz "Insira o SALÁRIO do funcionário: "

    pede_nome_remover: .asciz "Insira o NOME do funcionário que deseja REMOVER: "
    pede_nome_consult: .asciz "Insira o NOME do funcionário que deseja CONSULTAR: "

    mostra_nome:       .asciz "FUNCIONÁRIO %s: \n"
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
    mostra_salario:    .asciz "\tSALARIO      : %d\n"

    conclui_insercao: .asciz "\nNovo funcionário cadastrado com sucesso!\n\n"
    fim_reg:        .asciz "=================================================================\n\n"

    func_inserir:   .int 1
    func_remover:   .int 2
    func_consultar: .int 3
    func_relatorio: .int 4
    func_sair:      .int 0

    scan_int: .asciz "%d"
    scan_char: .asciz "%c"
    str_fmt: .asciz "%s\n"
    address_form: .asciz "%X\n"
    quebra_linha: .asciz "\n"

    NULL: .int 0

    list_header: .int 0
    tam_reg:     .int 265
    reg_prox:    .int 261

    nome_inserido: .int 0

    reg_atual: .int 0
    prox_atual: .int 0
    reg_novo: .int 0
    prox_novo: .int 0
    anterior: .int 0


.section .text

.globl _start

# Função para mostrar o menu e esperar a escolha do usuário
# Esta função altera o estado do registrador %eax
menu:
    pushl $str_menu
    call printf
    addl $4, %esp # Remove str_menu da pilha

    pushl $resp_menu
    pushl $scan_int
    call scanf
    movl resp_menu, %eax # move a resposta do menu de escolhas para %eax
    addl $8, %esp # Remove resp_menu e scan_int da pilha
    
    ret

######################### Funções primárias #########################
# Estas são as funções principais do Controle de RH

# Função para inserir um funcionário no registro
# Altera os mesmos registradores que printf/scanf/fgets
inserir_funcionario:
    pushl $mens_inserir
    call printf
    addl $4, %esp

    pushl $pede_nome
    call printf
    addl $4, %esp
    pushl $nome_inserido
    call gets
    call gets
    addl $4, %esp

    movl $NULL, %eax;
    cmpl %eax, list_header # Verifica se a lista é vazia
    je aloca_primeiro # se a lista for vazia, aloca o primeiro
    jne aloca_ordenado # se a lista não for vazia, aloca e faz as operações de inserção no início

    # aloca_primeiro e aloca_final pulam para o procedimento auxiliar "insere" que contém o ret

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
        movl 261(%ebx), %ebx # Coloca o conteúdo do campo próx em %ebx
        jmp loop_remove # Retorna ao começo do loop

    remove:
        cmpl $NULL, %ecx 
        je remove_primeiro # Se o registro anterior for nulo, desvia para função de remover_primeiro

        movl 261(%ebx), %edx # Move o atual.prox para %edx
        movl %edx, 261(%ecx) # anterior.prox = atual.prox
        jmp desaloca

    remove_primeiro:
        movl 261(%ebx), %edx
        movl %edx, list_header # Redireciona a cabeça da lista para o próx do atual
        jmp desaloca

    desaloca: 
        pushl %ebx # Empilha o endereço do atual
        call free # Destrói o registro atual
        addl $4, %esp
        
        pushl $nome_inserido
        pushl $mens_remocao_concluida
        call printf
        addl $8, %esp

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
        addl $261, %edi # Avança ao campo próx (o endereço de prox)
        jmp loop_consulta # Retorna ao começo do loop

    // TODO Separar função pois é usada em dois procedimentos diferentes
    nao_encontrado: # Imprime uma mensagem caso o nome não seja encontrado na lista
        pushl $mens_nao_encontrado
        call printf
        addl $4, %esp

    encerra_consulta: ret

relatorio_regs:
    pushl $mens_relat
    call printf
    addl $4, %esp

    movl $list_header, %edi # move a cabeça da lista para o registrador %edi
    movl $NULL, %ebx

    cmpl (%edi), %ebx
    je nao_ha_registros

    loop_relat:
        pushl $loop_relat # Empilha o endereço de retorno a ser utilizado por call_mostra_registro
        cmpl (%edi), %ebx
        jne call_mostra_registro

        addl $4, %esp # Remove o pushl $loop_relat que sobrou

        ret

    nao_ha_registros:
        pushl $mens_lista_vazia
        call printf
        addl $4, %esp

        ret

sair:
    pushl $mens_sair
    call printf
    addl $4, %esp
    pushl $0
    call exit

_start:
    movl $NULL, list_header
    pushl $mens_abertura
    call printf
    addl $4, %esp

menu_loop:
    call menu

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
    call inserir_funcionario
    pushl $conclui_insercao
    call printf
    addl $4, %esp
    
    jmp menu_loop

call_remover:
    call remover_funcionario
    jmp menu_loop

call_consultar:
    call consultar_funcionario
    jmp menu_loop

call_relatorio:
    call relatorio_regs

    jmp menu_loop

# Função para chamar o procedimento mostra_registro
# A função que usou jump para cá deve ter empilhado o endereço de retorno
call_mostra_registro:
    call mostra_registro
    
    ret

######################### Procedimentos de auxiliares #########################
# Estes procedimentos são usados por outros procedimentos/funções para realizarem suas tarefas

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
    movl %ebx, 261(%eax)
    movl %eax, list_header

    jmp le_registro

# Aloca um registro quando a lista não está vazia, orientando os ponteiros
# Esta função altera os registradores %eax e %ebx
aloca_ordenado:
    # %ebx = atual
    # %ecx = anterior
    movl list_header, %ebx
    movl $NULL, %ecx

    loop_aloca_ordenado:
        cmpl $NULL, %ebx
        je inserir

        pushl %ecx
        pushl %ebx
        pushl $nome_inserido
        call strcmp
        addl $4, %esp
        popl %ebx
        popl %ecx
        cmpl $0, %eax
        jle inserir

        movl %ebx, %ecx
        movl 261(%ebx), %ebx
        jmp loop_aloca_ordenado    

    inserir:
        pushl %ecx
        pushl %ebx
        call aloca_reg
        popl %ebx
        popl %ecx

        cmpl $NULL, %ecx
        je insere_primeiro

        insere:
            movl %ebx, 261(%eax)
            movl %eax, 261(%ecx)

            jmp le_registro

        insere_primeiro:
            movl %ebx, 261(%eax) # novo.prox = atual
            movl %eax, list_header # head = novo

            jmp le_registro

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

    pushl (%edi)
    pushl $mostra_salario
    call printf
    addl $8, %esp
    
    addl $4, %edi # Deixa %edi apontando para prox

    pushl $fim_reg
    call printf
    addl $4, %esp

    ret

# Procedimento para ler um registro completo
le_registro:
    movl %eax, %edi # Faz %edi apontar para o novo registro
    
    pushl $nome_inserido
    pushl %edi
    call strcpy
    popl %edi
    addl $4, %esp

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
    pushl $scan_int
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

    addl $31, %edi

    pushl $pede_cep
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $9, %edi

    pushl $pede_cidade
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi

    pushl $pede_telefone
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $10, %edi

    pushl $pede_email
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi

    pushl $pede_data_nasc
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $11, %edi

    pushl $pede_genero
    call printf
    addl $4, %esp
    pushl %edi
    pushl $scan_char
    call scanf
    addl $4, %esp
    popl %edi

    addl $4, %edi

    pushl $pede_cpf
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    call gets
    popl %edi

    addl $12, %edi

    pushl $pede_rg
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $10, %edi

    pushl $pede_data_contr
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $11, %edi

    pushl $pede_cargo
    call printf
    addl $4, %esp
    pushl %edi
    call gets
    popl %edi

    addl $31, %edi

    pushl $pede_salario
    call printf
    addl $4, %esp
    pushl %edi
    pushl $scan_int
    call scanf
    addl $4, %esp
    popl %edi

    ret
