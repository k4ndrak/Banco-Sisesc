drop procedure if exists proc_turma_completa;

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