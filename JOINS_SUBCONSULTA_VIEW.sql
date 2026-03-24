-- LISTA SQL - JOINS, SUBCONSULTA E VIEW
-- Banco: PTBPABD
-- Schema: dbo


-- QUESTÃO 1
-- Gere uma lista de todos os instrutores, mostrando sua ID,
-- nome e número de seções que eles ministraram.
-- Mostrar 0 para os instrutores que não ministraram nenhuma seção.
-- Usar OUTER JOIN e não usar subconsulta escalar.


SELECT
    i.ID,
    i.name,
    COUNT(t.course_id) AS [Number of sections] --Conta quantas seções foram ministradas pelo instrutor
FROM dbo.instructor i
LEFT JOIN dbo.teaches t -- usamos LEFT JOIN porque queremos manter todos os instrutores-- usamos LEFT JOIN porque queremos manter todos os instrutores mesmo que eles não tenham registros na tabela teaches
    ON i.ID = t.ID
GROUP BY i.ID, i.name
ORDER BY i.ID;


-- QUESTÃO 2
-- Escreva a mesma consulta do item anterior, mas usando
-- subconsulta escalar, sem OUTER JOIN.

SELECT
    i.ID,
    i.name,
    (
        SELECT COUNT(*)
        FROM dbo.teaches t
        WHERE t.ID = i.ID
    ) AS [Number of sections]
FROM dbo.instructor i
ORDER BY i.ID;


-- QUESTÃO 3
-- Gere a lista de todas as seções de curso oferecidas
-- na primavera de 2010, junto com o nome dos instrutores
-- ministrando a seção.
-- Se uma seção tiver mais de 1 instrutor, deve aparecer
-- uma vez para cada instrutor.
-- Se não houver instrutor, mostrar "-" no nome.

SELECT
    s.course_id,
    s.sec_id,
    s.semester,
    s.year,
    COALESCE(i.name, '-') AS name
FROM dbo.section s
LEFT JOIN dbo.teaches t
    ON s.course_id = t.course_id
   AND s.sec_id = t.sec_id
   AND s.semester = t.semester
   AND s.year = t.year
LEFT JOIN dbo.instructor i
    ON t.ID = i.ID
WHERE s.semester = 'Spring'
  AND s.year = 2010
ORDER BY s.course_id, s.sec_id, name;


--QUESTÃO 4
-- Cria a tabela grade_points somente se ela não existir

IF OBJECT_ID('dbo.grade_points', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.grade_points ( -- cria uma tabela para armazenar as notas
        grade VARCHAR(2) PRIMARY KEY,
        points DECIMAL(2,1)
    );

    INSERT INTO dbo.grade_points (grade, points) VALUES -- cria uma conversão das notas numéricas para letras
    ('A+', 4.0),
    ('A', 3.7),
    ('A-', 3.4),
    ('B+', 3.1),
    ('B', 2.8),
    ('B-', 2.5),
    ('C+', 2.2),
    ('C', 1.9),
    ('C-', 1.6),
    ('D', 1.0),
    ('F', 0.0);
END;


-- QUESTÃO 4
-- Dada a relação grade_points(grade, points), ache os pontos
-- totais recebidos por aluno, para todos os cursos realizados.
-- Pontos totais = credits * points

SELECT
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    tk.grade,
    gp.points,
    c.credits,
    (gp.points * c.credits) AS [Pontos totais]
FROM dbo.student s
JOIN dbo.takes tk
    ON s.ID = tk.ID
JOIN dbo.course c
    ON tk.course_id = c.course_id
JOIN dbo.grade_points gp
    ON tk.grade = gp.grade
ORDER BY s.ID, c.title;


-- QUESTÃO 5
-- Criar uma view a partir do resultado da Questão 4
-- com o nome coeficiente_rendimento

IF OBJECT_ID('dbo.coeficiente_rendimento', 'V') IS NOT NULL
    DROP VIEW dbo.coeficiente_rendimento;


CREATE VIEW dbo.coeficiente_rendimento AS
SELECT
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    tk.grade,
    gp.points,
    c.credits,
    (gp.points * c.credits) AS [Pontos totais]
FROM dbo.student s
JOIN dbo.takes tk
    ON s.ID = tk.ID
JOIN dbo.course c
    ON tk.course_id = c.course_id
JOIN dbo.grade_points gp
    ON tk.grade = gp.grade;



-- CONSULTA PARA TESTAR A VIEW

SELECT *
FROM dbo.coeficiente_rendimento; -- usamos a view parta não usar select todas as vezes, a view apenas mostra uma consulta ja salva. 
