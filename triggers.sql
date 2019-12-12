-- Assim que o aluno é criado gera um histórico pra ele
drop trigger if exists trg_cria_historico;
delimiter $$
create trigger trg_cria_historico after insert on tbl_aluno
	for each row
		insert into tbl_historico values (null, new.matricula, curdate(), null);
$$
delimiter ;

drop trigger if exists trg_cria_login;

-- Cria o login do usuario assim que ele cadastra
-- User: nome
-- Senha: cpf
delimiter $$
create trigger trg_cria_login after insert on tbl_user
	for each row
		insert into tbl_login values (null, new.nome_user, md5(new.cpf_user), new.id);
$$
delimiter ;

-- Verifica as coindições para um aluno poder se matricular em uma disciplina
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
		declare qtd_disciplinas int default 0;

		-- SELECT matricula_ativa
		select status_matricula into matricula_ativa from tbl_aluno, tbl_historico where tbl_historico.id = new.fk_hist
		AND tbl_historico.fk_aluno_hist = tbl_aluno.matricula;
		if matricula_ativa = 0 then
			signal sqlstate '45000'	SET MESSAGE_TEXT = 'Matrícula do aluno está trancada.';
		end if;

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

		-- SELECT qtd_disciplinas
		select count(status) into qtd_disciplinas from tbl_disc_hist where tbl_disc_hist.fk_hist = new.fk_hist
		AND tbl_disc_hist.status = 1;

		if qtd_disciplinas >= 9 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Quantidade máxima de matrículas atingida.';
		end if;

	end
$$
delimiter ;

-- Verifica as condições para alocar o professor em uma disciplina do semestre
drop trigger if exists trg_verifica_disciplinas_professor;
delimiter $$
create trigger trg_verifica_disciplinas_professor before insert on tbl_disc_semestre
for each row
	begin

		declare disc_semestre int default 0; -- verifica quantas disciplinas o professor já tem no semestre
		declare disc_prof int default 0; -- verifica se o professor pode dar essa disciplina
		
		-- SELECT disc_semestre
		select count(fk_professor) into disc_semestre from tbl_disc_semestre where tbl_disc_semestre.fk_professor = new.fk_professor
		AND tbl_disc_semestre.fk_semestre = new.fk_semestre;

		if disc_semestre >= 4 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Professor já está lecionando 4 disciplinas nesse semestre.';
		end if;

		select count(id) into disc_prof from tbl_prof_disc where tbl_prof_disc.fk_professor = new.fk_professor
		AND tbl_prof_disc.fk_discip_prof = new.fk_disc;

		-- SELECT disc_prof
		if disc_prof = 0 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Professor não está cadastrado para lecionar esta disciplina.';
		end if;

	end
$$
delimiter ;

-- Verifica se o aluno não está matriculado em nenhuma disciplina antes de fazer o trancamento da matrícula
-- Verifica se o usuário não possui vínculo de aluno com matrícula ativa em algum curso antes de criar um novo aluno
drop trigger if exists trg_valida_trancamento_destrancamento;
delimiter $$
create trigger trg_valida_trancamento_destrancamento before update on tbl_aluno
for each row
	begin

		declare id_historico int default 0; -- Guarda o id do histórico do aluno
		declare disc_matriculadas int default 0; -- Verifica quantas disciplinas estão com status 1 (matriculado)
		declare curso_aluno int default 0; -- Verifica se o aluno já possui matricula no curso que está registrando

		-- SELECT id_historico
		select id into id_historico from tbl_historico where tbl_historico.fk_aluno_hist = new.matricula;
		-- SELECT disc_matriculadas
		select count(id) into disc_matriculadas from tbl_disc_hist where tbl_disc_hist.fk_hist = id_historico
		AND tbl_disc_hist.status = 1;
		if new.status_matricula = 0 AND old.status_matricula = 3 then
			if disc_matriculadas > 0 then
				signal sqlstate '45000' SET MESSAGE_TEXT = 'Aluno está matriculado em disciplinas';
			end if;
		end if;

		-- SELECT curso_aluno
		select count(matricula) into curso_aluno from tbl_aluno where tbl_aluno.fk_user_aluno = new.fk_user_aluno
		AND tbl_aluno.fk_curso_aluno = new.fk_curso_aluno;
		if new.status_matricula = 3  AND old.status_matricula = 0 then
			if curso_aluno <> 0 then
				signal sqlstate '45000' SET MESSAGE_TEXT = 'Aluno já possui matrícula ativa em um curso.';
			end if;
		end if;

	end
$$
delimiter ;

-- Verifica antes de criar um aluno num curso, se o usuario deste aluno está em outro curso com matricula ativa
drop trigger if exists trg_verifica_curso_ativo_aluno;
delimiter $$
create trigger trg_verifica_curso_ativo_aluno before insert on tbl_aluno
for each row
	begin
		declare aluno_ativo int default 0; -- Verifica se o aluno já está ativo em um curso
		declare curso_aluno int default 0; -- Verifica se o aluno já possui matricula no curso que está registrando
		-- Select aluno_ativo
		select sum(status_matricula) into aluno_ativo from tbl_aluno where tbl_aluno.fk_user_aluno = new.fk_user_aluno;

		if mod(aluno_ativo, 2) <> 0 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Aluno possui matrícula ativa com um curso.';
		end if;

		-- SELECT curso_ativo
		select count(matricula) into curso_aluno from tbl_aluno where tbl_aluno.fk_user_aluno = new.fk_user_aluno
		AND tbl_aluno.fk_curso_aluno = new.fk_curso_aluno;

		if curso_aluno <> 0 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Aluno já possui matrícula neste curso.';
		end if;

		-- Insere a data de início do aluno sendo o ano corrente caso nenhuma seja informada
		if (new.ano_inicio is null) then
			set new.ano_inicio = year(curdate());
		end if;
	end
$$
delimiter ;

-- Verifica se o professor já está cadastrado pra disciplina
drop trigger if exists trg_valida_prof_disc;
delimiter $$
create trigger trg_valida_prof_disc before insert on tbl_prof_disc
for each row
	begin
		if (select count(id) from tbl_prof_disc where tbl_prof_disc.fk_professor = new.fk_professor
		  AND tbl_prof_disc.fk_discip_prof = new.fk_discip_prof) > 0 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Registro duplicado';
		end if;

	end
$$
delimiter ;

-- Verifica se a formação do funcionário já existe
drop trigger if exists trg_valida_formacao_funcionario;
delimiter $$
create trigger trg_valida_formacao_funcionario before insert on tbl_formacao_funcionario
for each row
	begin
		if (select count(id) from tbl_formacao_funcionario where tbl_formacao_funcionario.fk_funcionario = new.fk_funcionario
		  AND tbl_formacao_funcionario.fk_nivel_formacao = new.fk_nivel_formacao
		  AND tbl_formacao_funcionario.fk_nome_formacao = new.fk_nome_formacao) > 0 then
			signal sqlstate '45000' SET MESSAGE_TEXT = 'Registro duplicado';
		end if;
	end
$$