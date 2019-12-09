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

insert into tbl_turmas values
	(null, 1, 30, '7º', '2017-03-01', '2021-07-01'),
	(null, 2, 30, '3º', '2019-03-01', '2023-08-01'),
	(null, 3, 30, '5º', '2018-03-01', '2022-06-01')
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
	(null, 1, 1, 1, '2017'),
	(null, 2, 1, 1, '2017'),
	(null, 3, 3, 2, '2018'),
	(null, 4, 3, 2, '2018'),
	(null, 5, 3, 3, '2019'),
	(null, 6, 2, 3, '2019')
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
	(null, 1, 1),
	(null, 2, 2),
	(null, 3, 1),
	(null, 4, 2),
	(null, 5, 4),
	(null, 6, 5)
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





















