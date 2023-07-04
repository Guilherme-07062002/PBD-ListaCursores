-- Questão 1 -
-- Implemente uma função que utilize cursor para percorrer a relação
-- historicos_escolares e imprima todos as matriculas com nota abaixo de 6.
CREATE OR REPLACE FUNCTION print_matricula()
RETURNS VOID AS $$
DECLARE
    cursor_alunos CURSOR FOR SELECT * FROM alunos;
BEGIN
    FOR aluno IN cursor_alunos LOOP
		IF aluno.mgp < 6 THEN
        	RAISE NOTICE 'Nome: % | Matricula: %', aluno.nom_alu, aluno.mat_alu;
		END IF;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;
