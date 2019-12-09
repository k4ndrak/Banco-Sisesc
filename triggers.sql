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
			insert into tbl_login values (null, new.nome_user, md5(new.cpf_user), 1, new.id_user);
$$