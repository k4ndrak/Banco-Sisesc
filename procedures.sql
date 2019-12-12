drop procedure if exists proc_turma_completa;
drop procedure if exists proc_trancar_matricula;
drop procedure if exists proc_destrancar_matricula;
drop procedure if exists proc_cadastrar_aluno;
drop procedure if exists proc_cadastrar_professor;
drop procedure if exists proc_historico_aluno;
delimiter //
create procedure proc_turma_completa(disc_semestre int)
begin 	
	select nome_discipl as Disciplina, carga_hora_disc, view_disciplinas_professores.Nome as Professor, view_disciplinas_professores.Colegiado, data_inicio, data_fim, view_dados_aluno.Nome as Alunos,
view_dados_aluno.Curso, view_dados_aluno.Matricula, view_dados_aluno.email
from tbl_disc_semestre
    inner join tbl_disciplina on tbl_disciplina.id = tbl_disc_semestre.fk_disc
    inner join 	view_disciplinas_professores on view_disciplinas_professores.disciplina = tbl_disciplina.nome_discipl
    inner join tbl_disc_hist on tbl_disc_hist.fk_disc_semestre = disc_semestre
    inner join tbl_historico on tbl_historico.id = tbl_disc_hist.fk_hist 
    inner join view_dados_aluno on view_dados_aluno.Matricula = tbl_historico.fk_aluno_hist
    where tbl_disc_semestre.id = disc_semestre;
end //
delimiter;

delimiter $
create procedure proc_trancar_matricula(matricula int)
begin
	update tbl_aluno set status_matricula = 0 where tbl_aluno.matricula = matricula;
end $
delimiter;

delimiter $$
create procedure proc_destrancar_matricula(matricula int)
begin
	update tbl_aluno set status_matricula = 1 where tbl_aluno.matricula = matricula;
end $$

delimiter;

delimiter %
create procedure proc_cadastrar_aluno(nome varchar(30) , sobrenome varchar(30), cpf varchar(11), sexo char(1), pai_user varchar(60), mae_user varchar(60), email varchar(80), fk_curso int)
begin
	declare id_user int;
	insert into tbl_user(nome_user, sobrenome_user, cpf_user, sexo_user, pai_user, mae_user, email_user) values(nome, sobrenome, cpf, sexo, pai_user, mae_user, email);
	select max(id) into id_user from tbl_user;
    insert into tbl_aluno(fk_user_aluno, fk_curso_aluno) values (id_user, fk_curso);
end %

delimiter %
create procedure proc_cadastrar_professor(nome varchar(30) , sobrenome varchar(30), cpf varchar(11), sexo char(1), pai_user varchar(60), mae_user varchar(60), email varchar(80), fk_colegiado int)
begin
	declare id_user, id_funcionario int;
	insert into tbl_user values(null, nome, sobrenome, cpf, 1, sexo, pai_user, mae_user, email);
	select max(id) into id_user from tbl_user;
    insert into tbl_funcionario values (null, id_user);
    select max(id) into id_funcionario from tbl_funcionario;
    insert into tbl_professor values( null, id_funcionario, fk_colegiado, 1);
end %
delimiter;
delimiter &&
create procedure proc_historico_aluno(matricula_aluno int)
begin
	select
fn_nome_completo(tbl_user.id), tbl_cursos.nome_curso,
nome_discipl,
view_notas_disciplinas.semestre, 
view_notas_disciplinas.cod_turma, frequencia as FREQUENCIA_FINAL,
avg(view_notas_disciplinas.nota) as NOTA_FINAL
from view_notas_disciplinas
inner join view_frequencias_disciplinas on view_notas_disciplinas.disc_hist = view_frequencias_disciplinas.disc_hist
inner join tbl_aluno on tbl_aluno.matricula = view_notas_disciplinas.matricula
inner join tbl_user on tbl_user.id = tbl_aluno.fk_user_aluno
inner join tbl_disc_hist on tbl_disc_hist.id = view_notas_disciplinas.disc_hist
inner join tbl_disc_semestre on tbl_disc_semestre.id = tbl_disc_hist.fk_disc_semestre
inner join tbl_curso_discip on tbl_curso_discip.fk_curso = tbl_aluno.fk_curso_aluno
left join tbl_disciplina on tbl_disciplina.id = tbl_curso_discip.fk_discip
inner join tbl_cursos on tbl_cursos.id = tbl_aluno.fk_curso_aluno
where view_notas_disciplinas.matricula = matricula_aluno
group by view_frequencias_disciplinas.disc_hist;
end &&
