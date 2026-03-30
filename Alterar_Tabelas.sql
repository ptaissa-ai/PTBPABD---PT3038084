-- =========================================
-- QUESTÃO 01
-- Criar a tabela pessoa com os campos:
-- ID, nome, sobrenome e idade
-- Adicionar CHECK para impedir idade menor que 0
-- =========================================

CREATE TABLE pessoa (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    idade INT CHECK (idade >= 0)
);


-- =========================================
-- QUESTÃO 02
-- Alterar a tabela pessoa e criar uma restrição
-- UNIQUE para os campos ID, nome e sobrenome
-- =========================================

ALTER TABLE pessoa
ADD CONSTRAINT uq_pessoa_id_nome_sobrenome
UNIQUE (id, nome, sobrenome);


-- =========================================
-- QUESTÃO 03
-- Alterar a coluna idade da tabela pessoa
-- para que ela não aceite valores nulos
-- =========================================

ALTER TABLE pessoa
ALTER COLUMN idade INT NOT NULL;


-- =========================================
-- QUESTÃO 04
-- Criar a tabela endereco com os campos ID e rua
-- Adicionar o campo endereco na tabela pessoa
-- Criar integridade referencial entre pessoa e endereco
-- =========================================

CREATE TABLE endereco (
    id INT PRIMARY KEY,
    rua VARCHAR(100)
);

ALTER TABLE pessoa
ADD endereco INT;

ALTER TABLE pessoa
ADD CONSTRAINT fk_pessoa_endereco
FOREIGN KEY (endereco)
REFERENCES endereco(id);