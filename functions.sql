
drop function if exists fn_situacao_aluno;

delimiter $$
create function fn_situacao_aluno(status int) returns varchar(15)
	begin
		if status = 0 then
			return 'INATIVO';
		elseif status = 1 then
			return 'ATIVO';
		end if;
		return 'DESCONHECIDO';
	end
$$