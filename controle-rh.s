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
    str_menu:      .asciz "Escolha uma opção do programa:\n\n\t1 - Inserir funcionário\n\t2 - Remover funcionário\n\t3 - Consultar funcionário\n\t4 - Relatório de registros\n\t0 - Sair do programa\n> "
    resp_menu:     .int 0

    func_inserir:   .int 1
    func_remover:   .int 2
    func_consultar: .int 3
    func_relatorio: .int 4
    func_sair:      .int 0


    scan_int: .asciz "%d"


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
    addl $8, %esp # Remove resp_menu e scan_int da pilha
    movl resp_menu, %eax # move a resposta do menu de escolhas para %eax
    
    ret

inserir_funcionario:
    ret

remover_funcionario:
    ret

consultar_funcionario:
    ret

relatorio_regs:
    ret

sair:
    pushl $mens_sair
    call printf
    addl $4, %esp
    ret

_start:
    pushl $mens_abertura
    call printf
    addl $4, %esp

reiniciar:
    call menu

    movl func_inserir, %ebx 
    cmp %eax, %ebx
    je inserir_funcionario

    movl func_remover, %ebx 
    cmp %eax, %ebx
    je remover_funcionario

    movl func_consultar, %ebx 
    cmp %eax, %ebx
    je consultar_funcionario

    movl func_relatorio, %ebx 
    cmp %eax, %ebx
    je relatorio_regs

    movl func_sair, %ebx
    cmp %eax, %ebx
    je sair
    jmp reiniciar
