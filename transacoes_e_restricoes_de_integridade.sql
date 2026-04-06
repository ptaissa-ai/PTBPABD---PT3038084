-- cria o schema pedido na questão 1
CREATE SCHEMA avaliacaocontinua;
GO

-- cria a tabela company questão 2
CREATE TABLE avaliacaocontinua.company (
    company_name VARCHAR(50) NOT NULL PRIMARY KEY, -- nome da empresa, não pode ser nulo e é chave primária
    city VARCHAR(50) -- cidade da empresa
);
GO

-- cria a tabela employee questão 3
CREATE TABLE avaliacaocontinua.employee (
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, -- nome da pessoa, não pode ser nulo e é chave primária
    street VARCHAR(50), -- rua
    city VARCHAR(50) -- cidade
);
GO

-- cria a tabela manages questão 4
CREATE TABLE avaliacaocontinua.manages (
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, -- nome da pessoa, não pode ser nulo e é chave primária
    manager_name VARCHAR(50) -- nome do gerente
);
GO

-- cria a tabela works questão 5
CREATE TABLE avaliacaocontinua.works (
    person_name VARCHAR(50) NOT NULL PRIMARY KEY, -- nome da pessoa, não pode ser nulo e é chave primária
    company_name VARCHAR(50) NOT NULL, -- nome da empresa, não pode ser nulo
    salary DECIMAL(10,2) -- salário
);
GO

-- cria a chave estrangeira entre works.person_name e employee.person_name questão 6
ALTER TABLE avaliacaocontinua.works
ADD FOREIGN KEY (person_name)
REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

-- cria a chave estrangeira entre works.company_name e company.company_name questão 7
ALTER TABLE avaliacaocontinua.works
ADD FOREIGN KEY (company_name)
REFERENCES avaliacaocontinua.company(company_name)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

-- cria a chave estrangeira entre manages.person_name e employee.person_name questão 8
ALTER TABLE avaliacaocontinua.manages
ADD FOREIGN KEY (person_name)
REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO