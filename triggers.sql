drop trigger if exists trg_cria_historico;

delimiter $$
create trigger trg_cria_historico after insert on tbl_aluno
	for each row
		insert into tbl_historico values (null, new.matricula, curdate(), null);
$$