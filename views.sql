
drop view if exists view_dados_aluno;

delimiter $$
create view view_dados_aluno as
	select matricula as Matricula, concat(nome_user, ' ', sobrenome_user) as Nome, nome_curso as Curso, fn_situacao_aluno(status_user) as Situacao,
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

drop view if exists view_alunos_p_curso;

delimiter $$
create view view_alunos_p_curso as
	select nome_curso as Curso, count(fk_curso_aluno) as Alunos from tbl_cursos
	left join tbl_aluno on tbl_cursos.id = tbl_aluno.fk_curso_aluno group by fk_curso_aluno order by Alunos desc;
$$

drop view if exists view_historico;

delimiter $$
create view view_historico as
	select matricula, view_dados_aluno.nome, curso, nome_discipl as Disciplina, tbl_semestre.nome Semestre from view_dados_aluno
	inner join tbl_historico on matricula = tbl_historico.fk_aluno_hist
	join tbl_disc_hist on tbl_historico.id = tbl_disc_hist.fk_hist
	join tbl_disc_semestre on tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
	join tbl_semestre on tbl_disc_semestre.fk_semestre = tbl_semestre.id
	join tbl_prof_disc on tbl_disc_semestre.fk_prof_disc = tbl_prof_disc.id
	join tbl_disciplina on tbl_prof_disc.fk_discip_prof = tbl_disciplina.id;
$$
