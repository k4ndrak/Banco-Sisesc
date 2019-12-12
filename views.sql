create or replace view view_dados_aluno as
	select tbl_user.id as id_user, matricula as Matricula, fn_nome_completo(tbl_user.id) as Nome, nome_curso as Curso, fn_situacao_aluno(status_user) as Situacao,
		cpf_user as CPF, sexo_user as Sexo, pai_user as Pai, mae_user as Mae,
		email_user as 'email' from tbl_aluno inner join tbl_user on tbl_aluno.fk_user_aluno = tbl_user.id
		join tbl_cursos on tbl_aluno.fk_curso_aluno = tbl_cursos.id;

create or replace view view_disciplinas_professores as
	select fn_nome_completo(tbl_user.id) as Nome, nome_discipl as Disciplina, nome_curso as Curso,
	nome_colegiado as Colegiado from tbl_professor
	inner join tbl_funcionario on tbl_professor.id = tbl_funcionario.id
	join tbl_user on tbl_funcionario.fk_user = tbl_user.id
	join tbl_prof_disc on tbl_professor.id = tbl_prof_disc.fk_professor
	join tbl_disciplina on tbl_prof_disc.fk_discip_prof = tbl_disciplina.id
	join tbl_curso_discip on tbl_disciplina.id = tbl_curso_discip.fk_discip
	join tbl_cursos on tbl_curso_discip.fk_curso = tbl_cursos.id
	join tbl_colegiado on tbl_cursos.fk_coleg_curso = tbl_colegiado.id;

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

create or replace view view_frequencias_disciplinas as 
select 
tbl_frequencia_disciplina.id, tbl_aluno.matricula, tbl_disc_semestre.id as cod_turma, tbl_disc_hist.id as disc_hist,
sum(tbl_frequencia_disciplina.frequencia) as frequencia,
tbl_semestre.nome as semestre
from tbl_frequencia_disciplina
inner join tbl_disc_hist on tbl_frequencia_disciplina.fk_disc_hist = tbl_disc_hist.id
inner join tbl_historico on tbl_disc_hist.fk_hist = tbl_historico.id
inner join tbl_disc_semestre on tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
inner join tbl_aluno on tbl_aluno.matricula = tbl_historico.fk_aluno_hist
inner join tbl_semestre on tbl_semestre.id = tbl_disc_semestre.fk_semestre
group by disc_hist
;