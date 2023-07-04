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
BEGIN
    RAISE NOTICE 'Cursos sem coordenador';
    FOR curso IN dataset LOOP
		IF curso.cod_coord IS null THEN
        	RAISE NOTICE '- %', curso.nom_curso;
		END IF;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

