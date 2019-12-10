drop trigger if exists trg_cria_historico;

delimiter $$
create trigger trg_cria_historico after insert on tbl_aluno
	for each row
		insert into tbl_historico values (null, new.matricula, curdate(), null);
$$
delimiter ;

drop trigger if exists trg_cria_login;

delimiter $$
create trigger trg_cria_login after insert on tbl_user
	for each row
		insert into tbl_login values (null, new.nome_user, md5(new.cpf_user), new.id);
$$
delimiter ;

drop trigger if exists trg_valida_matricula;

delimiter $$
create trigger trg_valida_matricula before insert on tbl_disc_hist
	for each row
	begin

		declare curso_aluno int default 0; -- curso do aluno
		declare new_disc int default 0; -- disciplina que está tentando fazer matrícula
		declare curso_disc int default 0; -- verifica se a disciplina é do curso
		declare status_disc int default 0; -- verifica se o aluno já foi aprovado nessa disciplina
		declare x_cursada int default 0; -- verifica quantas vezes o aluno fez a disciplina
		declare matriculado int default 0; -- verifica se o aluno já ta matriculado nessa disciplina nesse semestre
		declare alunos_turma int default 0; -- verifica se já atingiu 30 alunos na disciplina
		declare matricula_ativa int default 0; -- verifica se a matricula do aluno está ativa

		-- SELECT curso_aluno
		select fk_curso_aluno into curso_aluno from tbl_aluno where tbl_aluno.matricula =
			(select fk_aluno_hist from tbl_historico where new.fk_hist = tbl_historico.id);

		-- SELECT new_disc
		select fk_disc into new_disc from tbl_disc_semestre where new.fk_disc_semestre = tbl_disc_semestre.id;

		-- SELECT curso_disc
		select id into curso_disc from tbl_curso_discip where tbl_curso_discip.fk_curso = curso_aluno
		AND tbl_curso_discip.fk_discip = new_disc;
		if curso_disc = 0 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Disciplina inválida para este curso.';
		end if;

		-- SELECT status_disc
		select count(fk_disc_semestre) into status_disc from tbl_disc_hist, tbl_disc_semestre where tbl_disc_semestre.fk_disc = new_disc
		AND tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
		AND tbl_disc_hist.fk_hist = new.fk_hist
		AND tbl_disc_hist.status = 2;
		if status_disc = 2 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Aluno já aprovou nesta disciplina.';
		end if;

		-- SELECT x_cursada
		select count(fk_disc_semestre) into x_cursada from tbl_disc_hist, tbl_disc_semestre where tbl_disc_semestre.fk_disc = new_disc
		AND tbl_disc_hist.fk_disc_semestre = tbl_disc_semestre.id
		AND tbl_disc_hist.fk_hist = new.fk_hist;
		if x_cursada = 3 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Disciplina reprovada 3 vezes, matrícula impedida.';
		end if; 

		-- SELECT matriculado
		select count(fk_disc_semestre) into matriculado from tbl_disc_hist
		where tbl_disc_hist.fk_disc_semestre = new.fk_disc_semestre
		AND tbl_disc_hist.fk_hist = new.fk_hist;
		if matriculado = 1 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Aluno já está matriculado nesta disciplina.';
		end if;

		-- SELECT alunos_turma
		select count(fk_disc_semestre) into alunos_turma from tbl_disc_hist where tbl_disc_hist.fk_disc_semestre = new.fk_disc_semestre;
		if alunos_turma >= 30 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Não há mais vagas para essa disciplina.';
		end if;

		-- SELECT matricula_ativa
		select status_matricula into matricula_ativa from tbl_aluno, tbl_historico where tbl_historico.id = new.fk_hist
		AND tbl_historico.fk_aluno_hist = tbl_aluno.matricula;
		if matricula_ativa = 0 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Matrícula do aluno';
		end if;

	end
$$
delimiter ;


drop trigger if exists trg_data_inicio_aluno;

delimiter $$
create trigger trg_data_inicio_aluno before insert on tbl_aluno
for each row
	begin
		if (new.ano_inicio is null) then
			set new.ano_inicio = year(curdate());
		end if;
	end
$$