-- Questão 2 -
-- Implemente uma função que utilize cursor para percorrer a relação cursos e caso
-- não tenha coordenador definido, atualize o registro vinculando-o ao professor
-- mais antigo que dê aula nesse curso.
-- * Caso não haja cursos sem coordenador, altere um dos cursos removendo o
-- cod_coord para testar o cursor.


CREATE OR REPLACE FUNCTION add_coord()
RETURNS VOID AS $$
DECLARE
    dataset CURSOR FOR SELECT * FROM cursos;
    professor_cod_prof integer;
BEGIN
    RAISE NOTICE 'Cursos atualizados';
    FOR curso IN dataset LOOP
		IF curso.cod_coord IS null THEN
            -- Busca o professor mais antigo que dá aula no curso
            SELECT p.cod_prof, MIN(t.ano) as ano, c.cod_curso
            INTO professor_cod_prof
            FROM professores p JOIN turmas t
            ON p.cod_prof = t.cod_prof
            JOIN curriculos c
            ON c.cod_disc = t.cod_disc
            GROUP BY p.cod_prof, c.cod_curso
            ORDER BY ano ASC
            LIMIT 1;

            -- Atualiza o curso que não possui coordenador
            UPDATE cursos
            SET cod_coord = professor_cod_prof
            WHERE cod_curso = curso.cod_curso;

        	RAISE NOTICE '- %', curso.nom_curso;
		END IF;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;