/* =========================================================
   QUESTÃO 01
   Procedimento: student_grade_points
   ========================================================= */

CREATE PROCEDURE dbo.student_grade_points
    @grade VARCHAR(2)
AS
BEGIN
    SELECT
        s.name AS nome_estudante,
        s.dept_name AS departamento_estudante,
        c.title AS titulo_curso,
        c.dept_name AS departamento_curso,
        t.semester AS semestre,
        t.year AS ano,
        t.grade AS pontuacao_alfanumerica,
        gp.points AS pontuacao_numerica
    FROM student s
    JOIN takes t
        ON s.ID = t.ID
    JOIN course c
        ON t.course_id = c.course_id
    JOIN grade_points gp
        ON t.grade = gp.grade
    WHERE t.grade = @grade;
END;


/* Exemplo de uso */

EXEC dbo.student_grade_points 'A+';




/* =========================================================
   QUESTÃO 02
   Função: return_instructor_location
   ========================================================= */

CREATE FUNCTION dbo.return_instructor_location
(
    @instructor_name VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        i.name AS nome_instrutor,
        c.title AS curso_ministrado,
        te.semester AS semestre,
        te.year AS ano,
        se.building AS predio,
        se.room_number AS sala
    FROM instructor i
    JOIN teaches te
        ON i.ID = te.ID
    JOIN course c
        ON te.course_id = c.course_id
    JOIN section se
        ON te.course_id = se.course_id
        AND te.sec_id = se.sec_id
        AND te.semester = se.semester
        AND te.year = se.year
    WHERE i.name = @instructor_name
);



/* Exemplo de uso */

SELECT *
FROM dbo.return_instructor_location('Gustafsson');
