
drop view if exists view_dados_aluno;

delimiter $$
create view view_dados_aluno as
	select concat(nome_user, ' ', sobrenome_user) as Nome, nome_curso as Curso, fn_situacao_aluno(status_user) as Situacao,
		cpf_user as CPF, sexo_user as Sexo, pai_user as Pai, mae_user as Mae,
		email_user as 'e-mail' from tbl_aluno inner join tbl_user on tbl_aluno.fk_user_aluno = tbl_user.id
		join tbl_cursos on tbl_aluno.fk_curso_aluno = tbl_cursos.id;
$$