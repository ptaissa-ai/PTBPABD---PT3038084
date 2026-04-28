/*
QUESTÃO 01
O User_B poderá selecionar todos os atributos da relação INSTRUCTOR e TAKES,
exceto salary e grade, respectivamente.
*/

GRANT SELECT (ID, name, dept_name)
ON dbo.instructor
TO User_B;

GRANT SELECT (ID, course_id, sec_id, semester, year)
ON dbo.takes
TO User_B;



/*
QUESTÃO 02
O User_C poderá selecionar ou modificar a relação SECTION,
mas só poderá recuperar e modificar os atributos:
course_id, sec_id, semester e year.
*/

GRANT SELECT (course_id, sec_id, semester, year)
ON dbo.section
TO User_C;

GRANT UPDATE (course_id, sec_id, semester, year)
ON dbo.section
TO User_C;



/*
QUESTÃO 03
O User_D poderá selecionar qualquer atributo das relações INSTRUCTOR e STUDENT.
Poderá selecionar os atributos da view grade_points.
*/

GRANT SELECT
ON dbo.instructor
TO User_D;

GRANT SELECT
ON dbo.student
TO User_D;

GRANT SELECT
ON dbo.grade_points
TO User_D;


/*
QUESTÃO 04
O User_E poderá selecionar qualquer atributo de STUDENT,
mas somente para tuplas de STUDENT que têm dept_name = 'Civil Eng.'
*/

CREATE OR ALTER VIEW dbo.student_civil_eng AS
SELECT *
FROM dbo.student
WHERE dept_name = 'Civil Eng.';


GRANT SELECT
ON dbo.student_civil_eng
TO User_E;



/*
QUESTÃO 05
Revogue os privilégios do usuário User_E
*/

REVOKE SELECT
ON dbo.student_civil_eng
FROM User_E;



/*
QUESTÃO 06
Mostre os privilégios concedidos aos usuários
User_A, User_B, User_C, User_D e User_E.
*/

SELECT 
    pr.name AS usuario,
    dp.state_desc AS tipo_permissao,
    dp.permission_name AS permissao,
    OBJECT_NAME(dp.major_id) AS objeto,
    col.name AS coluna
FROM sys.database_permissions dp
JOIN sys.database_principals pr
    ON dp.grantee_principal_id = pr.principal_id
LEFT JOIN sys.columns col
    ON col.object_id = dp.major_id
    AND col.column_id = dp.minor_id
WHERE pr.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E')
ORDER BY pr.name, objeto, permissao, coluna;
