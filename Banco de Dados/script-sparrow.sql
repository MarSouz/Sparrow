CREATE DATABASE `Sparrow`;
USE `Sparrow` ;

CREATE TABLE IF NOT EXISTS `Sparrow`.`empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `Sparrow`.`cargo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `Sparrow`.`funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `senha` VARCHAR(45) NULL,
  `fk_empresa` INT NOT NULL,
  `fk_cargo` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_funcionario_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`fk_cargo`)
    REFERENCES `Sparrow`.`cargo` (`id`));


CREATE TABLE IF NOT EXISTS `Sparrow`.`tipo_maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `Sparrow`.`localizacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `latitude` INT NULL,
  `logintude` INT NULL,
  PRIMARY KEY (`id`));
  
  
CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_empresa` INT NOT NULL,
  `fk_tipo_maquina` INT NOT NULL,
  `endereco_mac` CHAR(20) NULL,
  `fk_localizacao` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_servidor_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_maquina_tipo_maquina1`
    FOREIGN KEY (`fk_tipo_maquina`)
    REFERENCES `Sparrow`.`tipo_maquina` (`id`),
  CONSTRAINT `fk_maquina_localizacao1`
    FOREIGN KEY (`fk_localizacao`)
    REFERENCES `Sparrow`.`localizacao` (`id`));
    
    
CREATE TABLE IF NOT EXISTS `Sparrow`.`tipo_componente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_componente` VARCHAR(45) NULL,
  `unidade_medida` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
  
  
CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina_componente` (
  `fk_maquina` INT NOT NULL,
  `fk_componente_maquina` INT NOT NULL,
  `limite_componente` INT NULL,
  PRIMARY KEY (`fk_maquina`, `fk_componente_maquina`),
  CONSTRAINT `fk_componentes_servidor_has_servidor_componentes_servidor1`
    FOREIGN KEY (`fk_maquina`)
    REFERENCES `Sparrow`.`tipo_componente` (`id`),
  CONSTRAINT `fk_componentes_servidor_has_servidor_servidor1`
    FOREIGN KEY (`fk_componente_maquina`)
    REFERENCES `Sparrow`.`maquina` (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`dado_capturado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `registro` INT NULL,
  `data_hora` DATETIME NULL,
  `fk_maquina` INT NOT NULL,
  `fk_componente_maquina` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_dados_servidor_servidor_componentes1`
    FOREIGN KEY (`fk_maquina` , `fk_componente_maquina`)
    REFERENCES `Sparrow`.`maquina_componente` (`fk_maquina` , `fk_componente_maquina`));


CREATE TABLE IF NOT EXISTS `Sparrow`.`alerta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_dado_maquina` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_dado_maquina`),
  CONSTRAINT `fk_alertas_dados_servidor1`
    FOREIGN KEY (`fk_dado_maquina`)
    REFERENCES `Sparrow`.`dado_capturado` (`id`));


-- -----------------------------------------------------
-- Table `Sparrow`.`lead`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`possivel_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));



INSERT INTO empresa VALUES (default, "Sparrow", "Dominique", "sparrow@gmail.com", 12345678912345);
INSERT INTO empresa VALUES (default, "Governo", "Prefeito", "prefeito@gmail.com", 12345678912345);
select * from funcionario;

INSERT INTO cargo VALUES (default, "Administrador");
INSERT INTO cargo VALUES (default, "Analista");

INSERT INTO funcionario VALUES (default, "Dominique Falcone Dornan", "dominique.dornan@sptech.school", "sparrow", 1, 1);
INSERT INTO funcionario VALUES (default, "Prefeito", "prefeito@gmail.com", "09876", 2, 1);
INSERT INTO funcionario VALUES (default, "Analísta", "analista@gmail.com", "280406", 2, 2);

INSERT INTO tipo_maquina VALUES (default, "Servidor");
INSERT INTO tipo_maquina VALUES (default, "Terminal");

INSERT INTO tipo_componente VALUES (default, "CPU", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "RAM", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Disco", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Pacotes Enviados", "Inteiro");
INSERT INTO tipo_componente VALUES (default, "Pacotes Recebidos", "Inteiro");
SELECT * FROM tipo_componente;

SELECT * FROM maquina_componente;
SELECT * FROM dado_capturado;

INSERT INTO funcionario VALUES (default, "Eduardo Facini Dorval", "eduardo.dorval@sptech.school", "12345", 1, 2);
INSERT INTO possivel_cliente (id, nome_empresa, nome_representante, email_representante, cnpj, descricao) VALUES (DEFAULT,'Governo', 'Prefeito', 'prefeito@gmail.com', '1234567890123', 'Eu quero o radar');

