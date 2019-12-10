insert into tbl_colegiado values 
	(null, 'Departamento de Ciências Exatas e Tecnológicas', 'DCET'),
	(null, 'Departamento de Filosofia e Ciências Humanas', 'DFCH'),
	(null, 'Departamento de Letras e Artes', 'DEPLA')
	;

insert into tbl_cursos values
	(null, 1, 'Ciência da Computação', 'CC'), -- 1
	(null, 1, 'Engenharia Elétrica', 'EE'), -- 2
	(null, 2, 'Relações Internacionais', 'RI'), -- 3
	(null, 2, 'Ciências Sociais', 'CS'), -- 4
	(null, 3, 'Letras - Português/Inglês', 'LPI'), -- 5
	(null, 3, 'Artes Visuais', 'AV') -- 6
	;


insert into tbl_user values
	-- ALUNOS --
	(null, 'Andre', 'Santos', '11111111111', 1, 'B', 'Pai Andre', 'Mae Andre', 'dre@gmail.com'), -- 1
	(null, 'Jao', 'Santana', '22222222222', 1, 'M', 'Pai Jao', 'Mae Jao', 'jao@gmail.com'), -- 2
	(null, 'Carol', 'Ine', '33333333333', 1, 'F', 'Pai Carol', 'Mae Carol', 'carol@gmail.com'), -- 3
	(null, 'Marcos', 'Oliveira', '44444444444', 1, 'M', 'Pai Marcos', 'Mae Marcos', 'marcos@gmail.com'), -- 4
	(null, 'Elo', 'Ana', '55555555555', 1, 'M', 'Pai Elo', 'Mae Elo', 'elo@gmail.com'), -- 5
	(null, 'Flavio', 'Cutrim', '66666666666', 1, 'M', 'Pai Flavio', 'Mae Flavio', 'flavio@gmail.com'), -- 6
	-- PROFESSORES -- 
	(null, 'Marco', 'Leal', '77777777777', 1, 'M', 'Pai Leal', 'Mae Leal', 'leal@gmail.com'), -- 7
	(null, 'Emanuel', 'Nsei', '88888888888', 1, 'M', 'Pai Emanuel', 'Mae Emanuel', 'emanuel@gmail.com'), -- 8
	(null, 'Luedi', 'Nsei', '99999999999', 1, 'M', 'Pai Luedi', 'Mae Luedi', 'luedi@gmail.com'), -- 9
	(null, 'Lourrene', 'Nsei', '12312312312', 1, 'F', 'Pai Lourrene', 'Mae Lourrene', 'lourrene@gmail.com') -- 10
	;

 -- ALUNOS --
insert into tbl_aluno values
	(null, 1, 1, '2017', 1),
	(null, 2, 1, '2017', 1),
	(null, 3, 3, '2018', 1),
	(null, 4, 3, '2018', 0),
	(null, 5, 3, '2019', 1),
	(null, 6, 2, '2019', 1),
    (null, 1, 1, '2017', 1),
    (null, 2, 1, '2017', 1),
    (null, 3, 3, '2018', 1),
    (null, 4, 3, '2018', 0),
    (null, 5, 3, '2019', 1),
    (null, 6, 2, '2019', 1)
    ;

-- FUNCIONARIOS --
insert into tbl_funcionario values
	(null, 7), -- 1
	(null, 8), -- 2
	(null, 9), -- 3
	(null, 10) -- 4
	;

-- PROFESSORES --
insert into tbl_professor values
	(null, 1, 1, 1), -- 1
	(null, 2, 1, 1), -- 2
	(null, 3, 2, 1), -- 3
	(null, 3, 2, 1)  -- 4
	;

-- DISCIPLINAS --
insert into tbl_disciplina values
	(null, 0, 'Banco de Dados I', 90, 30), -- 1
	(null, 1, 'Banco de Dados II', 90, 30), -- 2
	(null, 0, 'Arquitetura de Computadores', 60, 30), -- 3
	(null, 0, 'Organização de Computadores', 60, 30), -- 4
	(null, 0, 'Teoria das Relações Internacionais', 90, 30), -- 5
	(null, 0, 'Política Internacional', 60, 30) -- 6
	;

-- VINCULA DISCIPLINA A UM CURSO --
insert into tbl_curso_discip values
	(null, 1, 1),
	(null, 1, 2),
	(null, 1, 3),
	(null, 1, 4),
	(null, 3, 5),
	(null, 3, 6)
	;

-- VINCULA PROFESSOR A UMA DISCIPLINA --
insert into tbl_prof_disc values
	(null, 1, 3),
	(null, 1, 4),
	(null, 2, 1),
	(null, 2, 2),
	(null, 3, 5),
	(null, 4, 6)
	;

-- INSERE SEMESTRE --
insert into tbl_semestre values
	(null, '2017.1', '2017-02-01', '2017-06-30'),
	(null, '2017.2', '2017-08-03', '2017-12-14'),
	(null, '2018.1', '2018-02-14', '2018-07-03'),
	(null, '2018.2', '2018-08-07', '2018-12-19'),
	(null, '2019.1', '2019-02-07', '2019-06-28'),
	(null, '2019.2', '2019-07-29', '2019-12-10')
	;

-- OFERTA DISCIPLINAS NO SEMESTRE --
insert into tbl_disc_semestre values
	(null, 1, 1, 2),
	(null, 2, 2, 2),
	(null, 3, 1, 1),
	(null, 4, 2, 1),
	(null, 5, 4, 3),
	(null, 6, 5, 4)
	;

-- MATRICULA ALUNO NUMA DISCIPLINA --
insert into tbl_disc_hist values
	(null, 0, 1, 1),
	(null, 1, 3, 1),
	(null, 1, 4, 1),
	(null, 1, 2, 2),
	(null, 0, 3, 2),
	(null, 1, 5, 3),
	(null, 0, 6, 3),
	(null, 0, 6, 5)
	;
	
-- -----------------------------------------------------
-- inserindo enderecos
-- -----------------------------------------------------

insert into tbl_uf
VALUES
(null, 'AP', 'Amapá'),  						-- 1
(null, 'PA', 'Pará'),								-- 2
(null, 'RS', 'Rio Grande do Sul'),	-- 3
(null, 'SP', 'São Paulo'),					-- 4
(null, 'RJ', 'Rio de Janeiro'),			-- 5
(null, 'PG', 'Praga'),							-- 6
(null, 'VN', 'Viena');							-- 7

insert into tbl_cidades
VALUES
(null,'Macapá',1, null, null),					-- 1
(null,'Santana',1, null, null),					-- 2
(null,'Laranjal do Jari',1, null, null),-- 3
(null,'Afuá',2, null, null),						-- 4
(null,'Belém',2, null, null),						-- 5	
(null,'Bragança',2, null, null),				-- 6
(null,'Gramado',3, null, null),					-- 7
(null,'Canela',3, null, null),					-- 8
(null,'Bauru',4, null, null),						-- 9
(null,'Angra dos Reis',5, null, null);	-- 10

insert into tbl_bairros
VALUES
(null,1,'689003000','Zerão','00003'),						-- 1
(null,1,'68904000','Jesus de Nazaré','00004'),	-- 2
(null,1,'68905000','Novo Buritizal','00005'),		-- 3
(null,1,'68906000','Buritizal','00006'),				-- 4
(null,1,'68907000','Congós','00007'),						-- 5
(null,1,'68908000','Santa Rita','00008'),				-- 6
(null,1,'68909000','Novo Horizonte','00009'),		-- 7
(null,1,'68910000','Centro', '00010'),					-- 8
(null,1,'68911000','Nova Esperança', '00011'),	-- 9
(null,1,'68912000','Novo Horizonte', '00012'),	-- 10
(null,2,'69903000','Paraíso','00013'),					-- 11
(null,2,'69904000','Fonte Nova','00014'),				-- 12
(null,2,'69905000','Central','00015'),					-- 13
(null,2,'69906000','Hospitalidade','00016'),		-- 14
(null,2,'69907000','Vila Amazonas','00017'),		-- 15
(null,2,'69908000','Nova Esperança', '00018'),	-- 16
(null,3,'70903000','Centro', '00019'),					-- 17
(null,3,'70904000','Cidade Velha','00020'),			-- 18
(null,3,'70905000','Condor','00021');						-- 19

insert into tbl_logradouro
values
(null, 'Rua', null),				-- 1
(null, 'Avenida', null),		-- 2
(null, 'Vila', null),				-- 3
(null, 'Fazenda', null),		-- 4
(null, 'Condomínio', null);	-- 5

insert into tbl_cep
values
(null,'68903633'),	-- 1
(null,'68904644'),	-- 2
(null,'68905655'),	-- 3
(null,'68906666'),	-- 4
(null,'68907677'),	-- 5
(null,'68908688'),	-- 6
(null,'68909699'),	-- 7
(null,'68910610'),	-- 8
(null,'68911611'),	-- 9
(null,'68912612'),	-- 10
(null,'69903633'),	-- 11
(null,'69904644'),	-- 12
(null,'69905655'),	-- 13
(null,'69906666'),	-- 14
(null,'69907677'),	-- 15
(null,'69908688'),	-- 16
(null,'70903633'),	-- 17
(null,'70904644'),	-- 18
(null,'70905655');	-- 19

insert into tbl_rua
values
(null, 'Inpetor Monônio Saideira', 1, 1, 1),	-- 1
(null, 'Manjedoura', 2, 4, 2),								-- 2
(null, 'Sengós', 5, 5, 5),										-- 3
(null, 'No Meio', 8, 2, 8),									-- 4
(null, 'Star Wars IV', 16, 3, 16),						-- 5
(null, 'Gente Boa', 14, 3, 14),							-- 6
(null, 'Ilha Paraíso', 15, 4, 15),						-- 7
(null, 'No Meio', 17, 1, 17),								-- 8
(null, 'Abrigo', 18, 1, 18),									-- 9
(null, 'Sendor', 19, 2, 19);										-- 10

insert into tbl_end
values
(null, 1,1,'1231', null),
(null, 2,2,'3213', null),
(null, 7,3,'4564', null),
(null, 5,4,'6546', null),
(null, 4,5,'7897', null),
(null, 6,6,'9879', null),
(null, 3,7,'7417', null),
(null, 8,8,'1471', null),
(null, 10,9,'2582', null),
(null, 9,10,'8528', null);

-- -----------------------------------------------------
-- inserindo formacoes
-- -----------------------------------------------------
insert into tbl_nivel_formacao
values
(null, 'Bacharelado'),
(null, 'Mestrado'),
(null, 'Doutorado'),
(null, 'Licenciatura');

insert into tbl_nome_formacao
values
(null, 'Ciência da Computação'),
(null, 'Engenharia Elétrica'),
(null, 'Relações Internacionais'),
(null, 'Ciências Sociais'),
(null, 'Letras - Português/Inglês'),
(null, 'Artes Visuais');

insert into tbl_formacao_funcionario
values
(null, 1, 2, 2),
(null, 2, 1, 3),
(null, 3, 1, 3),
(null, 4, 1, 4);