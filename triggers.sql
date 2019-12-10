drop trigger if exists trg_cria_historico;

delimiter $$
create trigger trg_cria_historico after insert on tbl_aluno
	for each row
		insert into tbl_historico values (null, new.matricula, curdate(), null);
$$


drop trigger if exists trg_cria_login;

delimiter $$
create trigger trg_cria_login after insert on tbl_user
	for each row
		insert into tbl_login values (null, new.nome_user, md5(new.cpf_user), 1, new.id);
$$


drop trigger if exists trg_valida_matricula;

delimiter $$
create trigger trg_valida_matricula before insert on tbl_disc_hist
	for each row
	begin
		declare curso_aluno int default 0;
		declare new_disc int default 0;
		declare curso_disc int default 0; 

		select fk_curso_aluno into curso_aluno from tbl_aluno where tbl_aluno.matricula =
			(select fk_aluno_hist from tbl_historico where new.fk_hist = tbl_historico.id);

		select fk_disc into new_disc from tbl_disc_semestre where new.fk_disc_semestre = tbl_disc_semestre.id;

		select id into curso_disc from tbl_curso_discip where tbl_curso_discip.fk_curso = curso_aluno
		AND tbl_curso_discip.fk_discip = new_disc;


		if curso_disc = 0 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Disciplina inválida para este curso';
		end if;

	end
$$