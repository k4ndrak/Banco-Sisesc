
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
drop function if exists fn_nome_completo;

delimiter &&
create function fn_nome_completo(id_user int) returns varchar(60)
begin
	declare nome_completo varchar(60);
	select concat(nome_user, ' ', sobrenome_user) into nome_completo from tbl_user where tbl_user.id = id_user;
    return nome_completo;
end &&