CREATE TABLE AEROPORTO (
 Nome CHAR(10)
);


CREATE TABLE AVIÃO (
 Identificação CHAR(10),
 Modelo CHAR(10),
 Autonomia FLOAT(10),
 Capacidade INT,
 Tanque FLOAT(10)
);


CREATE TABLE CARGA (
 Peso FLOAT(10),
 Avião_id CHAR(10),
 ID_carga INT
);


CREATE TABLE EMPRESA_AEREA (
 Nome CHAR(10),
 Sigla CHAR(10),
 CNPJ INT
);


CREATE TABLE ENDEREÇO (
 Estado CHAR(10),
 Cidade CHAR(10),
 Rua CHAR(10),
 Bairro CHAR(10),
 Número INT,
 Complemento CHAR(10),
 CEP CHAR(8)
);


CREATE TABLE PESSOA (
 Cpf CHAR(11),
 Nome VARCHAR(),
 Idade INT,
 RG INT,
 Sexo CHAR(10),
 Peso FLOAT(10),
 Telefone INT
);


CREATE TABLE PROFISSIONAL_DE_BORDO (
 ID_profissional INT,
 Categoria CHAR(10)
);


CREATE TABLE TERMINAL (
 Portão INT,
 Capacidade_voos INT
);


CREATE TABLE VOO (
 ID_voo CHAR(10),
 Origem CHAR(10),
 Destino CHAR(10),
 Escala CHAR(10)
);


CREATE TABLE FUNCIONÁRIO (
 ID_funcionario INT
);


CREATE TABLE PASSAGEIRO (
 Visto BIT(10),
 Nro_Passaporte CHAR(10)
);


CREATE TABLE PASSAGEM_AÉREA (
 ID_passagem INT,
 Origem CHAR(10),
 Destino CHAR(10),
 Terminal INT,
 Cia_aerea CHAR(10),
 Assento CHAR(10),
 Classe CHAR(10)
);


CREATE TABLE TRIPULAÇÃO (
 ID_profissional INT,
 ID_voo INT,
 Local_embarque CHAR(10),
 Local_desembarque CHAR(10)
);


CREATE TABLE VÍNCULO (
 ID_Contrato INT,
 Categoria CHAR(10),
 Salario FLOAT(10),
 Turno CHAR(10)
);


CREATE TABLE BAGAGEM (
 Dono_cpf CHAR(11),
 Bagagem_id INT,
 Peso FLOAT(10)
);


CREATE TABLE CHECK-IN (
 Passagem CHAR(10),
 Aprovado BIT(10),
 Visto_válido BIT(10)
);
