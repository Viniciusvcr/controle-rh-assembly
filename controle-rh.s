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
    mens_abertura: .asciz "Bem vindo ao controle de RH\n\n"
    mens_sair:     .asciz "Saindo do programa... Obrigado por utilizar!\n"
    mens_inserir:  .asciz "Inserir funcionário:\n\n"
    mens_remover:  .asciz "Remover funcionário:\n\n"
    mens_consult:  .asciz "Consultar funcionário:\n\n"
    mens_relat:    .asciz "Relatório de funcionários:\n\n"
    mens_invalido: .asciz "Opção inválida!\n\n"
    str_menu:      .asciz "Escolha uma opção do programa:\n\t1 - Inserir funcionário\n\t2 - Remover funcionário\n\t3 - Consultar funcionário\n\t4 - Relatório de registros\n\t0 - Sair do programa\n> "
    resp_menu:     .int 0

    pede_nome:   .asciz "Insira o NOME do funcionário: "
    pede_rua:    .asciz "Insira a RUA do funcionário: "
    pede_numero: .asciz "Insira o NÚMERO da casa do funcionário: "
    pede_bairro: .asciz "Insira o BAIRRO do funcionário: "
    pede_cep:    .asciz "Insira o CEP do funcionário: "
    pede_cidade: .asciz "Insira a CIDADE do funcionário: "
    pede_telefone:.asciz "Insira o TELEFONE do funcionário: "
    pede_email: .asciz "Insira o EMAIL do funcionário: "
    pede_data_nasc: .asciz "Insira a DATA DE NASCIMENTO do funcionário: "
    pede_genero: .asciz "Insira o gênero do funcionário (<M>asculino, <F>eminino): "
    pede_cpf: .asciz "Insira o CPF do funcionário: "
    pede_rg: .asciz "Insirao RG do funcionário: "
    pede_data_contr: .asciz "Insira a DATA DE CONTRATO do funcionário: "
    pede_cargo: .asciz "Insira o CARGO do funcionário: "
    pede_salario: .asciz "Insira o SALÁRIO do funcionário: "

    conclui_insercao: .asciz "Novo funcionário cadastrado com sucesso!\n\n"

    func_inserir:   .int 1
    func_remover:   .int 2
    func_consultar: .int 3
    func_relatorio: .int 4
    func_sair:      .int 0

    scan_int: .asciz "%d"

    NULL: .int 0

    list_header: .int 0
    tam_reg:     .int 265
    reg_prox:    .int 261

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

aloca:
    pushl tam_reg
    call malloc
    addl $4, %esp
    
    ret

aloca_primeiro:
    call aloca
    movl %eax, list_header

    jmp inserir
    
aloca_outros:
    call aloca
    movl $list_header, %ebx
    movl 261(%eax), %ebx
    movl list_header, %eax

    jmp inserir

# Função para inserir um funcionário no registro
# Altera os mesmos registradores que printf/scanf/fgets
inserir_funcionario:
    pushl $mens_inserir
    call printf
    addl $4, %esp

    movl NULL, %eax;
    cmpl %eax, list_header # Verifica se a lista é vazia
    je aloca_primeiro
    jne aloca_outros
    
inserir:
    pushl $pede_nome
    call printf
    addl $4, %esp
    movl list_header, %edi # Faz %edi apontar para o novo registro
    pushl %edi
    call gets
    call gets
    popl %edi
    
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
    pushl $scan_int
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

    addl $12, %edi

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

    addl $4, %edi
    
    ret

call_inserir:
    call inserir_funcionario
    jmp menu_loop

remover_funcionario:
    pushl $mens_remover
    call printf
    addl $4, %esp
    ret

call_remover:
    call remover_funcionario
    jmp menu_loop

consultar_funcionario:
    pushl $mens_consult
    call printf
    addl $4, %esp
    ret

call_consultar:
    call consultar_funcionario
    jmp menu_loop

relatorio_regs:
    pushl $mens_relat
    call printf
    addl $4, %esp
    ret

call_relatorio:
    call relatorio_regs
    jmp menu_loop

sair:
    pushl $mens_sair
    call printf
    addl $4, %esp
    pushl $0
    call exit

_start:
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
    