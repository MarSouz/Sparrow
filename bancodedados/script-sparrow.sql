create database Sparrow;
use Sparrow;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(45) NULL,
  `nome_representante` VARCHAR(45) NULL,
  `email_contato` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  PRIMARY KEY (`id`));

INSERT INTO empresa VALUES (default, "Sparrow", "Dominique", "sparrow@gmail.com", 12345678912345);


CREATE TABLE IF NOT EXISTS `cargo` (
  `id` INT NOT NULL auto_increment,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
;

INSERT INTO cargo VALUES (default, "Administrador");
INSERT INTO cargo VALUES (default, "Analista");

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `senha` VARCHAR(45) NULL,
  `empresa_id` INT NOT NULL,
  `cargo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_funcionario_empresa1`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `Sparrow`.`cargo` (`id`)
    );

INSERT INTO funcionario VALUES (default, "Dominique Falcone Dornan", "dominique.dornan@sptech.school", "sparrow", 1, 1);

CREATE TABLE IF NOT EXISTS `tipo_maquina` (
  `idtipo_maquina` INT NOT NULL auto_increment,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo_maquina`)
  );

INSERT INTO tipo_maquina VALUES (default, "Servidor");
INSERT INTO tipo_maquina VALUES (default, "Terminal");


CREATE TABLE IF NOT EXISTS `maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_empresa` INT NOT NULL,
  `fk_tipo_maquina` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_servidor_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_maquina_tipo_maquina1`
    FOREIGN KEY (`fk_tipo_maquina`)
    REFERENCES `Sparrow`.`tipo_maquina` (`idtipo_maquina`)
    );


CREATE TABLE IF NOT EXISTS `tipo_componente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_componente` VARCHAR(45) NULL,
  `unidade_medida` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
;

INSERT INTO tipo_componente VALUES (default, "CPU", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "RAM", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Disco", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Placa de Rede", "Inteiro");


CREATE TABLE IF NOT EXISTS `maquina_componente` (
  `fk_servidor` INT NOT NULL auto_increment,
  `fk_componente_servidor` INT NOT NULL,
  `limite_componente` INT NULL,
  PRIMARY KEY (`fk_servidor`, `fk_componente_servidor`),
  CONSTRAINT `fk_componentes_servidor_has_servidor_componentes_servidor1`
    FOREIGN KEY (`fk_servidor`)
    REFERENCES `Sparrow`.`tipo_componente` (`id`),
  CONSTRAINT `fk_componentes_servidor_has_servidor_servidor1`
    FOREIGN KEY (`fk_componente_servidor`)
    REFERENCES `Sparrow`.`maquina` (`id`)
    );

CREATE TABLE IF NOT EXISTS `dado_capturado` (
  `id` INT NOT NULL auto_increment,
  `registro_porcentagem` INT NULL,
  `data_hora` DATETIME NULL,
  `fk_servidor` INT NOT NULL,
  `fk_componente_servidor` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_dados_servidor_servidor_componentes1`
    FOREIGN KEY (`fk_servidor` , `fk_componente_servidor`)
    REFERENCES `Sparrow`.`maquina_componente` (`fk_servidor` , `fk_componente_servidor`)
    );

CREATE TABLE IF NOT EXISTS `alerta` (
  `id` INT NOT NULL auto_increment,
  `fk_dado_servidor` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_dado_servidor`),
  CONSTRAINT `fk_alertas_dados_servidor1`
    FOREIGN KEY (`fk_dado_servidor`)
    REFERENCES `Sparrow`.`dado_capturado` (`id`)
    );

CREATE TABLE IF NOT EXISTS `contato` (
  `id_contatos` INT NOT NULL auto_increment,
  `nome_empresa` VARCHAR(45) NULL,
  `nome_representante` VARCHAR(45) NULL,
  `email_contato` VARCHAR(45) NULL,
  `cnpj` CHAR(14) NULL,
  `descricao` VARCHAR(255),
  PRIMARY KEY (`id_contatos`)
  );