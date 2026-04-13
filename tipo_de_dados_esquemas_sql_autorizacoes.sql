/*
QUESTÃO 01
Criar as contas de usuário User_A, User_B, User_C, User_D e User_E
*/

CREATE USER User_A WITH PASSWORD = 'Senha@123';
CREATE USER User_B WITH PASSWORD = 'Senha@123';
CREATE USER User_C WITH PASSWORD = 'Senha@123';
CREATE USER User_D WITH PASSWORD = 'Senha@123';
CREATE USER User_E WITH PASSWORD = 'Senha@123';
GO


/*
QUESTÃO 02
O User_A poderá selecionar ou modificar qualquer relação, exceto CLASSROOM,
e poderá conceder esses privilégios a outros usuários.
*/

GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.student TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.instructor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.department TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.course TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.section TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.teaches TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.takes TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.advisor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.time_slot TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.prereq TO User_A WITH GRANT OPTION;
GO


/*
QUESTÃO 03
Listar as permissões do User_A
*/

SELECT 
    dp.state_desc AS tipo_permissao,
    dp.permission_name AS permissao,
    OBJECT_NAME(dp.major_id) AS objeto,
    pr.name AS usuario
FROM sys.database_permissions dp
JOIN sys.database_principals pr
    ON dp.grantee_principal_id = pr.principal_id
WHERE pr.name = 'User_A'
ORDER BY objeto, permissao;
GO