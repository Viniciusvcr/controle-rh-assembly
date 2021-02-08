# controle-rh-assembly

Repositório utilizado para o primeiro trabalho prático da disciplina PIHS - UEM 2020

## Especificação do trabalho

- Implementar em linguagem Gnu Assembly para plataforma 32 bits, um programa de Controle de Cadastro de Recursos Humanos;
- As seguintes funcionalidades devem ser implementadas:
  - Inserção;
  - Remoção;
  - Consulta e;
  - Relatório de registros.
- Deve-se usar uma lista encadeada dinâmica (com malloc) para armazenar os registros dos funcionários ordenados por ordem crescente de nome;
- Para cada registro de funcionário deve-se ter as seguintes informações:
  - nome completo;
  - endereço
    - rua;
    - número;
    - bairro;
    - CEP;
    - cidade;
    - telefone;
    - Email;
  - data de nascimento;
  - gênero;
  - CPF;
  - RG;
  - data de contratação;
  - cargo e;
  - salário.
- A lista encadeada será manipulada somente em memoria, devendo os dados serem digitados a cada execução;
- A **inserção** de registros deve ser feita de forma ordenada;
- As **consultas de registros** devem ser feitas por nome;
- O **relatório** deve mostrar todos os registros cadastrados de forma ordenada;
- A **remoção** deve liberar o espaço de memória alocada.

## Compilação

Para compilar e linkar o programa, na pasta raiz do projeto, execute

```bash
$ make
```

## Execução

Para executar o programa, em um terminal, digite:

```bash
$ ./controle-rh.out
```

## Principais módulos desenvolvidos

O primeiro contato com o sistema é seu menu. Escolha entre

1. **Inserir funcionário**, para inserir um registro;
2. **Remover funcionário**, para remover um registro;
3. **Consultar funcionário**, para consultar um registro no banco de dados;
4. **Relatório de registros**, para visualizar todos os registros no banco de dados;
5. **Reajuste salarial**, para reajustar o salário de todos os registros com base em uma porcentagem;
6. **Leitura de dados**, para carregar uma lista previamente gerada por este programa;
7. **Gravação de dados**, para salvar os dados dos registros atuais.

A última opção (opção 0), finaliza a execução do programa.
