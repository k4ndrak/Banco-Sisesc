
-- -----------------------------------------------------
-- Schema sistema_escola
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sistema_escola` ;

-- -----------------------------------------------------
-- Schema sistema_escola
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_escola` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `sistema_escola` ;

-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_colegiado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_colegiado` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_colegiado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_colegiado` VARCHAR(50) NOT NULL,
  `cod_colegiado` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_cursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_cursos` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_cursos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_coleg_curso` INT(11) NOT NULL,
  `nome_curso` VARCHAR(50) NOT NULL,
  `cod_curso` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  
  
    FOREIGN KEY (`fk_coleg_curso`)
    REFERENCES `sistema_escola`.`tbl_colegiado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_user` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_user` VARCHAR(30) NOT NULL,
  `sobrenome_user` VARCHAR(30) NOT NULL,
  `cpf_user` VARCHAR(11) NOT NULL UNIQUE,
  `status_user` TINYINT(1) NOT NULL default 1,
  `sexo_user` CHAR(1) NOT NULL,
  `pai_user` VARCHAR(60) NOT NULL,
  `mae_user` VARCHAR(60) NOT NULL,
  `email_user` VARCHAR(90) NOT NULL,
  `data_criação` TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_aluno` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_aluno` (
  `matricula` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_user_aluno` INT(11) NOT NULL,
  `fk_curso_aluno` INT(11) NOT NULL,
  `ano_inicio` INT(4) NULL DEFAULT NULL,
  `status_matricula` TINYINT(1) NOT NULL DEFAULT 3,
  PRIMARY KEY (`matricula`),  
    FOREIGN KEY (`fk_curso_aluno`)
    REFERENCES `sistema_escola`.`tbl_cursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_user_aluno`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_disciplina` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_disciplina` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_depende_discipl` INT(11) NOT NULL,
  `nome_discipl` VARCHAR(50) NOT NULL,
  `carga_hora_disc` INT(11) NOT NULL,
  `num_aluno_disc` INT(11) NOT NULL DEFAULT 30,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_uf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_uf` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_uf` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `UF` VARCHAR(5) NOT NULL,
  `UF_DESCRICAO` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_cidades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_cidades` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_cidades` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `CID_DESCRICAO` VARCHAR(50) NULL DEFAULT NULL,
  `id_FK` INT(11) NOT NULL,
  `DRS_ID` VARCHAR(50) NULL DEFAULT NULL,
  `CID_NUM_IBGE` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  
  
    FOREIGN KEY (`id_FK`)
    REFERENCES `sistema_escola`.`tbl_uf` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_bairros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_bairros` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_bairros` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_FK` INT(11) NOT NULL,
  `CEP` VARCHAR(50) NOT NULL,
  `BAIRRO` VARCHAR(50) NOT NULL,
  `IBGE` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  
  
    FOREIGN KEY (`id_FK`)
    REFERENCES `sistema_escola`.`tbl_cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_curso_discip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_curso_discip` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_curso_discip` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_curso` INT(11) NOT NULL,
  `fk_discip` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_curso`)
    REFERENCES `sistema_escola`.`tbl_cursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_discip`)
    REFERENCES `sistema_escola`.`tbl_disciplina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_funcionario` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_user` INT NOT NULL UNIQUE,
  PRIMARY KEY (`id`),
  
  
    FOREIGN KEY (`fk_user`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_professor` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_professor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_func_prof` INT(11) NOT NULL,
  `fk_coleg_prof` INT(11) NOT NULL,
  `status_prof` INT(11) NOT NULL default 1,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_coleg_prof`)
    REFERENCES `sistema_escola`.`tbl_colegiado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_func_prof`)
    REFERENCES `sistema_escola`.`tbl_funcionario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_prof_disc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_prof_disc` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_prof_disc` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_professor` INT(11) NOT NULL,
  `fk_discip_prof` INT(11) NOT NULL,
  PRIMARY KEY (`id`),  
    FOREIGN KEY (`fk_discip_prof`)
    REFERENCES `sistema_escola`.`tbl_disciplina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,  
    FOREIGN KEY (`fk_professor`)
    REFERENCES `sistema_escola`.`tbl_professor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_semestre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_semestre` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_semestre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_disc_semestre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_disc_semestre` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_disc_semestre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_disc` INT NOT NULL,
  `fk_semestre` INT NOT NULL,
  `fk_professor` INT NOT NULL,
  `status_disc_semestre` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_disc`)
    REFERENCES `sistema_escola`.`tbl_disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_semestre`)
    REFERENCES `sistema_escola`.`tbl_semestre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_professor`)
    REFERENCES `sistema_escola`.`tbl_professor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_historico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_historico` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_historico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_aluno_hist` INT(11) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  
  
    FOREIGN KEY (`fk_aluno_hist`)
    REFERENCES `sistema_escola`.`tbl_aluno` (`matricula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_disc_hist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_disc_hist` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_disc_hist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `status` TINYINT(1) NOT NULL default 1,
  `fk_disc_semestre` INT(11) NOT NULL,
  `fk_hist` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_disc_semestre`)
    REFERENCES `sistema_escola`.`tbl_disc_semestre` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_hist`)
    REFERENCES `sistema_escola`.`tbl_historico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_logradouro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_logradouro` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_logradouro` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `LOGRAD_DESCRICAO` VARCHAR(15) NOT NULL,
  `LOGRAD` VARCHAR(7),
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_cep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_cep` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_cep` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_rua`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_rua` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_rua` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `fk_bairro` INT NOT NULL,
  `fk_logradouro` INT NOT NULL,
  `fk_cep` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_bairro`)
    REFERENCES `sistema_escola`.`tbl_bairros` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_logradouro`)
    REFERENCES `sistema_escola`.`tbl_logradouro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_cep`)
    REFERENCES `sistema_escola`.`tbl_cep` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_end`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_end` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_end` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_user_end` INT(11) NOT NULL,
  `fk_rua` INT(11) NOT NULL,
  `n_casa` VARCHAR(15) NOT NULL,
  `complemento` VARCHAR(20),
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_user_end`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_rua`)
    REFERENCES `sistema_escola`.`tbl_rua` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_tipo_tel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_tipo_tel` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_tipo_tel` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_tel` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_tel_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_tel_user` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_tel_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_user_tel` INT(11) NOT NULL,
  `fk_tipo_tel` INT(11) NOT NULL,
  `numero_tel_user` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_tipo_tel`)
    REFERENCES `sistema_escola`.`tbl_tipo_tel` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`fk_user_tel`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_nota_disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_nota_disciplina` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_nota_disciplina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nota` DOUBLE NOT NULL,
  `fk_disc_hist` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_disc_hist`)
    REFERENCES `sistema_escola`.`tbl_disc_hist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_nivel_formacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_nivel_formacao` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_nivel_formacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_nome_formacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_nome_formacao` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_nome_formacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_formacao_funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_formacao_funcionario` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_formacao_funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_funcionario` INT NOT NULL,
  `fk_nivel_formacao` INT NOT NULL,
  `fk_nome_formacao` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_funcionario`)
    REFERENCES `sistema_escola`.`tbl_funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_nivel_formacao`)
    REFERENCES `sistema_escola`.`tbl_nivel_formacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_nome_formacao`)
    REFERENCES `sistema_escola`.`tbl_nome_formacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_frequencia_disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_frequencia_disciplina` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_frequencia_disciplina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frequencia` TINYINT NOT NULL,
  `fk_disc_hist` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_disc_hist`)
    REFERENCES `sistema_escola`.`tbl_disc_hist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_login` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NOT NULL,
  `passwd` VARCHAR(45) NOT NULL,
  `fk_usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_permissao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_permissao` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_permissao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
;

-- -----------------------------------------------------
-- Table `sistema_escola`.`tbl_user_permissao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema_escola`.`tbl_user_permissao` ;

CREATE TABLE IF NOT EXISTS `sistema_escola`.`tbl_user_permissao` (
  `id` INT NOT NULL,
  `fk_permissao` INT NOT NULL,
  `fk_user` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_permissao`)
    REFERENCES `sistema_escola`.`tbl_permissao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`fk_user`)
    REFERENCES `sistema_escola`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ;

