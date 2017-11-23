-- combinar nome, bagagem, passagem
-- Precisa combinar mais uma tabela pra obedecer a especificação (4 tabelas).
-- Eu ia combinar com a coluna modelo da tabela aviao, mas percebi que
-- não tem nenhuma ligação de voos para aviao e DEVERIA ter.

select nome, bagagem_id, id_passagem
  from pessoa
  inner join bagagem
  on pessoa.cpf = bagagem.cpf
    inner join passagem_aerea
    on passagem_aerea.cpf = bagagem.cpf;
