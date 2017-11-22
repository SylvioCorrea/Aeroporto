CREATE TABLE AEROPORTO (
 Nome VARCHAR(255) NOT NULL
);

ALTER TABLE AEROPORTO ADD CONSTRAINT PK_AEROPORTO PRIMARY KEY (Nome);


CREATE TABLE AVIÃO (
 Identificação CHAR(8) NOT NULL,
 Modelo VARCHAR(255),
 Autonomia FLOAT,
 Capacidade INT,
 Tanque FLOAT
);

ALTER TABLE AVIÃO ADD CONSTRAINT PK_AVIÃO PRIMARY KEY (Identificação);


CREATE TABLE CARGA (
 ID_carga CHAR(8) NOT NULL,
 Peso FLOAT,
 Avião_id CHAR(8)
);

ALTER TABLE CARGA ADD CONSTRAINT PK_CARGA PRIMARY KEY (ID_carga);


CREATE TABLE EMPRESA_AEREA (
 CNPJ INT NOT NULL,
 Nome VARCHAR(255),
 Sigla CHAR(3)
);

ALTER TABLE EMPRESA_AEREA ADD CONSTRAINT PK_EMPRESA_AEREA PRIMARY KEY (CNPJ);


CREATE TABLE ENDEREÇO (
 Nome VARCHAR(255) NOT NULL,
 Cpf CHAR(11) NOT NULL,
 Estado CHAR(2),
 Cidade VARCHAR(255),
 Rua VARCHAR(255),
 Bairro VARCHAR(255),
 Número INT,
 Complemento CHAR(10),
 CEP CHAR(8)
);

ALTER TABLE ENDEREÇO ADD CONSTRAINT PK_ENDEREÇO PRIMARY KEY (Nome,Cpf);


CREATE TABLE PESSOA (
 Cpf CHAR(11) NOT NULL,
 Nome VARCHAR(255),
 Idade INT,
 RG CHAR(9),
 Sexo CHAR(1),
 Peso FLOAT,
 Telefone CHAR(13)
);

ALTER TABLE PESSOA ADD CONSTRAINT PK_PESSOA PRIMARY KEY (Cpf);


CREATE TABLE PROFISSIONAL_DE_BORDO (
 ID_profissional CHAR(8) NOT NULL,
 Cpf CHAR(11) NOT NULL,
 Categoria CHAR(10)
);

ALTER TABLE PROFISSIONAL_DE_BORDO ADD CONSTRAINT PK_PROFISSIONAL_DE_BORDO PRIMARY KEY (ID_profissional,Cpf);


CREATE TABLE TERMINAL (
 Portão INT NOT NULL,
 Nome VARCHAR(255) NOT NULL,
 Capacidade_voos INT
);

ALTER TABLE TERMINAL ADD CONSTRAINT PK_TERMINAL PRIMARY KEY (Portão,Nome);


CREATE TABLE VOO (
 ID_voo CHAR(8) NOT NULL,
 Origem VARCHAR(255),
 Destino VARCHAR(255),
 Escala VARCHAR(255)
);

ALTER TABLE VOO ADD CONSTRAINT PK_VOO PRIMARY KEY (ID_voo);


CREATE TABLE FUNCIONÁRIO (
 ID_funcionario INT NOT NULL,
 Cpf CHAR(11) NOT NULL
);

ALTER TABLE FUNCIONÁRIO ADD CONSTRAINT PK_FUNCIONÁRIO PRIMARY KEY (ID_funcionario,Cpf);


CREATE TABLE PASSAGEIRO (
 Cpf CHAR(11) NOT NULL,
 Visto CHAR(10),
 Nro_Passaporte CHAR(10) NOT NULL
);

ALTER TABLE PASSAGEIRO ADD CONSTRAINT PK_PASSAGEIRO PRIMARY KEY (Cpf);


CREATE TABLE PASSAGEM_AÉREA (
 ID_passagem INT NOT NULL,
 ID_voo CHAR(8) NOT NULL,
 Cpf CHAR(11) NOT NULL,
 Origem CHAR(10),
 Destino CHAR(10),
 Terminal INT,
 Cia_aerea CHAR(10),
 Assento CHAR(10),
 Classe CHAR(10)
);

ALTER TABLE PASSAGEM_AÉREA ADD CONSTRAINT PK_PASSAGEM_AÉREA PRIMARY KEY (ID_passagem,ID_voo,Cpf);


CREATE TABLE TRIPULAÇÃO (
 ID_voo_0 CHAR(8) NOT NULL,
 Cpf CHAR(11) NOT NULL,
 ID_profissional_0 CHAR(8) NOT NULL,
 ID_voo INT,
 Local_embarque VARCHAR(255),
 Local_desembarque VARCHAR(255)
);

ALTER TABLE TRIPULAÇÃO ADD CONSTRAINT PK_TRIPULAÇÃO PRIMARY KEY (ID_voo_0,Cpf,ID_profissional_0);


CREATE TABLE VÍNCULO (
 Nome VARCHAR(255) NOT NULL,
 Cpf CHAR(11) NOT NULL,
 ID_funcionario INT NOT NULL,
 ID_Contrato INT,
 Categoria CHAR(10),
 Salario FLOAT,
 Turno CHAR(10)
);

ALTER TABLE VÍNCULO ADD CONSTRAINT PK_VÍNCULO PRIMARY KEY (Nome,Cpf,ID_funcionario);


CREATE TABLE BAGAGEM (
 Bagagem_id INT NOT NULL,
 Cpf CHAR(11) NOT NULL,
 ID_carga CHAR(8) NOT NULL,
 Peso FLOAT
);

ALTER TABLE BAGAGEM ADD CONSTRAINT PK_BAGAGEM PRIMARY KEY (Bagagem_id,Cpf,ID_carga);


ALTER TABLE ENDEREÇO ADD CONSTRAINT FK_ENDEREÇO_0 FOREIGN KEY (Nome) REFERENCES AEROPORTO (Nome);
ALTER TABLE ENDEREÇO ADD CONSTRAINT FK_ENDEREÇO_1 FOREIGN KEY (Cpf) REFERENCES PESSOA (Cpf);


ALTER TABLE PROFISSIONAL_DE_BORDO ADD CONSTRAINT FK_PROFISSIONAL_DE_BORDO_0 FOREIGN KEY (Cpf) REFERENCES PESSOA (Cpf);


ALTER TABLE TERMINAL ADD CONSTRAINT FK_TERMINAL_0 FOREIGN KEY (Nome) REFERENCES AEROPORTO (Nome);


ALTER TABLE FUNCIONÁRIO ADD CONSTRAINT FK_FUNCIONÁRIO_0 FOREIGN KEY (Cpf) REFERENCES PESSOA (Cpf);


ALTER TABLE PASSAGEIRO ADD CONSTRAINT FK_PASSAGEIRO_0 FOREIGN KEY (Cpf) REFERENCES PESSOA (Cpf);


ALTER TABLE PASSAGEM_AÉREA ADD CONSTRAINT FK_PASSAGEM_AÉREA_0 FOREIGN KEY (ID_voo) REFERENCES VOO (ID_voo);
ALTER TABLE PASSAGEM_AÉREA ADD CONSTRAINT FK_PASSAGEM_AÉREA_1 FOREIGN KEY (Cpf) REFERENCES PASSAGEIRO (Cpf);


ALTER TABLE TRIPULAÇÃO ADD CONSTRAINT FK_TRIPULAÇÃO_0 FOREIGN KEY (ID_voo_0) REFERENCES VOO (ID_voo);
ALTER TABLE TRIPULAÇÃO ADD CONSTRAINT FK_TRIPULAÇÃO_1 FOREIGN KEY (Cpf,ID_profissional_0) REFERENCES PROFISSIONAL_DE_BORDO (Cpf,ID_profissional);


ALTER TABLE VÍNCULO ADD CONSTRAINT FK_VÍNCULO_0 FOREIGN KEY (Nome) REFERENCES AEROPORTO (Nome);
ALTER TABLE VÍNCULO ADD CONSTRAINT FK_VÍNCULO_1 FOREIGN KEY (Cpf,ID_funcionario) REFERENCES FUNCIONÁRIO (Cpf,ID_funcionario);


ALTER TABLE BAGAGEM ADD CONSTRAINT FK_BAGAGEM_0 FOREIGN KEY (Cpf) REFERENCES PASSAGEIRO (Cpf);
ALTER TABLE BAGAGEM ADD CONSTRAINT FK_BAGAGEM_1 FOREIGN KEY (ID_carga) REFERENCES CARGA (ID_carga);






-- CHECK CONSTRAINTS

ALTER TABLE FUNCIONARIO ADD CONSTRAINT maioridade CHECK (PESSOA.Idade > 14);

ALTER TABLE VOO ADD CONSTRAINT capacidade CHECK (AVIAO.Capacidade >= (SELECT COUNT(ID_passagem) FROM PASSAGEM_AEREA WHERE ID_voo = VOO.ID_voo));

ALTER TABLE VOO ADD CONSTRAINT origem CHECK (Origem <> Destino);




-- CREATE UPDATE TRIGGER
CREATE OR REPLACE TRIGGER atu_peso_carga
AFTER INSERT OR DELETE ON BAGAGEM
FOR EACH ROW
DECLARE
  peso_bag FLOAT;
BEGIN
  IF INSERTING THEN
    peso_bag := :new.Peso;
    UPDATE CARGA SET Peso = Peso + peso_bag;
  END IF;
  IF DELETING THEN
    peso_bag := :old.Peso;
    UPDATE CARGA SET Peso = Peso - peso_bag;
  END IF;
END atu_peso_carga;

CREATE OR REPLACE TRIGGER ver_sexo
BEFORE UPDATE ON PESSOA
FOR EACH ROW
BEGIN
  IF :old.Sexo IN ('M') AND :new.Sexo IN ('F') THEN
    Raise_application_error(-20001,'Sexo invalido');
  END IF;
  IF :old.Sexo IN ('F') AND :new.Sexo IN ('M') THEN
    Raise_application_error(-20001,'Sexo invalido');
  END IF;
END ver_sexo;



















