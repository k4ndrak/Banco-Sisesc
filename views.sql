CREATE OR REPLACE VIEW view_dados_aluno AS
    SELECT 
        tbl_user.id AS id_user,
        matricula AS Matricula,
        FN_NOME_COMPLETO(tbl_user.id) AS Nome,
        nome_curso AS Curso,
        FN_SITUACAO_ALUNO(status_user) AS Situacao,
        cpf_user AS CPF,
        sexo_user AS Sexo,
        pai_user AS Pai,
        mae_user AS Mae,
        email_user AS 'email'
    FROM
        tbl_aluno
            INNER JOIN
        tbl_user ON tbl_aluno.fk_user_aluno = tbl_user.id
            JOIN
        tbl_cursos ON tbl_aluno.fk_curso_aluno = tbl_cursos.id;

CREATE OR REPLACE VIEW view_disciplinas_professores AS
    SELECT 
        FN_NOME_COMPLETO(tbl_user.id) AS Nome,
        nome_discipl AS Disciplina,
        nome_curso AS Curso,
        nome_colegiado AS Colegiado
    FROM
        tbl_professor
            INNER JOIN
        tbl_funcionario ON tbl_professor.id = tbl_funcionario.id
            JOIN
        tbl_user ON tbl_funcionario.fk_user = tbl_user.id
            JOIN
        tbl_prof_disc ON tbl_professor.id = tbl_prof_disc.fk_professor
            JOIN
        tbl_disciplina ON tbl_prof_disc.fk_discip_prof = tbl_disciplina.id
            JOIN
        tbl_curso_discip ON tbl_disciplina.id = tbl_curso_discip.fk_discip
            JOIN
        tbl_cursos ON tbl_curso_discip.fk_curso = tbl_cursos.id
            JOIN
        tbl_colegiado ON tbl_cursos.fk_coleg_curso = tbl_colegiado.id;

create or replace view view_alunos_por_curso as
	select nome_curso as Curso, count(fk_curso_aluno) as Alunos from tbl_cursos
	left join tbl_aluno on tbl_cursos.id = tbl_aluno.fk_curso_aluno group by fk_curso_aluno order by Alunos desc;

create or replace view view_endereco as
	select fk_user_end as Usuario, concat(lograd_descricao, ' ', tbl_rua.nome) as Endereco, n_casa as 'Nº', tbl_cep.cep as CEP,
	bairro as Bairro, cid_descricao as Cidade, uf_descricao as Estado from tbl_end
	inner join tbl_rua on tbl_end.fk_rua = tbl_rua.id
	join tbl_logradouro on tbl_rua.fk_logradouro = tbl_logradouro.id
	join tbl_cep on tbl_rua.fk_cep = tbl_cep.id
	join tbl_bairros on tbl_rua.fk_bairro = tbl_bairros.id
	join tbl_cidades on tbl_bairros.id_fk = tbl_cidades.id
	join tbl_uf on tbl_cidades.id_fk = tbl_uf.id;

create or replace view view_aluno_endereco as
select * from view_dados_aluno, view_endereco where view_dados_aluno.id_user = view_endereco.Usuario;

create or replace view view_notas_disciplinas as 
select
tbl_nota_disciplina.id,  
tbl_aluno.matricula as matricula, tbl_disc_semestre.id as cod_turma, tbl_disc_hist.id as disc_hist, 
tbl_nota_disciplina.nota, tbl_semestre.nome as semestre
from tbl_nota_disciplina
inner join tbl_disc_hist on tbl_nota_disciplina.fk_disc_hist = tbl_disc_hist.id
inner join tbl_historico on tbl_disc_hist.fk_hist = tbl_historico.id
inner join tbl_disc_semestre on tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
inner join tbl_aluno on tbl_aluno.matricula = tbl_historico.fk_aluno_hist
inner join tbl_semestre on tbl_semestre.id = tbl_disc_semestre.fk_semestre
;

CREATE OR REPLACE VIEW view_frequencias_disciplinas AS
    SELECT 
        tbl_frequencia_disciplina.id,
        tbl_aluno.matricula,
        tbl_disc_semestre.id AS cod_turma,
        tbl_disc_hist.id AS disc_hist,
        SUM(tbl_frequencia_disciplina.frequencia) AS frequencia,
        tbl_semestre.nome AS semestre
    FROM
        tbl_frequencia_disciplina
            INNER JOIN
        tbl_disc_hist ON tbl_frequencia_disciplina.fk_disc_hist = tbl_disc_hist.id
            INNER JOIN
        tbl_historico ON tbl_disc_hist.fk_hist = tbl_historico.id
            INNER JOIN
        tbl_disc_semestre ON tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
            INNER JOIN
        tbl_aluno ON tbl_aluno.matricula = tbl_historico.fk_aluno_hist
            INNER JOIN
        tbl_semestre ON tbl_semestre.id = tbl_disc_semestre.fk_semestre
    GROUP BY disc_hist
;

CREATE OR REPLACE VIEW view_disciplinas_cursos AS
    SELECT 
        tbl_curso_discip.id,
        nome_curso,
        fk_curso AS id_curso,
        tbl_disciplina.id AS id_disciplina,
        nome_discipl,
        fk_depende_discipl,
        carga_hora_disc,
        num_aluno_disc
    FROM
        tbl_curso_discip,
        tbl_cursos,
        tbl_disciplina
    WHERE
        tbl_curso_discip.fk_discip = tbl_disciplina.id
            AND tbl_cursos.id = tbl_curso_discip.fk_curso