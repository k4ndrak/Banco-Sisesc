
drop view if exists view_dados_aluno;

delimiter $$
create view view_dados_aluno as
	select concat(nome_user, ' ', sobrenome_user) as Nome, nome_curso as Curso, fn_situacao_aluno(status_user) as Situacao,
		cpf_user as CPF, sexo_user as Sexo, pai_user as Pai, mae_user as Mae,
		email_user as 'e-mail' from tbl_aluno inner join tbl_user on tbl_aluno.fk_user_aluno = tbl_user.id
		join tbl_cursos on tbl_aluno.fk_curso_aluno = tbl_cursos.id;
$$


drop view if exists view_disciplinas_professores;

delimiter $$
create view view_disciplinas_professores as
	select concat(nome_user, ' ', sobrenome_user) as Nome, nome_discipl as Disciplina, nome_curso as Curso,
	nome_colegiado as Colegiado from tbl_professor
	inner join tbl_funcionario on tbl_professor.id = tbl_funcionario.id
	join tbl_user on tbl_funcionario.fk_user = tbl_user.id
	join tbl_prof_disc on tbl_professor.id = tbl_prof_disc.fk_professor
	join tbl_disciplina on tbl_prof_disc.fk_discip_prof = tbl_disciplina.id
	join tbl_curso_discip on tbl_disciplina.id = tbl_curso_discip.fk_discip
	join tbl_cursos on tbl_curso_discip.fk_curso = tbl_cursos.id
	join tbl_colegiado on tbl_cursos.fk_coleg_curso = tbl_colegiado.id;
$$